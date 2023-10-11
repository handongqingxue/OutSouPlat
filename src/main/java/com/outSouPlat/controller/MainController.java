package com.outSouPlat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.outSouPlat.entity.*;
import com.outSouPlat.service.*;
import com.outSouPlat.util.*;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;

	/**
	 * 跳转到登录页
	 * @return
	 */
	@RequestMapping(value="/goLogin")
	public String goLogin() {
		
		//http://localhost:8080/OutSouPlat/main/goLogin
		
		return "login";
	}
	
	@RequestMapping(value="/goRegist")
	public String goRegist(HttpServletRequest request) {
		
		return "regist";
	}
	
	/**
	 * 注册信息处理接口
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/regist" , method = RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String regist(User user) {
		
		PlanResult plan=new PlanResult();
		int count=userService.add(user);
		if(count==0) {
			plan.setStatus(count);
			plan.setMsg("系统错误，请联系维护人员");
			return JsonUtil.getJsonFromObject(plan);
		}else {
			plan.setStatus(0);
			plan.setMsg("注册成功");
			plan.setData(user);
			plan.setUrl("/main/goLogin");
		}
		
		return JsonUtil.getJsonFromObject(plan);
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String login(String username,String password,
			String rememberMe,HttpServletRequest request) {
		
		System.out.println("===登录接口===");
		System.out.println("username==="+username);
		System.out.println("password==="+password);
		
		//返回值的json
		PlanResult plan=new PlanResult();
		HttpSession session=request.getSession();
		
		//TODO在这附近添加登录储存信息步骤，将用户的账号以及密码储存到shiro框架的管理配置当中方便后续查询
		try {
			System.out.println("验证码一致");
			UsernamePasswordToken token = new UsernamePasswordToken(username,password); 
			Subject currentUser = SecurityUtils.getSubject();  
			if (!currentUser.isAuthenticated()){
				//使用shiro来验证  
				token.setRememberMe(true);  
				currentUser.login(token);//验证角色和权限  
			}
		}catch (Exception e) {
			e.printStackTrace();
			plan.setStatus(1);
			plan.setMsg("登陆失败");
			return JsonUtil.getJsonFromObject(plan);
		}
		User user=(User)SecurityUtils.getSubject().getPrincipal();
		String roleIds = user.getRoleIds();
		if(!StringUtils.isEmpty(roleIds)) {
			String permissionIds=roleService.getPermissionIdsByIds(roleIds);
			System.out.println("permissionIds==="+permissionIds);
			user.setPermissionIds(permissionIds);
		}
		session.setAttribute("user", user);
		
		plan.setStatus(0);
		plan.setMsg("验证通过");
		plan.setUrl("sysMana/perInfo");
		return JsonUtil.getJsonFromObject(plan);
	}

	/**
	 * 验证用户名是否存在
	 * @param username
	 * @return
	 */
	@RequestMapping(value="/checkUsernameIfExist",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String checkUsernameIfExist(String username) {
		boolean exist=userService.checkUsernameIfExist(username);
		PlanResult plan=new PlanResult();
		String json;
		if(exist) {
			plan.setStatus(0);
			plan.setMsg("用户名已存在");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/exit")
	public String exit(HttpSession session) {
		System.out.println("退出接口");
		Subject currentUser = SecurityUtils.getSubject();       
	    currentUser.logout();    
		return "login";
	}
}