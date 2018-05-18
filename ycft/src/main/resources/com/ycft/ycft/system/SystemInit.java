package com.ycft.ycft.system;

import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ycft.ycft.services.InitService;


/**
 * Application Lifecycle Listener implementation class SystemInit
 *
 */
public class SystemInit implements ServletContextListener {
	

	//注入初始化service
	private InitService initService;
	
    public InitService getInitService() {
		return initService;
	}

	public void setInitService(InitService initService) {
		this.initService = initService;
	}

	/**
     * Default constructor. 
     */
    public SystemInit() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce) {
        // TODO Auto-generated method stub
    	System.out.println("====================容器启动,数据字典加载中...===========================");
    	try {
    		ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
    		SystemInit sys = (SystemInit)appContext.getBean("systemInit");
	    	//获取初始化service执行缓存操作
	    	//获取初始化service执行缓存操作
	    	boolean isCacheDict = sys.getInitService().cacheDict();
	    	System.out.println(isCacheDict ? "数据字典加载成功..." : "数据字典加载失败...");
		   System.out.println("====================容器启动,数据字典加载成功...===========================");
		   System.out.println("====================开始缓存首页幻灯片...===========================");
		   sys.getInitService().cacheSlide();
		   System.out.println("==================== 缓存首页幻灯片成功...===========================");
		   
		   
    	} catch (Exception e) {
			// TODO: handle exception
    		e.printStackTrace();

        	System.out.println("====================数据字典加载失败...===========================");
		}
    	
    	
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    }

}
