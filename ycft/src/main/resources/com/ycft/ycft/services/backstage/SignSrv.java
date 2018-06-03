package com.ycft.ycft.services.backstage;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ycft.ycft.mapper.SignEventMapper;
import com.ycft.ycft.po.SignEvent;
import com.ycft.ycft.po.User;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@Service
public class SignSrv {
	
	@Autowired
	private SignEventMapper signEventMapper;
	
	/**
	 * 查询签到事件对应的人
	 * @param se
	 * @return
	 */
	public List<SignEvent> SigneventUser(SignEvent se){
		return signEventMapper.selSignUser(se);
	}
	
	public boolean exportSignInfo(HttpServletResponse response,int id) {
		//操作可写工作簿
		WritableWorkbook bWorkbook = null;
		//声明输出流
		OutputStream os = null;
		try {
			SignEvent se = new SignEvent();
			se.setId(id);
			List<SignEvent> sList = SigneventUser(se);
			if(sList!= null && !sList.isEmpty()){
				response.reset();
				//设置编码格式
				response.setContentType("application/vnd.ms-excel"); //保证不乱码
				String fileName = "签到信息.xls";
				//设置编码格式
				response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
				//初始化
				os = response.getOutputStream();
					//创建excel对象
					bWorkbook = Workbook.createWorkbook(os);
					//通过excel对象创建一个选项卡对象
					WritableSheet sheet = bWorkbook.createSheet("学生信息", 0);
					//循环绘制信息
					for(int i = 0;i < sList.get(0).getSignList().size();i++){
						User user = sList.get(0).getSignList().get(0).getUser();
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
	 * 查询签到事件的名称
	 * @return
	 */
	public List<SignEvent> selEvent(SignEvent se){
		List<SignEvent> seList = signEventMapper.selEvent(se);
		for(int i = 0;i<seList.size();i++) {
			//如果seList 里面的id和前台的数据传过来的id对比，如果相同和第一个数据交换
			if(seList.get(i).getId() == se.getId()) {
				Collections.swap(seList, 0, i);
			}
		}
		return seList;
	}
	/**
	 * 查询满足条件的个数 ： 分子
	 * @author ZHENGBIN
	 * @param user 参数绑定 id绑定的是sign_event的id
	 * @return int
	 */
	public int signSel(User user) {
		//如果是""则表示为没选择该条件查询
		if (user.getProfession() == "") {
			user.setProfession(null);
		} 
		if (user.getCollege() == "") {
			user.setCollege(null);
		}
		if (user.getCls() == "") {
			user.setCls(null);
		}
		if (user.getDepartment() == "") {
			user.setDepartment(null);
		}
		return signEventMapper.conditionSel(user);
	}
	
	/**
	 * 根据条件查询用户表 ： 分母
	 * @author ZHENGBIN
	 * @param user 参数绑定id绑定的是sign_event的id
	 * @return int
	 */
	public int signSelUser(User user) {
		//如果是""则表示为没选择该条件查询
		if (user.getProfession() == "") {
			user.setProfession(null);
		} 
		if (user.getCollege() == "") {
			user.setCollege(null);
		}
		if (user.getCls() == "") {
			user.setCls(null);
		}
		if (user.getDepartment() == "") {
			user.setDepartment(null);
		}
		return signEventMapper.conditionSelUser(user);
	}
}
