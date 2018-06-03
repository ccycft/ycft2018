package com.ycft.ycft.system;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ycft.ycft.po.User;
import com.ycft.ycft.services.InitService;


/**
 * Application Lifecycle Listener implementation class SystemInit
 *
 */
public class SystemInit implements ServletContextListener {
	

	//ע���ʼ��service
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
    	System.out.println("====================��������,�����ֵ������...===========================");
    	try {
    		ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
    		SystemInit sys = (SystemInit)appContext.getBean("systemInit");
	    	//��ȡ��ʼ��serviceִ�л������
	    	//��ȡ��ʼ��serviceִ�л������
	    	boolean isCacheDict = sys.getInitService().cacheDict();
	    	System.out.println(isCacheDict ? "�����ֵ���سɹ�..." : "�����ֵ����ʧ��...");
	    	User user = new User();
	    	Menu.setpList(sys.getInitService().cacheMenu(user));
		   System.out.println("====================��������,�����ֵ���سɹ�...===========================");
		   System.out.println("====================��ʼ������ҳ�õ�Ƭ...===========================");
		   sys.getInitService().cacheSlide();
		   System.out.println("==================== ������ҳ�õ�Ƭ�ɹ�...===========================");
		   System.out.println("====================��ʼ����Ĭ��ͼƬ...===========================");
		   sys.getInitService().cacheDefaultImg(sce.getServletContext().getRealPath("/"));
		   System.out.println("==================== Ĭ��ͼƬ����ɹ�...===========================");
		   
    	} catch (Exception e) {
			// TODO: handle exception
    		e.printStackTrace();

        	System.out.println("====================�����ֵ����ʧ��...===========================");
		}
    	
    	
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    }

}
