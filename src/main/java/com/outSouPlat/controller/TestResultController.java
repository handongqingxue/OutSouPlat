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
import com.outSouPlat.util.*;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/testResult")
public class TestResultController {

	@Autowired
	private TestResultService testResultService;
	public static final String MODULE_NAME="testResult";

	/**
	 * 跳转到测试结果-综合查询-编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/synthetic/edit")
	public String goSyntheticEdit(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TEST_RESULT_EDIT,request)) {
			//publicService.selectNav(request);
			String id = request.getParameter("id");
			TestResult testResult=testResultService.selectById(id);
			request.setAttribute("testResult", testResult);
	
			Constant.setUserPermissionInRequest(request);
			Constant.setTestResultInRequest(request);
			
			url=MODULE_NAME+"/synthetic/edit";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	@RequestMapping(value="/synthetic/list")
	public String goSyntheticList(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TEST_RESULT_SEAR,request)) {
			//publicService.selectNav(request);
	
			Constant.setRoleFlagInRequest(request);
			Constant.setUserPermissionInRequest(request);
			Constant.setTestResultInRequest(request);
			
			url=MODULE_NAME+"/synthetic/list";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}

	/**
	 * 跳转到测试结果-综合查询-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/synthetic/detail")
	public String goSyntheticDetail(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TEST_RESULT_SEAR,request)) {
			//publicService.selectNav(request);
			String id = request.getParameter("id");
			TestResult testResult=testResultService.selectById(id);
			request.setAttribute("testResult", testResult);
	
			Constant.setUserPermissionInRequest(request);
			Constant.setTestResultInRequest(request);
			
			url=MODULE_NAME+"/synthetic/detail";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	@RequestMapping(value="/add")
	@ResponseBody
	public Map<String, Object> add(TestResult testResult) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=testResultService.add(testResult);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "添加测试结果成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "添加测试结果失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "添加测试结果失败！");
		}
		finally {
			return jsonMap;
		}
	}

	@RequestMapping(value="/edit")
	@ResponseBody
	public Map<String, Object> edit(TestResult testResult) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			int count=testResultService.edit(testResult);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "编辑测试结果成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "编辑测试结果失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/querySyntheticList")
	@ResponseBody
	public Map<String, Object> querySyntheticList(String orderNo,String taskBagName,String testUserName,String phone,String createTimeStart,String createTimeEnd,
			Boolean result,Integer userId,Integer roleFlag,int page,int rows,String sort,String order) {
		
		//System.out.println("userId="+userId);
		//System.out.println("roleFlag="+roleFlag);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count = testResultService.queryForInt(orderNo,taskBagName,testUserName,phone,createTimeStart,createTimeEnd,result,userId,roleFlag);
			List<TestResult> testResultList=testResultService.queryList(orderNo,taskBagName,testUserName,phone,createTimeStart,createTimeEnd,result,userId,roleFlag, page, rows, sort, order);
			
			jsonMap.put("total", count);
			jsonMap.put("rows", testResultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonMap;
	}
}
