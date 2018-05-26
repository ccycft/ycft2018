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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.RoleMapper;
import com.ycft.ycft.mapper.UserMapper;
import com.ycft.ycft.mapper.UserRoleMapper;
import com.ycft.ycft.po.Role;
import com.ycft.ycft.po.User;
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
	 * @param sno
	 * @param psd
	 * @return
	 */
	public boolean userAjax(String sno,String psd,HttpServletRequest request) {
		boolean flag = false;
		psd = MD5.md5Password(psd);
		User user = um.bsLogin(sno);
		if (user.getPsd().equals(psd)) {
			flag = true;
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
		}
		return flag;
	}
	/**
	 * ���һ���û�
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
			String filepath = request.getSession().getServletContext().getRealPath("/") + "backstage/" + "demo/" +fileName;
			File file = new File(filepath);
	        InputStream inputStream = null;
	        OutputStream outputStream = null;
	        byte[] b= new byte[1024];
	        int len = 0;
	        try {  
	            inputStream = new FileInputStream(file);  
	            outputStream = response.getOutputStream();  
	              
	            response.setContentType("application/force-download");  
	            //�ļ����ͽ�ԭ��������
	            String filename = file.getName();  
	            
	            response.addHeader("Content-Disposition","attachment; filename=" + URLEncoder.encode(filename, "UTF-8"));  
	            response.setContentLength( (int) file.length( ) );  
	              
	            while((len = inputStream.read(b)) != -1){  
	                outputStream.write(b, 0, len);  
	            }  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }finally{  
	            if(inputStream != null){  
	                try {  
	                    inputStream.close();  
	                    inputStream = null;  
	                } catch (IOException e) {  
	                    e.printStackTrace();  
	                }  
	            }  
	            if(outputStream != null){  
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
		 * ������Ϣ
		 * 
		 * @param User
		 * @param request
		 * @param response
		 */
		public boolean exportExcel(HttpServletResponse response){
			
			//������д������
			WritableWorkbook bWorkbook = null;
			OutputStream os = null;
			try {
				//��ѯ����
				List<User> uList =  um.selAll();
				if(uList!= null && !uList.isEmpty()){
					response.reset();
					response.setContentType("application/vnd.ms-excel"); //��֤������
					String fileName = "ѧ����Ϣ.xls";
					/* //����һ��ֵ����attachment�����������Ĺؼ����趨�����ֵ��������ͻ�����ʵʵ����ʾ���Ϊ�Ի���������ֵ��� inline����������������������Զ���������֪�����ĳ�����ļ���
					response.addHeader("Content-Disposition","attachment; filename=\""+ new String(fileName.getBytes("gb2312"),"iso8859-1") + "\""); */
					
					response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
					os = response.getOutputStream();
						//����excel����
						bWorkbook = Workbook.createWorkbook(os);
						//ͨ��excel���󴴽�һ��ѡ�����
						WritableSheet sheet = bWorkbook.createSheet("ѧ����Ϣ", 0);
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
				}finally {  
					try {
						if(os != null){
							os.close();
						}
						//�ر�
						if(bWorkbook != null){
							bWorkbook.close();
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
		 * ����excel�ļ�
		 * @param file Excel�ļ�
		 * @return
		 */
		public boolean importExcel(MultipartFile file) throws Exception{
			InputStream input = null;
			try {
				input = file.getInputStream();
		        Workbook bWorkbook = null;  
		        	
		        bWorkbook = Workbook.getWorkbook(input);
		        // ��õ�һ�����������
		        Sheet sheet = bWorkbook.getSheet(0);   
		        	int rows = sheet.getRows();
		        	List<User> uList = new ArrayList<User>();
		            //int columns = sheet.getColumns();
		        	System.out.println("rows==="+rows);
		            for(int i = 1;i < rows;i++){
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
		            return um.batchInsert(uList) >= 1 ? true : false;    
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
	 * @return uList
	 */
	public List<User> selAll(){
		List<User> uList = um.selAll();
		return uList;
	}
	
	/**
	 * @param id
	 * @return boolean
	 */
	public boolean del(int id) {
		boolean flag = false;
		System.out.println("-++"+id);
		if (um.deleteByPrimaryKey(id) > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * @return flag
	 */
	public boolean updateAffairs(User user,Role role) {
		boolean flag = false;
		int resultOne = 0;
		int resultTwo = 0;
		//�������""��ʾΪδ�޸�����
		if (user.getPsd() == "") {
			user.setPsd(null);
		} else {
			user.setPsd(MD5.md5Password(user.getPsd()));
		}
		//������޸�Ȩ��
		if (role.getRname().equals("��ѡ���޸�")) {
			
		} else {
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
	 * @param role
	 * @return
	 */
	public Role selByRnameRole(Role role) {
		System.out.println("----"+role.getRname());
		System.out.println(rm.selByRname(role.getRname()));
		return rm.selByRname(role.getRname());
	}
	
}
