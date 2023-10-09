package com.outSouPlat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.outSouPlat.entity.*;
import com.outSouPlat.service.*;
import com.outSouPlat.util.*;

@Controller
@RequestMapping("/testResult")
public class TestResultController {

	@Autowired
	private TestResultService testResultService;
	public static final String MODULE_NAME="testResult";
	
	@RequestMapping(value="/synthetic/list")
	public String goSyntheticList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/synthetic/list";
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
	
	@RequestMapping(value="/querySyntheticList")
	@ResponseBody
	public Map<String, Object> querySyntheticList(String orderNo,String taskBagName,String testUserName,String phone,String createTimeStart,String createTimeEnd,
			Integer state,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count = testResultService.queryForInt(orderNo,taskBagName,testUserName,phone,createTimeStart,createTimeEnd,state);
			List<TestResult> testResultList=testResultService.queryList(orderNo,taskBagName,testUserName,phone,createTimeStart,createTimeEnd,state, page, rows, sort, order);
			
			jsonMap.put("total", count);
			jsonMap.put("rows", testResultList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonMap;
	}
}
