package com.ycft.ycft.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ycft.ycft.mapper.PrivilegeMapper;
import com.ycft.ycft.po.Privilege;

@Service
public class PrivilegeService {
	
	@Autowired
	PrivilegeMapper pm;
	
	private final Gson gson = new GsonBuilder().disableHtmlEscaping().create();
	public List<Privilege> testQueryMenuList() {
	    // 原始的数据
	    List<Privilege> rootMenu = pm.queryMenuList(null);
	    
	    // 查看结果
	    for (Privilege menu : rootMenu) {
	        System.out.println(menu);
	    }
	    // 最后的结果
	    List<Privilege> menuList = new ArrayList<Privilege>();
	    // 先找到所有的一级菜单
	    for (int i = 0; i < rootMenu.size(); i++) {
	        // 一级菜单没有parentId
	        if (rootMenu.get(i).getpId()==null) {
	            menuList.add(rootMenu.get(i));
	        }
	    }
	    System.out.println(menuList.size());
	    // 为一级菜单设置子菜单，getChild是递归调用的
	    for (Privilege menu : menuList) {
	        menu.setChildMenus(getChild(menu.getId(), rootMenu));
	    }
	    Map<String,Object> jsonMap = new HashMap<String,Object>();
	    jsonMap.put("menu", menuList);
	    System.out.println(gson.toJson(jsonMap));
	    return menuList;
	}

	/**
	 * 递归查找子菜单
	 * 
	 * @param id
	 *            当前菜单id
	 * @param rootMenu
	 *            要查找的列表
	 * @return
	 */
	private List<Privilege> getChild(int id, List<Privilege> rootMenu) {
	    // 子菜单
	    List<Privilege> childList = new ArrayList<Privilege>();
	    for (Privilege menu : rootMenu) {
	        // 遍历所有节点，将父菜单id与传过来的id比较
	        if (menu.getpId()!=null) {
	            if (menu.getpId()==id) {
	                childList.add(menu);
	            }
	        }
	    }
	    // 把子菜单的子菜单再循环一遍
	    for (Privilege menu : childList) {// 没有url子菜单还有子菜单
	        if (StringUtils.isBlank(menu.getmUrl())) {
	            // 递归
	            menu.setChildMenus(getChild(menu.getId(), rootMenu));
	        }
	    } // 递归退出条件
	    if (childList.size() == 0) {
	        return null;
	    }
	    return childList;
	}
}
