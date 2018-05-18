package com.ycft.ycft.tools;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;  
import org.springframework.context.ApplicationContextAware;  
  
public class BeanUtil implements ApplicationContextAware {  
    /** Spring上下文 */  
    private static ApplicationContext applicationContext;  
      
    /** 
     * 根据beanName获取对象 
     * 
     */  
    public static Object getBean(String beanName) {  
        return applicationContext.getBean(beanName);  
    }  
   
    public static <T> T getBean(String beanName, Class<T> clazz) {  
        return clazz.cast(getBean(beanName));  
    }  
     @Autowired
    public void setApplicationContext(ApplicationContext applicationContext)  throws BeansException {  
        this.applicationContext = applicationContext;  
    }  
}  