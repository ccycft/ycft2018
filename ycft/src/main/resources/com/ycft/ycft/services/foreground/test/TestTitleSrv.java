package com.ycft.ycft.services.foreground.test;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.ycft.ycft.controller.foreground.IndexCtrl;
@Service
public class TestTitleSrv  {



	  //  @Autowired
	    static  IndexCtrl ts;
	    
	  @BeforeClass 
	    public static void init() { 
	        ApplicationContext 
	        context = new ClassPathXmlApplicationContext("classpath:spring/spring.xml"); 
	        ts = (IndexCtrl)context.getBean("indexCtrl"); 
	    }  
	    @Test
	    public void testPing() {
	          ts.index();
	    }

	
	
}
