package com.outSouPlat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.outSouPlat.entity.*;
import com.outSouPlat.service.*;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/sysMana")
public class SysManaController {

	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	public static final String MODULE_NAME="sysMana";

	/**
	 * 跳转到系统管理-用户查询-编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/user/edit")
	public String goUserEdit(HttpServletRequest request) {

		//publicService.selectNav(request);
		String id = request.getParameter("id");
		User user=userService.selectById(id);
		request.setAttribute("user", user);
		
		return MODULE_NAME+"/user/edit";
	}
	
	@RequestMapping(value="/user/list")
	public String goUserList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/user/list";
	}

	/**
	 * 跳转到角色查询-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/user/detail")
	public String goJscxDetail(HttpServletRequest request) {

		//publicService.selectNav(request);
		String id = request.getParameter("id");
		User user=userService.selectById(id);
		request.setAttribute("user", user);
		
		return MODULE_NAME+"/user/detail";
	}
	
	/**
	 * 编辑用户
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/editUser")
	@ResponseBody
	public Map<String, Object> editUser(User user) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=userService.edit(user);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "编辑用户信息成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑用户信息失败！");
		}
		return jsonMap;
	}
	
	/**
	 * 查询用户
	 * @param username
	 * @param state
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryUserList")
	@ResponseBody
	public Map<String, Object> queryUserList(String username,Integer state,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count = userService.queryForInt(username,state);
		List<User> userList=userService.queryList(username, state, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", userList);
		
		return jsonMap;
	}
	
	/**
	 * 查询下拉框角色
	 * @return
	 */
	@RequestMapping(value="/queryRoleCBBList")
	@ResponseBody
	public Map<String, Object> queryRoleCBBList() {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<Role> roleList=roleService.queryCBBList();
		
		jsonMap.put("rows", roleList);
		
		return jsonMap;
	}
}
