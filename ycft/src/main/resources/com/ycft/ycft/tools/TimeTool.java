package com.ycft.ycft.tools;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

public class TimeTool {

  /**
   * 获取时间戳
 * @return
 */
public  static String getRandomOrderNoOrFileName() {
       SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

       String yid = sdf.format(new Date()) + (new Random().nextInt(100));

       return yid;
   }
}