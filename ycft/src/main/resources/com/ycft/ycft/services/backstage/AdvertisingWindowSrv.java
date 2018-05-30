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
	
	public boolean uploadAdvertisingWindow(HttpServletRequest request,MultipartFile titleFile,Slide slide) {
		boolean flag = false;
		Content content = contentMapper.selectByTid(slide.getCid());
		slide.setCid(content.getId());
		String imgNamePath  = "";
		if(titleFile != null && !titleFile.isEmpty()) {
			//�ϴ�ͼƬ
			try {
				imgNamePath = UploadUtil.commonUpload(request, titleFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//��ȡһ�»�ȡͼƬ��
		String imgName = imgNamePath.substring(imgNamePath.lastIndexOf("/")+1);
		slide.setName(imgName);
		slide.setTime(DateUtil.getNowDate());
		try {
			slide.setImg(titleFile.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(sm.updateByPrimaryKeyWithBLOBs(slide)>0) {
			flag = true;
		}
		return flag;
	}
}
