package com.ycft.ycft.system;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;
import com.ycft.ycft.po.Privilege;
import com.ycft.ycft.po.User;
import com.ycft.ycft.services.PrivilegeService;
import com.ycft.ycft.tools.BeanUtil;

public class SysPrivilege {
	
	static PrivilegeService ps = null;
	static{
		ps = BeanUtil.getBean("privilegeService", PrivilegeService.class);
		
	}
	/**比较登录的用户的菜单，和数据库里面已经有的菜单
	 * @param user
	 * @param response
	 * @param request
	 * @return 
	 */
	public boolean compareMenu(String url,HttpServletRequest request) {
		boolean flag = false;
		User user = (User)request.getSession().getAttribute("user");
		//用户已经有的菜单
		List<Privilege> privilegeListWithUser = null;
		if(user != null) {
			privilegeListWithUser = ps.testQueryMenuList(user);
		}else {
			privilegeListWithUser = ps.testQueryMenuList(null);
		}
		privilegeListWithUser = ps.testQueryMenuList(null);
		for(Privilege parentPrivilege : privilegeListWithUser) {
			for(Privilege sonPrivilege :parentPrivilege.getChildMenus()) {
				if(url.equals(sonPrivilege.getmUrl())){
					flag  = true;
					break;
				}
			}
		}
		return flag;
	}
	/**
	 * 判断数据库里是否有这个菜单
	 * @param url
	 * @param request
	 * @return
	 */
	public boolean compareMenuIsTrue(String url,HttpServletRequest request) {
		boolean flag = false;
		List<Privilege> privilegeList = ps.testQueryMenuList(null);
		for(Privilege parentPrivilege : privilegeList) {
			for(Privilege sonPrivilege :parentPrivilege.getChildMenus()) {
				if(url.equals(sonPrivilege.getmUrl())){
					flag  = true;
					break;
				}
			}
		}
		return flag;
	}
}
