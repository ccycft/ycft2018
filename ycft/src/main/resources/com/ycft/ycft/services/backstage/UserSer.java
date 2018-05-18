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

import com.sun.tools.doclint.Checker.Flag;
import com.sun.tools.internal.xjc.generator.bean.ImplStructureStrategy.Result;
import com.ycft.ycft.mapper.UserMapper;
import com.ycft.ycft.po.User;
import com.ycft.ycft.tools.MD5;
import aj.org.objectweb.asm.Label;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@Service(value="BSUserSer")
public class UserSer {

	@Autowired
	private UserMapper um;
	
	public boolean userAjax(String sno,String psd) {
		boolean flag = false;
		psd = MD5.md5Password(psd);
		if (um.bsLogin(sno).getPsd().equals(psd)) {
			flag = true;
		}
		return flag;
	}
	/**
	 * 信息查询[全部查询]
	 * 
	 * @author 
	 * @param wd 
	 * @return List<wddentInfo> 满足条件的信息
	 */
	public List<User> selective(User us){
		
		//选择性查询
		List<User> list = um.selective(us);

		return list;
	}
	
	//下载导入模版
		public void downloadDemo(HttpServletResponse response , HttpServletRequest request){
			//demo文件的名称
			String fileName = "demo.xls";
			String filepath = request.getSession().getServletContext().getRealPath("/") + "demo/" +fileName;
			File file = new File(filepath);  
	        InputStream inputStream = null;  
	        OutputStream outputStream = null;  
	        byte[] b= new byte[1024];  
	        int len = 0;  
	        try {  
	            inputStream = new FileInputStream(file);  
	            outputStream = response.getOutputStream();  
	              
	            response.setContentType("application/force-download");  
	            //文件名就叫原本的名字
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
		 * 导出信息
		 * 
		 * @param User
		 * @param request
		 * @param response
		 */
		public boolean exportExcel(User user,HttpServletResponse response){
			
			//操作可写工作簿
			WritableWorkbook bWorkbook = null;
			OutputStream os = null;
			try {
				//查询所有
				List<User> uList =  selective(user);
				if(uList!= null && !uList.isEmpty()){
					response.reset();
					response.setContentType("application/vnd.ms-excel"); //保证不乱码
					String fileName = "1.xls";
					/* //到第一个值项是attachment，这是真正的关键，设定了这个值，浏览器就会老老实实地显示另存为对话框，如果这个值设成 inline，则无论怎样浏览器都会自动尝试用已知关联的程序打开文件。
					response.addHeader("Content-Disposition","attachment; filename=\""+ new String(fileName.getBytes("gb2312"),"iso8859-1") + "\""); */
					
					response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
					os = response.getOutputStream();
						//创建excel对象
						bWorkbook = Workbook.createWorkbook(os);
						//通过excel对象创建一个选项卡对象
						WritableSheet sheet = bWorkbook.createSheet("用水信息", 0);
						for(int i = 0;i < uList.size();i++){
							
							//开始绘制表头
				/*			sheet.addCell(new Label(0, 0, "用水量")); 
			                sheet.addCell(new Label(1, 0, "地区"));
			                sheet.addCell(new Label(2, 0, "日期"));
			                sheet.addCell(new Label(3, 0, "操作员"));
			                sheet.addCell(new Label(4, 0, "操作时间"));*/
			               
			                //开始绘制主体内容
			           /*     sheet.addCell(new Label(0, i + 1,  uList.get(i).getWaterQuantity()+"") );
			                sheet.addCell(new Label(1, i + 1,  uList.get(i).getArea()) );
			                sheet.addCell(new Label(2, i + 1,  uList.get(i).getDate()));
			                sheet.addCell(new Label(3, i + 1,  uList.get(i).getOperatePeople()) );
			                sheet.addCell(new Label(4, i + 1,  uList.get(i).getOperateDate()) );*/
			                
						}
							// 创建一个单元格对象，第一个为列，第二个为行，第三个为值  
				            //Label label = new Label(0, 2, "test");  
				            // 将创建好的单元格放入选项卡中  
				            //sheet.addCell(label);  
				            // 写如目标路径  
				            bWorkbook.write();
					} 
					return true;
				} catch (Exception e) {
					e.printStackTrace();
					return false;
				}finally {  
					try {
						//关闭
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
		 * 导入excel文件
		 * @param file Excel文件
		 * @return
		 */
		@SuppressWarnings("deprecation")
		public boolean importExcel(MultipartFile file) throws Exception{
			InputStream input = null;
			try {
				input = file.getInputStream();
		        Workbook bWorkbook = null;  
		        	
		        bWorkbook = Workbook.getWorkbook(input);
		        // 获得第一个工作表对象
		        Sheet sheet = bWorkbook.getSheet(0);   
		        	int rows = sheet.getRows();
		        	List<User> uList = new ArrayList<User>();
		            //int columns = sheet.getColumns();
		        	System.out.println("rows==="+rows);
		            for(int i = 1;i < rows;i++){
		            	User user = new User();
		            	//用水量
		            /*	Cell cell = sheet.getCell(0, i);
		                String waterQuantity = cell.getContents();
		                user.setWaterQuantity(Double.parseDouble(waterQuantity));
		                //地区
		            	Cell cell1 = sheet.getCell(1, i);
		                String area = cell1.getContents();
		                user.setArea(area);
		                //时间
		            	Cell cell2 = sheet.getCell(2, i);
		                String date = cell2.getContents();
		                user.setDate(date);
		                //操作人
		            	Cell cell3 = sheet.getCell(3, i);
		                String operatePeople = cell3.getContents();
		                user.setOperatePeople(operatePeople);
		                //操作时间
		            	Cell cell4 = sheet.getCell(4, i);
		                String operateDate = cell4.getContents();
		                user.setOperateDate(operateDate);*/
		                //装入
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
	 * 查询所有学生的信息，不包括超级管理员
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
	public boolean update(User user) {
		boolean flag = false;
		
		int result = um.updateByPrimaryKeySelective(user);
		
		if (result > 0) {
			flag = true;
		}
		
		return flag;
	}
	
}
