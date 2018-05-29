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
	 * 连表查询全部通知
	 * @author ZHENGBIN
	 * @return List<TitleContent>
	 */
	public List<TitleContent> selAllActivity(){
		return tm.selAllByType(3);
	}
	/**
	 * 添加通知信息
	 * @author ZHENGBIN
	 * @param request
	 * @param content 内容表
	 * @param title	标题表
	 * @param titleFile 标题的图片
	 * @return boolean
	 * @throws IOException 
	 */
	public boolean addActivityAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
		boolean flag = false;
		String imgNamePath  = "";
		if(!titleFile.isEmpty()) {
			//上传图片
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {//把默认的图片存进数据库里
			imgNamePath = "/logo.png";
		}
		//封装好的时间格式
		title.setTime(DateUtil.getNowDate());
		//从session中获取user
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		//3为活动
		title.setType(3);
		//截取一下获取图片名
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		//插入标题
		tm.insertTitle(title);
		content.setTid(title.getId());
		int result = contentMapper.insertSelective(content);
		//结果大于0为发不成功
		if (result > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 删除
	 * @author ZHENGBIN
	 * @param id 
	 * @return boolean
	 */
	public boolean del(int id) {
		boolean flag = false;
		
		int result = tm.deleteByPrimaryKey(id);
		//删除成功后大于0
		if (result > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	/**
	 * 通过id连表查询
	 * @author ZHENGBIN
	 * @param id
	 * @return TitleContent
	 */
	public TitleContent selAllActivityById(int id) {
				
		return tm.selAllByTypeAndId(3, id);
	}
	
	/**
	 * 修改通知的标题和内容信息
	 * @author ZHENGBIN
	 * @param request
	 * @param title 参数绑定
	 * @param content 参数绑定
	 * @return boolean
	 */
	public boolean updActivity(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		boolean flag = false;
		String imgNamePath  = "";
		if(!updFile.isEmpty()) {
			//上传图片
			try {
				//得到的是图片的路径
				imgNamePath = UploadUtil.commonUpload(request, updFile);
				//截取获取图片名
				String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
				title.setImgName(imgName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//设置修改时间
		title.setTime(DateUtil.getNowDate());
		//获取用户信息
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		
		int resultOne = tm.updateByPrimaryKeySelective(title);
		int resultTwo = contentMapper.updateByTid(content);
		//只有两个都修改成功则返回true
		if (resultOne > 0&& resultTwo > 0) {
			flag = true;
		}
		
		return flag;
	}
	
	/**
	 * 下载导入模版
	 * @author ZHENGBIN
	 * @param response
	 * @param request
	 */
	public void downloadActivityDemo(HttpServletResponse response , HttpServletRequest request){
		//demo文件的名称
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
	 * 导入excel文件
	 * @author ZHENGBIN
	 * @param file Excel文件
	 * @param activity 将tid绑定过来但是绑定到id上了。。。
	 * @throws Exception
	 * @return boolean
	 */
	public boolean importActivityExcelAffairs(MultipartFile file,Activity activity) throws Exception{
		InputStream input = null;
		try {
			input = file.getInputStream();
	        Workbook bWorkbook = null;  
	        	
	        bWorkbook = Workbook.getWorkbook(input);
	        // 获得第一个工作表对象
	        Sheet sheet = bWorkbook.getSheet(0);   
        	int rows = sheet.getRows();
        	List<Activity> aList = new ArrayList<Activity>();
            for(int i = 1;i < rows;i++){
            	Activity activity2 = new Activity();
            	//获取表格里的学号
            	Cell cell = sheet.getCell(0, i);
                String sno = cell.getContents();
                User user = um.bsLogin(sno);
                //学号有误
                if (user.equals(null)) {
                	return false;
                }
                activity2.setUid(user.getId());
                activity2.setTid(activity.getId());
                //装入
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
	 * 导出信息
	 * @author ZHENGBIN
	 * @param response
	 * @param tid
	 * @return boolean
	 */
	public boolean exportActivityExcel(HttpServletResponse response,int tid){
		
		//操作可写工作簿
		WritableWorkbook bWorkbook = null;
		OutputStream os = null;
		try {
			//查询所有
			List<User> uList =  um.selExport(tid);
			if(uList!= null && !uList.isEmpty()){
				response.reset();
				response.setContentType("application/vnd.ms-excel"); //保证不乱码
				String fileName = "学生信息.xls";
				/* //到第一个值项是attachment，这是真正的关键，设定了这个值，浏览器就会老老实实地显示另存为对话框，如果这个值设成 inline，则无论怎样浏览器都会自动尝试用已知关联的程序打开文件。
				response.addHeader("Content-Disposition","attachment; filename=\""+ new String(fileName.getBytes("gb2312"),"iso8859-1") + "\""); */
				
				response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
				os = response.getOutputStream();
				//创建excel对象
				bWorkbook = Workbook.createWorkbook(os);
				//通过excel对象创建一个选项卡对象
				WritableSheet sheet = bWorkbook.createSheet("学生信息", 0);
				for(int i = 0;i < uList.size();i++){
					User user = uList.get(i);
					//开始绘制表头
					sheet.addCell(new Label(0, 0, "学号")); 
	                sheet.addCell(new Label(1, 0, "姓名"));
	                sheet.addCell(new Label(2, 0, "电话"));
	                sheet.addCell(new Label(3, 0, "专业"));
	                sheet.addCell(new Label(4, 0, "班级"));
	               
	                //开始绘制主体内容
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
					//下面这两个关闭不能反，否则导出不好使
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
