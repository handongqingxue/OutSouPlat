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
import com.outSouPlat.util.Constant;
import com.outSouPlat.util.FileUploadUtil;
import com.outSouPlat.util.JsonUtil;
import com.outSouPlat.util.PlanResult;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/taskBagMana")
public class TaskBagManaController {

	@Autowired
	private TaskBagService taskBagService;
	@Autowired
	private TaskOrderService taskOrderService;
	public static final String MODULE_NAME="taskBagMana";
	
	@RequestMapping(value="/taskBagList/new")
	public String goTaskBagListNew(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		return MODULE_NAME+"/taskBagList/new";
	}

	/**
	 * 跳转到任务包管理-任务包列表-编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/taskBagList/edit")
	public String goTaskBagListEdit(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		String id = request.getParameter("id");
		TaskBag taskBag=taskBagService.selectById(id);
		request.setAttribute("taskBag", taskBag);
		
		return MODULE_NAME+"/taskBagList/edit";
	}
	
	@RequestMapping(value="/taskBagList/list")
	public String goTaskBagListList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		Constant.setTaskBagStateInRequest(request);
		
		return MODULE_NAME+"/taskBagList/list";
	}

	/**
	 * 跳转到任务包管理-任务包列表-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/taskBagList/detail")
	public String goTaskBagListDetail(HttpServletRequest request) {

		String id = request.getParameter("id");
		TaskBag taskBag=taskBagService.selectById(id);
		request.setAttribute("taskBag", taskBag);
			
		return MODULE_NAME+"/taskBagList/detail";
	}
	
	@RequestMapping(value="/taskOrder/list")
	public String goTaskOrderList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		
		Constant.setTaskOrderStateInRequest(request);
		Constant.setTestResultStateInRequest(request);
		
		return MODULE_NAME+"/taskOrder/list";
	}

	/**
	 * 跳转到任务包管理-任务单查询-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/taskOrder/detail")
	public String goTaskOrderDetail(HttpServletRequest request) {

		String id = request.getParameter("id");
		TaskOrder taskOrder=taskOrderService.selectById(id);
		request.setAttribute("taskOrder", taskOrder);
		
		Constant.setTaskOrderStateInRequest(request);
			
		return MODULE_NAME+"/taskOrder/detail";
	}
	
	@RequestMapping(value="/newTaskBag")
	@ResponseBody
	public Map<String, Object> newTaskBag(TaskBag taskBag,
			@RequestParam(value="annex_file",required=false) MultipartFile annex_file) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			MultipartFile[] fileArr=new MultipartFile[3];
			fileArr[0]=annex_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						String folder="TaskBag/";
						switch (i) {
						case 0:
							folder+="annex";//附件
							break;
						}
						jsonStr = FileUploadUtil.appUploadContentImg(fileArr[i],folder);
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								taskBag.setAnnexFileSize(annex_file.getSize());
								taskBag.setAnnexFileUrl(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			
			int count=taskBagService.add(taskBag);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "创建任务包成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "创建任务包失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "创建任务包失败！");
		}
		return jsonMap;
	}

	@RequestMapping(value="/editTaskBag")
	@ResponseBody
	public Map<String, Object> editTaskBag(TaskBag taskBag,
			@RequestParam(value="annex_file",required=false) MultipartFile annex_file) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			MultipartFile[] fileArr=new MultipartFile[3];
			fileArr[0]=annex_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						String folder="TaskBag/";
						switch (i) {
						case 0:
							folder+="annex";//附件
							break;
						}
						jsonStr = FileUploadUtil.appUploadContentImg(fileArr[i],folder);
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								taskBag.setAnnexFileSize(annex_file.getSize());
								taskBag.setAnnexFileUrl(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
		
			int count=taskBagService.edit(taskBag);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "编辑任务包成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "编辑任务包失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑任务包失败！");
		}
		return jsonMap;
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
	
	@RequestMapping(value="/newTaskOrder")
	@ResponseBody
	public Map<String, Object> newTaskOrder(TaskOrder taskOrder) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=taskOrderService.add(taskOrder);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "创建任务单成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "创建任务单失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "创建任务单失败！");
		}
		finally {
			return jsonMap;
		}
	}
	
	@RequestMapping(value="/queryTaskOrderList")
	@ResponseBody
	public Map<String, Object> queryTaskOrderList(String no,String taskBagName,String userName,String createTimeStart,String createTimeEnd,
			String finishTimeStart,String finishTimeEnd,Integer state,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count = taskOrderService.queryForInt(no,taskBagName,userName,createTimeStart,createTimeEnd,finishTimeStart,finishTimeEnd,state);
			List<TaskOrder> taskOrderList=taskOrderService.queryList(no,taskBagName,userName,createTimeStart,createTimeEnd,finishTimeStart,finishTimeEnd,state, page, rows, sort, order);
			
			jsonMap.put("total", count);
			jsonMap.put("rows", taskOrderList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/submitTaskBag",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String submitTaskBag(Integer id) {
		//TODO 针对分类的动态进行实时调整更新
		int count=taskBagService.submitById(id);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("发布任务包失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("发布任务包成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	@RequestMapping(value="/uploadTaskOrderCodeFile")
	@ResponseBody
	public Map<String, Object> uploadTaskOrderCodeFile(TaskOrder taskOrder,
			@RequestParam(value="code_file",required=false) MultipartFile code_file) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			MultipartFile[] fileArr=new MultipartFile[1];
			fileArr[0]=code_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						String folder="TaskOrder/";
						switch (i) {
						case 0:
							folder+="CodeFile";//代码文件
							break;
						}
						jsonStr = FileUploadUtil.appUploadContentImg(fileArr[i],folder);
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								taskOrder.setCodeFileSize(code_file.getSize());
								taskOrder.setCodeFileUrl(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			
			int count=taskOrderService.uploadCodeFile(taskOrder);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "上传代码文件成功！");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "上传代码文件失败！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "创建任务包失败！");
		}
		return jsonMap;
	}
}
