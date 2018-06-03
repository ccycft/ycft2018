package com.ycft.ycft.services.backstage;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.RoleMapper;
import com.ycft.ycft.mapper.UserMapper;
import com.ycft.ycft.mapper.UserRoleMapper;
import com.ycft.ycft.po.Role;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.InitService;
import com.ycft.ycft.tools.BeanUtil;
import com.ycft.ycft.tools.MD5;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.Label;
@Service(value="BSUserSer")
public class UserSrv {

	@Autowired
	private UserMapper um;
	@Autowired
	private UserRoleMapper urm;
	@Autowired
	private RoleMapper rm;
	
	/**
	 * ��¼���ж�
	 * �ɹ������Ϣ�浽session��
	 * @author ZHENGBIN
	 * @param sno
	 * @param psd
	 * @return boolean
	 */
	public boolean userAjax(String sno,String psd,HttpServletRequest request) {
		boolean flag = false;
		//md5����
		psd = MD5.md5Password(psd);
		User user = um.bsLogin(sno);
		//��Ϊmd5��֧�ֽ�������ֻ���������������м���Ȼ������ݿ����������жԱ�
		if (user.getPsd().equals(psd)) {
			flag = true;
			//���û���Ϣ�洢��session
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			InitService init =  (InitService)BeanUtil.getBean("InitService");
			try {
				//��¼֮�����»���˵�
				init.cacheMenu(user);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	/**
	 * ���һ���û�
	 * @author ���ٸ�
	 * @param user
	 * @return
	 */
	public boolean addOneUser(User user) {
		boolean flag = false;
		//���������
		String psd = MD5.md5Password(user.getPsd());
		user.setPsd(psd);
		//ѡ���Բ�����Ϣ
		int returnFlag = um.insertSelective(user);
		if(returnFlag > 0) {
			flag = true;
		}
		return flag;
	}
	//���ص���ģ��
	public void downloadDemo(HttpServletResponse response , HttpServletRequest request){
		//demo�ļ�������
		String fileName = "stuDemo.xls";
		//ģ���ļ����ڵľ���λ��
		String filepath = request.getSession().getServletContext().getRealPath("/") + "backstage/" + "demo/" +fileName;
		//�����ļ�����
		File file = new File(filepath);
		//�����������������
        InputStream inputStream = null;
        OutputStream outputStream = null;
        //���������
        byte[] buffer = new byte[1024];
        int len = 0;
        try { 
        	//ʵ��������
            inputStream = new FileInputStream(file);  
            outputStream = response.getOutputStream();  
            response.setContentType("application/force-download");  
            //�ļ����ͽ�ԭ��������
            String filename = file.getName();  
            //���ñ����ʽ
            response.addHeader("Content-Disposition","attachment; filename=" + URLEncoder.encode(filename, "UTF-8"));  
            response.setContentLength( (int) file.length( ) );  
             
            //ѭ��д���ļ�
            while((len = inputStream.read(buffer)) != -1){  
                outputStream.write(buffer, 0, len);  
            }  
        } catch (Exception e) {
            e.printStackTrace();  
        }finally {
        	//�ر�������������ǿղŹر�
            if(inputStream != null) {  
                try {  
                    inputStream.close();  
                    inputStream = null;  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
            if(outputStream != null) {  
                try {  
                    outputStream.close();  
                    outputStream = null;  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }
		
	}
		
	/**
	 * ����excel
	 * @author ���ٸ�
	 * @param response
	 * @return
	 */
	public boolean exportExcel(HttpServletResponse response){
		//������д������
		WritableWorkbook bWorkbook = null;
		//���������
		OutputStream os = null;
		try {
			//��ѯ����ѧ����Ϣ
			List<User> uList =  um.selAll();
			//�ж����ݲ�Ϊ��
			if(uList!= null && !uList.isEmpty()){
				response.reset();
				//���ñ����ʽ
				response.setContentType("application/vnd.ms-excel"); //��֤������
				String fileName = "ѧ����Ϣ.xls";
				//���ñ����ʽ
				response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
				//��ʼ��
				os = response.getOutputStream();
					//����excel����
					bWorkbook = Workbook.createWorkbook(os);
					//ͨ��excel���󴴽�һ��ѡ�����
					WritableSheet sheet = bWorkbook.createSheet("ѧ����Ϣ", 0);
					//ѭ��������Ϣ
					for(int i = 0;i < uList.size();i++){
						User user = uList.get(i);
						//��ʼ���Ʊ�ͷ
						sheet.addCell(new Label(0, 0, "ѧ��")); 
		                sheet.addCell(new Label(1, 0, "����"));
		                sheet.addCell(new Label(2, 0, "�绰"));
		                sheet.addCell(new Label(3, 0, "У��"));
		                sheet.addCell(new Label(4, 0, "ѧԺ"));
		                sheet.addCell(new Label(5, 0, "ϵ"));
		                sheet.addCell(new Label(6, 0, "רҵ"));
		                sheet.addCell(new Label(7, 0, "�༶"));
		               
		                //��ʼ������������
		                sheet.addCell(new Label(0, i + 1,  user.getSno()));
		                sheet.addCell(new Label(1, i + 1,  user.getSname()));
		                sheet.addCell(new Label(2, i + 1,  user.getTel()));
		                sheet.addCell(new Label(3, i + 1,  user.getSchool()));
		                sheet.addCell(new Label(4, i + 1,  user.getCollege()));
		                sheet.addCell(new Label(5, i + 1,  user.getDepartment()));
		                sheet.addCell(new Label(6, i + 1,  user.getProfession()));
		                sheet.addCell(new Label(7, i + 1,  user.getCls()));
					}
			            bWorkbook.write();
				} 
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {  //�ر���
			try {
				//�ر�
				if(bWorkbook != null){
					bWorkbook.close();
				}
				if(os != null){
					os.close();
				}
			} catch (WriteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
             
        }
	}
	/**
	 * ����excel�ļ��������ʱ��������ظ�������Ҳ����뵽���ݿ��У����ǻ���ظ���ɾ����ʹ��������
	 * @author ���ٸ�
	 * @param file Excel�ļ�
	 * @return
	 */
	public boolean importExcelAffairs(MultipartFile file) throws Exception{
		boolean flag = false;
		//������
		InputStream input = null;
		try {
			//��ȡ�ļ��е���
			input = file.getInputStream();
	        Workbook bWorkbook = null;  
	        //������
	        bWorkbook = Workbook.getWorkbook(input);
	        // ��õ�һ�����������
	        Sheet sheet = bWorkbook.getSheet(0);   
	        	int rows = sheet.getRows();
	        	//�����洢excel������������
	        	List<User> uList = new ArrayList<User>();
	        	//ѭ�������ݷ���uList����
	            for(int i = 1;i < rows;i++) {
	            	User user = new User();
	            	//ѧ��
	            	Cell cell = sheet.getCell(0, i);
	                String sno = cell.getContents();
	                user.setSno(sno);
	                //����
	            	Cell cell1 = sheet.getCell(1, i);
	                String psd = cell1.getContents();
	                psd = MD5.md5Password(psd);
	                user.setPsd(psd);
	                //����
	            	Cell cell2 = sheet.getCell(2, i);
	                String sname = cell2.getContents();
	                user.setSname(sname);
	                //�绰
	            	Cell cell3 = sheet.getCell(3, i);
	                String tel = cell3.getContents();
	                user.setTel(tel);
	                //У��
	            	Cell cell4 = sheet.getCell(4, i);
	                String school = cell4.getContents();
	                user.setSchool(school);
	                //ѧԺ
	            	Cell cell5 = sheet.getCell(5, i);
	                String college = cell5.getContents();
	                user.setCollege(college);
	                //ϵ
	            	Cell cell6 = sheet.getCell(6, i);
	                String department = cell6.getContents();
	                user.setDepartment(department);
	                //רҵ
	            	Cell cell7 = sheet.getCell(7, i);
	                String profession = cell7.getContents();
	                user.setProfession(profession);
	                //�༶
	            	Cell cell8 = sheet.getCell(8, i);
	                String cls = cell8.getContents();
	                user.setCls(cls);
	                //װ��
	                uList.add(user);
	            }
	            //ִ�в������
	            int temp = um.batchInsert(uList);
	            if(temp >=1) {
	            	flag = true;
	            }
	            //ɾ���ظ���ѧ����Ϣ
	            um.delRepeat();
	            return flag;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}finally{
			if(input != null){
				input.close();
			}
		}
	}
		
	/**
	 * ��ѯ����ѧ������Ϣ����������������Ա
	 * @author ZHENGBIN
	 * @return List<User>
	 */
	public List<User> selAll(){
		List<User> uList = um.selAll();
		return uList;
	}
	
	/**
	 * ɾ������
	 * @author ZHENGBIN
	 * @param id
	 * @return boolean
	 */
	public boolean del(int id) {
		boolean flag = false;
		//ɾ���ɹ��󷵻�ture
		if (um.deleteByPrimaryKey(id) > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * @author ZHENGBIN
	 * @param user ������
	 * @param role ������
	 * @return boolean
	 */
	public boolean updateAffairs(User user,Role role) {
		boolean flag = false;
		int resultOne = 0;
		int resultTwo = 0;
		//�������""��ʾΪδ�޸�����
		if (user.getPsd() == "") {
			user.setPsd(null);
		} else {
			//����޸���������md5���ܴ��ȥ
			user.setPsd(MD5.md5Password(user.getPsd()));
		}
		//������޸�Ȩ��
		if (role.getRname().equals("��ѡ���޸�")) {
			
		} else {
			//�޸���Ȩ�����ȡ��Ȩ�޵�id�浽user_role
			int rId = selByRnameRole(role).getId();
			resultOne = urm.updateByUid(rId, user.getId());
			if (resultOne >0) {
				flag = true;
			}
		}
		resultTwo = um.updateByPrimaryKeySelective(user);
		if (resultTwo > 0) {
			flag = true;
		} else {
			flag = false;
		}
		
		return flag;
	}
	/**
	 * ͨ��Rname��
	 * @author ZHENGBIN
	 * @param role ������
	 * @return Role
	 */
	public Role selByRnameRole(Role role) {
		return rm.selByRname(role.getRname());
	}
	
	/**
	 * ��ѯ����ʲô�༶
	 * @author ZHENGBIN
	 * @return List<User>
	 */
	public List<User> selCls(){
		return um.selCls();
	}
}
