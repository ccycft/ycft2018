package com.ycft.ycft.test;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.ycft.ycft.services.foreground.TitleSrv;
@Service
public class TestTitleSrv extends SpringTestBase{



	  //  @Autowired
	    static  TitleSrv ts;
	    
	    @BeforeClass 
	    public static void init() { 
	        ApplicationContext 
	        context = new ClassPathXmlApplicationContext("classpath*:config/spring/spring.xml"); 
	        ts = (TitleSrv)context.getBean("titleSrv"); 
	    }  

	    @Test
	    public void testPing() {
	          ts.select(2);
	    }

	
	
}
