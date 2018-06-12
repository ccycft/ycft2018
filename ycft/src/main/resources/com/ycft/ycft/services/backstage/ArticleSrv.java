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
public class ArticleSrv {
	@Autowired
	private TitleMapper tm;
	@Autowired
	private ContentMapper contentMapper;
	/**
	 * ��ѯ���µ���Ϣ
	 * @author ���ٸ�
	 * @return
	 */
	public List<Title> sel(){
		//1��������
		List<Title> tList = selByCount(1);
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
	public boolean addArticleAffairs(HttpServletRequest request,Content content,Title title,MultipartFile titleFile){
		boolean flag = false;
		String imgNamePath  = "";
		//�ж��ļ�����
		if(!titleFile.isEmpty()) {
			//�ϴ�ͼƬ
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			//��Ĭ�ϵ�ͼƬ������ݿ���
			imgNamePath = "/logo.png";
		}
		//�洢����
		title.setTime(DateUtil.getNowDate());
		//ͨ��session��ȡ�û���Ϣ
		User user = (User)request.getSession().getAttribute("user");
		//�����û���
		title.setUser(user.getSname());
		//�������� 1��������
		title.setType(1);
		//�ļ�����ȡ
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		title.setImgName(imgName);
		title.setUid(user.getId() );
		System.out.println(title.getUid()+"-------------------===============");
		//�������
		tm.insertTitle(title);
		//��������id
		content.setTid(title.getId());
		//�ж��Ƿ�ɹ�
		int success = contentMapper.insertSelective(content);
		if(success > 0) {
			flag = true;
		}
		return flag;
	}
	/**
	 * �����ѯȫ������
	 * @return
	 */
	public List<TitleContent> selAllArticle(){
		return tm.selAllByType(1);
	}
	
	/**
	 * ͨ��id�����ѯ
	 * @param id
	 * @return
	 */
	public TitleContent selAllTwoById(int id) {
				
		return tm.selAllByTypeAndId(1, id);
	}
	/**
	 * �޸�֪ͨ�ı����������Ϣ
	 * @author ���ٸ�
	 * @param request
	 * @param title ����
	 * @param content ����
	 * @return
	 */
	public boolean updArticle(HttpServletRequest request,Title title,Content content,MultipartFile updFile) {
		boolean flag = false;
		String imgNamePath  = "";
		//�ļ�����
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
		title.setUid(user.getId() );
		//ѡ�����޸�
		int returnValue1 = tm.updateByPrimaryKeySelective(title);
		//ͨ��id�޸�
		int returnValue2 = contentMapper.updateByTid(content);
		if(returnValue1 > 0 && returnValue2 > 0) {
			flag = true;
		}
		return flag;
	}
}
