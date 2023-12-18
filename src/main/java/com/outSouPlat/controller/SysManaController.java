package com.outSouPlat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.outSouPlat.entity.*;
import com.outSouPlat.service.*;
import com.outSouPlat.util.*;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/sysMana")
public class SysManaController {

	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private PermissionService permissionService;
	@Autowired
	private SysNoticeService sysNoticeService;
	public static final String MODULE_NAME="sysMana";
	
	/**
	 * 跳转到系统管理-个人信息页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/perInfo")
	public String goPerInfo(HttpServletRequest request) {

		//Constant.setYhQxInRequest(request);
		Constant.setUserStateInRequest(request);
		User user=(User)SecurityUtils.getSubject().getPrincipal();
		request.setAttribute("user", user);
		
		Constant.setUserPermissionInRequest(request);
		
		return MODULE_NAME+"/perInfo";
	}
	
	@RequestMapping(value="/sysNotice/list")
	public String goSysNoticeList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		Constant.setUserPermissionInRequest(request);
		
		return MODULE_NAME+"/sysNotice/list";
	}

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

		Constant.setUserPermissionInRequest(request);
		Constant.setUserStateInRequest(request);
		
		return MODULE_NAME+"/user/edit";
	}
	
	@RequestMapping(value="/user/list")
	public String goUserList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		Constant.setUserPermissionInRequest(request);
		Constant.setUserStateInRequest(request);
		
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

		Constant.setUserPermissionInRequest(request);
		Constant.setUserStateInRequest(request);
		
		return MODULE_NAME+"/user/detail";
	}
	
	@RequestMapping(value="/unCheckUser/list")
	public String goUnCheckUserList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		Constant.setUserPermissionInRequest(request);
		
		return MODULE_NAME+"/unCheckUser/list";
	}
	
	/**
	 * 跳转到角色查询-添加页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/role/new")
	public String goRoleNew(HttpServletRequest request) {
		
		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			url=MODULE_NAME+"/role/new";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;

		return url;
	}

	/**
	 * 跳转到角色查询-编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/role/edit")
	public String goRoleEdit(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			//publicService.selectNav(request);
			String id = request.getParameter("id");
			Role role=roleService.selectById(id);
			request.setAttribute("role", role);
			
			url=MODULE_NAME+"/role/edit";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	/**
	 * 跳转到角色查询-列表页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/role/list")
	public String goRoleList(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			url=MODULE_NAME+"/role/list";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}

	/**
	 * 跳转到角色查询-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/role/detail")
	public String goRoleDetail(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			//publicService.selectNav(request);
			String id = request.getParameter("id");
			Role role=roleService.selectById(id);
			request.setAttribute("role", role);
			
			url=MODULE_NAME+"/role/detail";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}

	/**
	 * 跳转到权限查询-编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/permission/edit")
	public String goPermissionEdit(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			//publicService.selectNav(request);
			String id = request.getParameter("id");
			Permission permission=permissionService.selectById(id);
			request.setAttribute("permission", permission);
			
			url=MODULE_NAME+"/permission/edit";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	/**
	 * 跳转到权限查询-列表页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/permission/list")
	public String goPermissionList(HttpServletRequest request) {
		
		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			url=MODULE_NAME+"/permission/list";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;

		return url;
	}
	
	/**
	 * 跳转到权限查询-添加页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/permission/new")
	public String goPermissionNew(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(request)) {
			url=MODULE_NAME+"/permission/new";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	/**
	 * 查询系统通知
	 * @param title
	 * @param state
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/querySysNoticeList")
	@ResponseBody
	public Map<String, Object> querySysNoticeList(String title,Integer state,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count = sysNoticeService.queryForInt(title);
		List<SysNotice> sysNoticeList=sysNoticeService.queryList(title, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", sysNoticeList);
		
		return jsonMap;
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
	 * 添加角色
	 * @param role
	 * @return
	 */
	@RequestMapping(value="/newRole")
	@ResponseBody
	public Map<String, Object> newRole(Role role) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=roleService.add(role);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "创建角色成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "创建角色失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "创建角色失败！");
		}
		finally {
			return jsonMap;
		}
	}
	
	/**
	 * 编辑角色
	 * @param role
	 * @return
	 */
	@RequestMapping(value="/editRole")
	@ResponseBody
	public Map<String, Object> editRole(Role role) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=roleService.edit(role);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "编辑角色成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑角色失败！");
		}
		return jsonMap;
	}
	
	/**
	 * 添加权限
	 * @param permission
	 * @return
	 */
	@RequestMapping(value="/newPermission")
	@ResponseBody
	public Map<String, Object> newPermission(Permission permission) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=permissionService.add(permission);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "创建权限成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "创建权限失败！");
		}
		return jsonMap;
	}
	
	/**
	 * 编辑权限
	 * @param permission
	 * @return
	 */
	@RequestMapping(value="/editPermission")
	@ResponseBody
	public Map<String, Object> editPermission(Permission permission) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=permissionService.edit(permission);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "编辑权限成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑权限失败！");
		}
		return jsonMap;
	}
	
	/**
	 * 查询权限
	 * @param name
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryPermissionList")
	@ResponseBody
	public Map<String, Object> queryPermissionList(String name,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count = permissionService.queryForInt(name);
		List<Permission> permissionList=permissionService.queryList(name, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", permissionList);
		
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
	
	/**
	 * 查询下拉框权限
	 * @return
	 */
	@RequestMapping(value="/queryPermissionCBBList")
	@ResponseBody
	public Map<String, Object> queryPermissionCBBList() {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<Permission> permissionList=permissionService.queryCBBList();
		
		jsonMap.put("rows", permissionList);
		
		return jsonMap;
	}

	/**
	 * 审核用户
	 * @param ids
	 * @param ucr
	 * @return
	 */
	@RequestMapping(value="/checkUserByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String checkUserByIds(String ids, UserCheckRec ucr) {
		//TODO 针对分类的动态进行实时调整更新
		int count=userService.checkByIds(ids,ucr);
		PlanResult plan=new PlanResult();
		String tsStr=null;
		Boolean result = ucr.getResult();
		if(result)
			tsStr="审核";
		else
			tsStr="退回";
		
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg(tsStr+"用户信息失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg(tsStr+"用户信息成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据用户名验证原密码
	 * @param password
	 * @param username
	 * @return
	 */
	@RequestMapping(value="/checkPassword")
	@ResponseBody
	public Map<String, Object> checkPassword(String password, String username) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=userService.checkPassword(password,username);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "原密码错误！");
		}
		return jsonMap;
	}
	
	/**
	 * 根据用户id修改密码
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/updatePwdByUserId")
	@ResponseBody
	public String updatePwdByUserId(String password) {
		User user=(User)SecurityUtils.getSubject().getPrincipal();
		Integer id = user.getId();
		int count = userService.updatePwdById(password,id);
		
		PlanResult plan=new PlanResult();
		if(count==0) {
			plan.setStatus(0);
		}
		else {
			plan.setStatus(1);
		}
		return JsonUtil.getJsonFromObject(plan);
	}
	
	/**
	 * 查询角色
	 * @param name
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryRoleList")
	@ResponseBody
	public Map<String, Object> queryRoleList(String name,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count = roleService.queryForInt(name);
		List<Role> roleList=roleService.queryList(name, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", roleList);
		
		return jsonMap;
	}
}
