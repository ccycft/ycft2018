package com.ycft.ycft.system;

import java.io.InputStream;
import java.util.Properties;

/**
 * @author 马荣福
 *从config里面读取域名
 */
public class LoadDomain {
	public static String domain = ""; //域名
	public static String domainTop = "";//真正的域名，而不是照片的路径
	static {
		try {
		//加载config
		InputStream in =LoadDomain.class.getClassLoader().getResource("config.properties").openStream();
		Properties p = new Properties();
		p.load(in);
		domain = p.getProperty("domain.photo").toString().trim();
		domainTop = p.getProperty("domain.top").toString().trim();
		} catch (Exception e) {
		e.printStackTrace();
		}
	}
}
