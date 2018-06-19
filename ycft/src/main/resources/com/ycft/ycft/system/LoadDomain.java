package com.ycft.ycft.system;

import java.io.InputStream;
import java.util.Properties;

/**
 * @author ���ٸ�
 *��config�����ȡ����
 */
public class LoadDomain {
	public static String domain = ""; //����
	static {
		try {
		//����config
		InputStream in =LoadDomain.class.getClassLoader().getResource("config.properties").openStream();
		Properties p = new Properties();
		p.load(in);
		domain = p.getProperty("domain.top").toString().trim();
		} catch (Exception e) {
		e.printStackTrace();
		}
	}
}