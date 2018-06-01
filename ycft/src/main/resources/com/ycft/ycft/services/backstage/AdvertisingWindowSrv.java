package com.ycft.ycft.services.backstage;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ycft.ycft.mapper.ContentMapper;
import com.ycft.ycft.mapper.SlideMapper;
import com.ycft.ycft.po.Content;
import com.ycft.ycft.po.Slide;
import com.ycft.ycft.po.SlideContent;
import com.ycft.ycft.tools.DateUtil;
import com.ycft.ycft.tools.UploadUtil;

@Service
public class AdvertisingWindowSrv {

	
	@Autowired
	private SlideMapper sm;
	@Autowired
	private ContentMapper contentMapper;
	/**
	 * ��洰����������������ѯ
	 * @author ZHENGBIN
	 * @return List<SlideContent>
	 */
	public List<SlideContent> advertisingWindowSel() {
		List<SlideContent> scList = null;
		//����洰�ı���������ݱ���������
		scList = sm.AdvertisingWindowSel();
		
		return scList;
	}
	
	/**
	 * ��洰���޸�
	 * @author ZHENGBIN
	 * @param request
	 * @param titleFile ������
	 * @param slide ������
	 * @return boolean
	 */
	public boolean uploadAdvertisingWindow(HttpServletRequest request,MultipartFile titleFile,Slide slide) {
		boolean flag = false;
		//0��ʾΪû�޸�����
		if (slide.getCid() == 0) {
			slide.setCid(null);
		} else {
			//����޸��������content��idȥ���title��id����
			Content content = contentMapper.selectByTid(slide.getCid());
			slide.setCid(content.getId());
		}
		String imgNamePath  = "";
		if(!titleFile.isEmpty()) {
			//�ϴ�ͼƬ
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
				//��ȡһ�»�ȡͼƬ��
				String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
				slide.setName(imgName);
				slide.setImg(titleFile.getBytes());
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			//��ͼƬ����ͼƬ������Ϊ���򲻻��޸�
			slide.setName(null);
			slide.setImg(null);
		}
		//�޸��ϴ�ʱ��
		slide.setTime(DateUtil.getNowDate());
		if(sm.updateByPrimaryKeySelective(slide)>0) {
			flag = true;
		}
		return flag;
	}
}
