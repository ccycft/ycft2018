package com.ycft.ycft.tools;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	/**
	 * ��ȡ��ǰʱ��
	 * @return
	 */
	public static String getNowDate() {
		Date day=new Date();    
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return df.format(day);
	}
}
