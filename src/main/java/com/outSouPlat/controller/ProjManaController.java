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
@RequestMapping("/projMana")
public class ProjManaController {

	@Autowired
	private ProjectService projectService;
	public static final String MODULE_NAME="projMana";
	
	@RequestMapping(value="/projList/list")
	public String goProjListList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/projList/list";
	}
	
	@RequestMapping(value="/queryList")
	@ResponseBody
	public Map<String, Object> queryList(String name,String deveLang,String database,String deveTool,String createTimeStart,String createTimeEnd,Integer state,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count = projectService.queryForInt(name,deveLang,database,deveTool,createTimeStart,createTimeEnd,state);
			List<Project> projectList=projectService.queryList(name,deveLang,database,deveTool,createTimeStart,createTimeEnd,state, page, rows, sort, order);
			
			jsonMap.put("total", count);
			jsonMap.put("rows", projectList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonMap;
	}
}
