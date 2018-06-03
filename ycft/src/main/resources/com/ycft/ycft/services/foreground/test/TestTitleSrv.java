package com.ycft.ycft.services.foreground.test;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.ycft.ycft.controller.foreground.IndexCtrl;
import com.ycft.ycft.po.Praise;
import com.ycft.ycft.services.foreground.PraiseSrv;
import com.ycft.ycft.services.foreground.SignEventSrv;
import com.ycft.ycft.services.foreground.TitleSrv;
@Service
public class TestTitleSrv  {



	  //  @Autowired
	    static  IndexCtrl is;
	    
	    static  TitleSrv ts;
	    static  PraiseSrv ps;
	    static  SignEventSrv ss;
	  @BeforeClass 
	    public static void init() { 
	        ApplicationContext 
	        context = new ClassPathXmlApplicationContext("classpath:spring/spring.xml"); 
	       // is = (IndexCtrl)context.getBean("indexCtrl"); 
	        ts = (TitleSrv)context.getBean("titleSrv"); 
	        ps = ( PraiseSrv)context.getBean("praiseSrv"); 
	        ss = ( SignEventSrv)context.getBean("signEventSrv"); 
	    }  
	    @Test
	    public void testPing() {
	    	ss.selSignEvent(1,4);
	          //ts.index();
	    /*	Praise p = new Praise();
	    	p.setTid(1);
	    	p.setUid(1);
	    	ps.praise(p);*/
	    	//ts.selectHot(2);
	    }

	
	
}
