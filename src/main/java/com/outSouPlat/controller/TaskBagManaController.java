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

@Controller
@RequestMapping("/taskBagMana")
public class TaskBagManaController {

	@Autowired
	private TaskBagService taskBagService;
	public static final String MODULE_NAME="taskBagMana";
	
	@RequestMapping(value="/taskBagList/list")
	public String goTaskBagListList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/taskBagList/list";
	}
	
	@RequestMapping(value="/queryList")
	@ResponseBody
	public Map<String, Object> queryList(String name,String projectName,String uploadUserName,String createTimeStart,String createTimeEnd,Integer state,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count = taskBagService.queryForInt(name,projectName,uploadUserName,createTimeStart,createTimeEnd,state);
			List<TaskBag> taskBagList=taskBagService.queryList(name,projectName,uploadUserName,createTimeStart,createTimeEnd,state, page, rows, sort, order);
			
			jsonMap.put("total", count);
			jsonMap.put("rows", taskBagList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonMap;
	}
}
