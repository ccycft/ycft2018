package com.ycft.ycft.services.backstage;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.mapper.TitleMapper;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Title;
import com.ycft.ycft.po.TitleContent;
import com.ycft.ycft.po.User;
import com.ycft.ycft.tools.DateUtil;
import com.ycft.ycft.tools.UploadUtil;

@Service
public class InformSrv {

	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	/**
	 * ��ѯ֪ͨ����Ϣ
	 * @return
	 */
	public List<Title> sel(){
		List<Title> tList = selByCount(2);
		return tList;
	}
	
	/**
	 * ͨ��type��ѯ 1����2֪ͨ3�
	 * @param count
	 * @return
	 */
	public List<Title> selByCount(int count){
		
		List<Title> tList = tm.selByCount(count);
		
		return tList;
	}
	
	
	/**
	 * ɾ��
	 * @param id
	 * @return
	 */
	public boolean del(int id) {
	boolean flag = false;
	
	int result = tm.deleteByPrimaryKey(id);
	if (result > 0) {
		flag = true;
	}
	
	return flag;
	}
	
	/**
	 * ���֪ͨ��Ϣ
	 * @author ���ٸ�
	 * @param content ���ݱ�
	 * @param title	�����
	 * @param titleFile �����ͼƬ
	 * @return
	 * @throws IOException 
	 */
	public boolean addInformAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
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
			imgNamePath = "http://localhost:8080/photo/baidu.png";
		}
		title.setTime(DateUtil.getNowDate());
		User user = (User)request.getSession().getAttribute("user");
		title.setUser(user.getSname());
		title.setType(2);
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		//�������
		tm.insertTitle(title);
		content.setTid(title.getId());
		int success = contentMapper.insertSelective(content);
		System.out.println(success);
		flag = true;
		return flag;
	}
	/**
	 * �����ѯȫ��֪ͨ
	 * @return
	 */
	public List<TitleContent> selAllInform(){
		return tm.selAllByType(2);
	}
	
	/**
	 * ͨ��id�����ѯ
	 * @param id
	 * @return
	 */
	public TitleContent selAllTwoById(int id) {
				
		return tm.selAllByTypeAndId(2, id);
	}
	/**
	 * �޸�֪ͨ�ı����������Ϣ
	 * @author ���ٸ�
	 * @param request
	 * @param title ����
	 * @param content ����
	 * @return
	 */
	public boolean updInform(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		boolean flag = false;
		System.out.println(updFile.getOriginalFilename()+"++++++++++");
		String imgNamePath  = "";
		System.out.println(updFile.isEmpty());
		if(!updFile.isEmpty()) {
			//�ϴ�ͼƬ
			try {
				//�õ�����ͼƬ��·��
				imgNamePath = UploadUtil.commonUpload(request, updFile);
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
		
		tm.updateByPrimaryKeySelective(title);
		contentMapper.updateByTid(content);
		flag = true;
		return flag;
	}
}
