package com.outSouPlat.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.outSouPlat.entity.*;

public class Constant {

	/**
	 * 存放用户审核状态常量
	 * @param request
	 */
	public static void setUserStateInRequest(HttpServletRequest request) {
		
		request.setAttribute("noCheckState", User.NO_CHECK);
		request.setAttribute("checkedState", User.CHECKED);
		request.setAttribute("editingState", User.EDITING);
		
		request.setAttribute("noCheckStateName", User.NO_CHECK_NAME);
		request.setAttribute("checkedStateName", User.CHECKED_NAME);
		request.setAttribute("editingStateName", User.EDITING_NAME);
	}
}
