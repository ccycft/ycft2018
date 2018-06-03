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
	 * 登录的判断
	 * 成功后把信息存到session中
	 * @author ZHENGBIN
	 * @param sno
	 * @param psd
	 * @return boolean
	 */
	public boolean userAjax(String sno,String psd,HttpServletRequest request) {
		boolean flag = false;
		//md5加密
		psd = MD5.md5Password(psd);
		User user = um.bsLogin(sno);
		//因为md5不支持解密所以只能用输入的密码进行加密然后和数据库里的密码进行对比
		if (user.getPsd().equals(psd)) {
			flag = true;
			//将用户信息存储到session
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			InitService init =  (InitService)BeanUtil.getBean("InitService");
			try {
				//登录之后重新缓存菜单
				init.cacheMenu(user);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
	/**
	 * 添加一个用户
	 * @author 马荣福
	 * @param user
	 * @return
	 */
	public boolean addOneUser(User user) {
		boolean flag = false;
		//把密码加密
		String psd = MD5.md5Password(user.getPsd());
		user.setPsd(psd);
		//选择性插入信息
		int returnFlag = um.insertSelective(user);
		if(returnFlag > 0) {
			flag = true;
		}
		return flag;
	}
	//下载导入模版
	public void downloadDemo(HttpServletResponse response , HttpServletRequest request){
		//demo文件的名称
		String fileName = "stuDemo.xls";
		//模板文件所在的具体位置
		String filepath = request.getSession().getServletContext().getRealPath("/") + "backstage/" + "demo/" +fileName;
		//创建文件对象
		File file = new File(filepath);
		//声明输入流、输出流
        InputStream inputStream = null;
        OutputStream outputStream = null;
        //创建缓冲池
        byte[] buffer = new byte[1024];
        int len = 0;
        try { 
        	//实例化流，
            inputStream = new FileInputStream(file);  
            outputStream = response.getOutputStream();  
            response.setContentType("application/force-download");  
            //文件名就叫原本的名字
            String filename = file.getName();  
            //设置编码格式
            response.addHeader("Content-Disposition","attachment; filename=" + URLEncoder.encode(filename, "UTF-8"));  
            response.setContentLength( (int) file.length( ) );  
             
            //循环写出文件
            while((len = inputStream.read(buffer)) != -1){  
                outputStream.write(buffer, 0, len);  
            }  
        } catch (Exception e) {
            e.printStackTrace();  
        }finally {
        	//关闭流，如果流不是空才关闭
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
	 * 导出excel
	 * @author 马荣福
	 * @param response
	 * @return
	 */
	public boolean exportExcel(HttpServletResponse response){
		//操作可写工作簿
		WritableWorkbook bWorkbook = null;
		//声明输出流
		OutputStream os = null;
		try {
			//查询所有学生信息
			List<User> uList =  um.selAll();
			//判断数据不为空
			if(uList!= null && !uList.isEmpty()){
				response.reset();
				//设置编码格式
				response.setContentType("application/vnd.ms-excel"); //保证不乱码
				String fileName = "学生信息.xls";
				//设置编码格式
				response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
				//初始化
				os = response.getOutputStream();
					//创建excel对象
					bWorkbook = Workbook.createWorkbook(os);
					//通过excel对象创建一个选项卡对象
					WritableSheet sheet = bWorkbook.createSheet("学生信息", 0);
					//循环绘制信息
					for(int i = 0;i < uList.size();i++){
						User user = uList.get(i);
						//开始绘制表头
						sheet.addCell(new Label(0, 0, "学号")); 
		                sheet.addCell(new Label(1, 0, "姓名"));
		                sheet.addCell(new Label(2, 0, "电话"));
		                sheet.addCell(new Label(3, 0, "校区"));
		                sheet.addCell(new Label(4, 0, "学院"));
		                sheet.addCell(new Label(5, 0, "系"));
		                sheet.addCell(new Label(6, 0, "专业"));
		                sheet.addCell(new Label(7, 0, "班级"));
		               
		                //开始绘制主体内容
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
		}finally {  //关闭流
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
	 * 导入excel文件，导入的时候如果有重复的数据也会插入到数据库中，但是会把重复的删除，使用了事务
	 * @author 马荣福
	 * @param file Excel文件
	 * @return
	 */
	public boolean importExcelAffairs(MultipartFile file) throws Exception{
		boolean flag = false;
		//输入流
		InputStream input = null;
		try {
			//获取文件中的流
			input = file.getInputStream();
	        Workbook bWorkbook = null;  
	        //解析流
	        bWorkbook = Workbook.getWorkbook(input);
	        // 获得第一个工作表对象
	        Sheet sheet = bWorkbook.getSheet(0);   
	        	int rows = sheet.getRows();
	        	//用来存储excel表格里面的数据
	        	List<User> uList = new ArrayList<User>();
	        	//循环把数据放在uList里面
	            for(int i = 1;i < rows;i++) {
	            	User user = new User();
	            	//学号
	            	Cell cell = sheet.getCell(0, i);
	                String sno = cell.getContents();
	                user.setSno(sno);
	                //密码
	            	Cell cell1 = sheet.getCell(1, i);
	                String psd = cell1.getContents();
	                psd = MD5.md5Password(psd);
	                user.setPsd(psd);
	                //姓名
	            	Cell cell2 = sheet.getCell(2, i);
	                String sname = cell2.getContents();
	                user.setSname(sname);
	                //电话
	            	Cell cell3 = sheet.getCell(3, i);
	                String tel = cell3.getContents();
	                user.setTel(tel);
	                //校区
	            	Cell cell4 = sheet.getCell(4, i);
	                String school = cell4.getContents();
	                user.setSchool(school);
	                //学院
	            	Cell cell5 = sheet.getCell(5, i);
	                String college = cell5.getContents();
	                user.setCollege(college);
	                //系
	            	Cell cell6 = sheet.getCell(6, i);
	                String department = cell6.getContents();
	                user.setDepartment(department);
	                //专业
	            	Cell cell7 = sheet.getCell(7, i);
	                String profession = cell7.getContents();
	                user.setProfession(profession);
	                //班级
	            	Cell cell8 = sheet.getCell(8, i);
	                String cls = cell8.getContents();
	                user.setCls(cls);
	                //装入
	                uList.add(user);
	            }
	            //执行插入语句
	            int temp = um.batchInsert(uList);
	            if(temp >=1) {
	            	flag = true;
	            }
	            //删除重复的学生信息
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
	 * 查询所有学生的信息，不包括超级管理员
	 * @author ZHENGBIN
	 * @return List<User>
	 */
	public List<User> selAll(){
		List<User> uList = um.selAll();
		return uList;
	}
	
	/**
	 * 删除功能
	 * @author ZHENGBIN
	 * @param id
	 * @return boolean
	 */
	public boolean del(int id) {
		boolean flag = false;
		//删除成功后返回ture
		if (um.deleteByPrimaryKey(id) > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * @author ZHENGBIN
	 * @param user 参数绑定
	 * @param role 参数绑定
	 * @return boolean
	 */
	public boolean updateAffairs(User user,Role role) {
		boolean flag = false;
		int resultOne = 0;
		int resultTwo = 0;
		//如果等于""表示为未修改密码
		if (user.getPsd() == "") {
			user.setPsd(null);
		} else {
			//如果修改密码则用md5加密存进去
			user.setPsd(MD5.md5Password(user.getPsd()));
		}
		//这代表不修改权限
		if (role.getRname().equals("不选则不修改")) {
			
		} else {
			//修改了权限则获取该权限的id存到user_role
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
	 * 通过Rname查
	 * @author ZHENGBIN
	 * @param role 参数绑定
	 * @return Role
	 */
	public Role selByRnameRole(Role role) {
		return rm.selByRname(role.getRname());
	}
	
	/**
	 * 查询都有什么班级
	 * @author ZHENGBIN
	 * @return List<User>
	 */
	public List<User> selCls(){
		return um.selCls();
	}
}
