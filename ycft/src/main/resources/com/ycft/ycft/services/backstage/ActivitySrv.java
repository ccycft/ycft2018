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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.ActivityMapper;
import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.mapper.UserMapper;
import com.ycft.ycft.po.Activity;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.po.User;
import com.ycft.ycft.tools.DateUtil;
import com.ycft.ycft.tools.UploadUtil;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@Service
public class ActivitySrv {

	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	@Autowired
	private UserMapper um;
	@Autowired
	private ActivityMapper am;
	
	/**
	 * �����ѯȫ��֪ͨ
	 * @author ZHENGBIN
	 * @return List<TitleContent>
	 */
	public List<TitleContent> selAllActivity(){
		return tm.selAllByType(3);
	}
	/**
	 * ���֪ͨ��Ϣ
	 * @author ZHENGBIN
	 * @param request
	 * @param content ���ݱ�
	 * @param title	�����
	 * @param titleFile �����ͼƬ
	 * @return boolean
	 * @throws IOException 
	 */
	public boolean addActivityAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
		boolean flag = false;
		String imgNamePath  = "";
		if(!titleFile.isEmpty()) {
			//�ϴ�ͼƬ
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {//��Ĭ�ϵ�ͼƬ������ݿ���
			imgNamePath = "/logo.png";
		}
		//��װ�õ�ʱ���ʽ
		title.setTime(DateUtil.getNowDate());
		//��session�л�ȡuser
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		//3Ϊ�
		title.setType(3);
		//��ȡһ�»�ȡͼƬ��
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		//�������
		tm.insertTitle(title);
		content.setTid(title.getId());
		int result = contentMapper.insertSelective(content);
		//�������0Ϊ�����ɹ�
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * ɾ��
	 * @author ZHENGBIN
	 * @param id 
	 * @return boolean
	 */
	public boolean del(int id) {
		boolean flag = false;
		
		int result = tm.deleteByPrimaryKey(id);
		//ɾ���ɹ������0
		if (result > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	/**
	 * ͨ��id�����ѯ
	 * @author ZHENGBIN
	 * @param id
	 * @return TitleContent
	 */
	public TitleContent selAllActivityById(int id) {
				
		return tm.selAllByTypeAndId(3, id);
	}
	
	/**
	 * �޸�֪ͨ�ı����������Ϣ
	 * @author ZHENGBIN
	 * @param request
	 * @param title ������
	 * @param content ������
	 * @return boolean
	 */
	public boolean updActivity(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		boolean flag = false;
		String imgNamePath  = "";
		if(!updFile.isEmpty()) {
			//�ϴ�ͼƬ
			try {
				//�õ�����ͼƬ��·��
				imgNamePath = UploadUtil.commonUpload(request, updFile);
				//��ȡ��ȡͼƬ��
				String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
				title.setImgName(imgName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//�����޸�ʱ��
		title.setTime(DateUtil.getNowDate());
		//��ȡ�û���Ϣ
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		
		int resultOne = tm.updateByPrimaryKeySelective(title);
		int resultTwo = contentMapper.updateByTid(content);
		//ֻ���������޸ĳɹ��򷵻�true
		if (resultOne > 0&& resultTwo > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	/**
	 * ���ص���ģ��
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	public void downloadActivityDemo(HttpServletResponse response , HttpServletRequest request){
		//demo�ļ�������
		String fileName = "activityDemo.xls";
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
	 * ����excel�ļ�
	 * @author ZHENGBIN
	 * @param file Excel�ļ�
	 * @param activity ��tid�󶨹������ǰ󶨵�id���ˡ�����
	 * @throws Exception
	 * @return boolean
	 */
	public boolean importActivityExcelAffairs(MultipartFile file,Activity activity) throws Exception{
		InputStream input = null;
		try {
			input = file.getInputStream();
	        Workbook bWorkbook = null;  
	        	
	        bWorkbook = Workbook.getWorkbook(input);
	        // ��õ�һ�����������
	        Sheet sheet = bWorkbook.getSheet(0);   
        	int rows = sheet.getRows();
        	List<Activity> aList = new ArrayList<Activity>();
            for(int i = 1;i < rows;i++){
            	Activity activity2 = new Activity();
            	//��ȡ������ѧ��
            	Cell cell = sheet.getCell(0, i);
                String sno = cell.getContents();
                User user = um.bsLogin(sno);
                //ѧ������
                if (user.equals(null)) {
                	return false;
                }
                activity2.setUid(user.getId());
                activity2.setTid(activity.getId());
                //װ��
                aList.add(activity2);
            }
            am.batchInsert(aList);
            am.delRepeat();
            return true;    
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
	 * ������Ϣ
	 * @author ZHENGBIN
	 * @param response
	 * @param tid
	 * @return boolean
	 */
	public boolean exportActivityExcel(HttpServletResponse response,int tid){
		
		//������д������
		WritableWorkbook bWorkbook = null;
		OutputStream os = null;
		try {
			//��ѯ����
			List<User> uList =  um.selExport(tid);
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
	                sheet.addCell(new Label(3, 0, "רҵ"));
	                sheet.addCell(new Label(4, 0, "�༶"));
	               
	                //��ʼ������������
	                sheet.addCell(new Label(0, i + 1,  user.getSno()));
	                sheet.addCell(new Label(1, i + 1,  user.getSname()));
	                sheet.addCell(new Label(2, i + 1,  user.getTel()));
	                sheet.addCell(new Label(3, i + 1,  user.getProfession()));
	                sheet.addCell(new Label(4, i + 1,  user.getCls()));
					}
		            bWorkbook.write();
				} 
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}finally {  
				try {
					//�����������رղ��ܷ������򵼳�����ʹ
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
}
