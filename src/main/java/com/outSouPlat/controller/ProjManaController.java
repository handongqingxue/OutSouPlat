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
@RequestMapping("/projMana")
public class ProjManaController {

	@Autowired
	private ProjectService projectService;
	public static final String MODULE_NAME="projMana";
	
	@RequestMapping(value="/projList/new")
	public String goProjListNew(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/projList/new";
	}

	@RequestMapping(value="/projList/edit")
	public String goProjListEdit(HttpServletRequest request) {

		String id = request.getParameter("id");
		Project project=projectService.selectById(id);
		request.setAttribute("project", project);
			
		return MODULE_NAME+"/projList/edit";
	}
	
	@RequestMapping(value="/projList/list")
	public String goProjListList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		Constant.setProjectStateInRequest(request);
		
		return MODULE_NAME+"/projList/list";
	}

	@RequestMapping(value="/projList/detail")
	public String goProjListDetail(HttpServletRequest request) {

		String id = request.getParameter("id");
		Project project=projectService.selectById(id);
		request.setAttribute("project", project);
		
		Constant.setProjectStateInRequest(request);
			
		return MODULE_NAME+"/projList/detail";
	}
	
	@RequestMapping(value="/newProject")
	@ResponseBody
	public Map<String, Object> newProject(Project project,
			@RequestParam(value="illus_file",required=false) MultipartFile illus_file) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			MultipartFile[] fileArr=new MultipartFile[1];
			fileArr[0]=illus_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						String folder="Project/";
						switch (i) {
						case 0:
							folder+="Illus";//插图
							break;
						}
						jsonStr = FileUploadUtil.appUploadContentImg(fileArr[i],folder);
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								project.setIllusUrl(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			
			int count=projectService.add(project);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "创建项目信息成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "创建项目信息失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonMap;
	}

	@RequestMapping(value="/editProject")
	@ResponseBody
	public Map<String, Object> editProject(Project project,
			@RequestParam(value="illus_file",required=false) MultipartFile illus_file) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			MultipartFile[] fileArr=new MultipartFile[1];
			fileArr[0]=illus_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						String folder="Project/";
						switch (i) {
						case 0:
							folder+="Illus";//插图
							break;
						}
						jsonStr = FileUploadUtil.appUploadContentImg(fileArr[i],folder);
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								project.setIllusUrl(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			
			int count=projectService.edit(project);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "编辑项目信息成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "编辑项目信息失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonMap;
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
	
	@RequestMapping(value="/queryCBBList")
	@ResponseBody
	public Map<String, Object> queryCBBList() {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<Project> projectList=projectService.queryCBBList();
		
		jsonMap.put("rows", projectList);
		
		return jsonMap;
	}
}
