package com.ycft.ycft.system;

import java.util.ArrayList;
import java.util.List;
import com.ycft.ycft.po.Privilege;

public class Menu {
	public static List<Privilege> pList = new ArrayList<Privilege>();

	public static List<Privilege> getpList() {
		return pList;
	}

	public static void setpList(List<Privilege> pList) {
		Menu.pList = pList;
	}
	
}
