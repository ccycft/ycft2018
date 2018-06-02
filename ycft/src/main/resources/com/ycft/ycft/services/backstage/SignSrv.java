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
	 * ��ѯǩ���¼���Ӧ����
	 * @param se
	 * @return
	 */
	public List<SignEvent> SigneventUser(SignEvent se){
		return signEventMapper.selSignUser(se);
	}
	
	public boolean exportSignInfo(HttpServletResponse response,int id) {
		//������д������
		WritableWorkbook bWorkbook = null;
		//���������
		OutputStream os = null;
		try {
			SignEvent se = new SignEvent();
			se.setId(id);
			List<SignEvent> sList = SigneventUser(se);
			if(sList!= null && !sList.isEmpty()){
				response.reset();
				//���ñ����ʽ
				response.setContentType("application/vnd.ms-excel"); //��֤������
				String fileName = "ǩ����Ϣ.xls";
				//���ñ����ʽ
				response.setHeader("Content-Disposition", "attachment;"+ " filename="+ new String(fileName.getBytes(), "ISO-8859-1"));
				//��ʼ��
				os = response.getOutputStream();
					//����excel����
					bWorkbook = Workbook.createWorkbook(os);
					//ͨ��excel���󴴽�һ��ѡ�����
					WritableSheet sheet = bWorkbook.createSheet("ѧ����Ϣ", 0);
					//ѭ��������Ϣ
					for(int i = 0;i < sList.get(0).getSignList().size();i++){
						User user = sList.get(0).getSignList().get(0).getUser();
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
	 * ��ѯǩ���¼�������
	 * @return
	 */
	public List<SignEvent> selEvent(SignEvent se){
		List<SignEvent> seList = signEventMapper.selEvent(se);
		for(int i = 0;i<seList.size();i++) {
			//���seList �����id��ǰ̨�����ݴ�������id�Աȣ������ͬ�͵�һ�����ݽ���
			if(seList.get(i).getId() == se.getId()) {
				Collections.swap(seList, 0, i);
			}
		}
		return seList;
	}
	/**
	 * ��ѯ���������ĸ��� �� ����
	 * @author ZHENGBIN
	 * @param user ������ id�󶨵���sign_event��id
	 * @return int
	 */
	public int signSel(User user) {
		//�����""���ʾΪûѡ���������ѯ
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
	 * ����������ѯ�û��� �� ��ĸ
	 * @author ZHENGBIN
	 * @param user ������id�󶨵���sign_event��id
	 * @return int
	 */
	public int signSelUser(User user) {
		//�����""���ʾΪûѡ���������ѯ
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
