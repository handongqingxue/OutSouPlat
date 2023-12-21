package com.outSouPlat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.outSouPlat.entity.*;
import com.outSouPlat.service.*;
import com.outSouPlat.util.*;

import javax.servlet.http.*;
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

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TASK_BAG_ADD,request)) {
			//publicService.selectNav(request);
			Constant.setUserPermissionInRequest(request);
			
			url=MODULE_NAME+"/taskBagList/new";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}

	/**
	 * 跳转到任务包管理-任务包列表-编辑页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/taskBagList/edit")
	public String goTaskBagListEdit(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TASK_BAG_EDIT,request)) {
			//publicService.selectNav(request);
			String id = request.getParameter("id");
			TaskBag taskBag=taskBagService.selectById(id);
			request.setAttribute("taskBag", taskBag);
			
			Constant.setUserPermissionInRequest(request);
			
			url=MODULE_NAME+"/taskBagList/edit";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	@RequestMapping(value="/taskBagList/list")
	public String goTaskBagListList(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TASK_BAG_SEAR,request)) {
			//publicService.selectNav(request);
			Constant.setUserPermissionInRequest(request);
			Constant.setTaskBagStateInRequest(request);
			
			url=MODULE_NAME+"/taskBagList/list";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}

	/**
	 * 跳转到任务包管理-任务包列表-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/taskBagList/detail")
	public String goTaskBagListDetail(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TASK_BAG_SEAR,request)) {
			String id = request.getParameter("id");
			TaskBag taskBag=taskBagService.selectById(id);
			request.setAttribute("taskBag", taskBag);
			
			Constant.setUserPermissionInRequest(request);
			
			url=MODULE_NAME+"/taskBagList/detail";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}
	
	@RequestMapping(value="/taskOrder/list")
	public String goTaskOrderList(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TASK_ORDER_SEAR,request)) {
			//publicService.selectNav(request);
	
			Constant.setUserPermissionInRequest(request);
			Constant.setTaskOrderStateInRequest(request);
			Constant.setTestResultInRequest(request);
			
			url=MODULE_NAME+"/taskOrder/list";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
	}

	/**
	 * 跳转到任务包管理-任务单查询-详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/taskOrder/detail")
	public String goTaskOrderDetail(HttpServletRequest request) {

		String url=null;
		if(Constant.checkIfExistPerm(Permission.TASK_ORDER_SEAR,request)) {
			String id = request.getParameter("id");
			TaskOrder taskOrder=taskOrderService.selectById(id);
			request.setAttribute("taskOrder", taskOrder);
	
			Constant.setUserPermissionInRequest(request);
			Constant.setTaskOrderStateInRequest(request);
			Constant.setFilePlaceInRequest(request);
			Constant.setFileTypeInRequest(request);
			
			url=MODULE_NAME+"/taskOrder/detail";
		}
		else
			url=Constant.NO_PERM_RETURN_URL;
		
		return url;
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
						jsonStr = FileUtil.appUploadContentImg(fileArr[i],folder);
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

	@RequestMapping(value="/deleteTaskBagByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteTaskBagByIds(String ids, String annexFileUrls, String projectIds) {
		//TODO 针对分类的动态进行实时调整更新
		int count=taskBagService.deleteByIds(ids,annexFileUrls,projectIds);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除任务包失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除任务包成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
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
						jsonStr = FileUtil.appUploadContentImg(fileArr[i],folder);
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
	
	@RequestMapping(value="/updateOrderUserId")
	@ResponseBody
	public Map<String, Object> updateOrderUserId(Integer id,String name,Integer uploadUserId,Integer orderUserId,String orderUserName,String flag) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=taskBagService.updateOrderUserId(id,name,uploadUserId,orderUserId,orderUserName,flag);
			if(count>0) {
				String info=null;
				if("update".equals(flag))
					info="接单请求已发出，有待发包人同意，请留意系统管理-通知查询。";
				else if("clear".equals(flag))
					info="已发给接单人拒单请求。";
				
				jsonMap.put("message", "ok");
				jsonMap.put("info", info);
			}
			else {
				String info=null;
				if("update".equals(flag))
					info="接单请求发出失败！";
				else if("clear".equals(flag))
					info="拒单请求发出失败！";
					
				jsonMap.put("message", "no");
				jsonMap.put("info", info);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			String info=null;
			if("update".equals(flag))
				info="接单请求发出失败！";
			else if("clear".equals(flag))
				info="拒单请求发出失败！";
			
			jsonMap.put("message", "no");
			jsonMap.put("info", info);
		}
		finally {
			return jsonMap;
		}
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

	@RequestMapping(value="/deleteTaskOrderByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteTaskOrderByIds(String ids, String nos, String projectIds, String codeFileUrls, String taskBagIds, Integer sendUserId, String sendUsername) {
		//TODO 针对分类的动态进行实时调整更新
		int count=taskOrderService.deleteByIds(ids,nos,projectIds,codeFileUrls,taskBagIds,sendUserId,sendUsername);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除任务单失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除任务单成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	@RequestMapping(value="/queryTaskOrderList")
	@ResponseBody
	public Map<String, Object> queryTaskOrderList(String no,String taskBagName,String projectName,String uploadUserName,String orderUserName,String agreeUserName,String createTimeStart,String createTimeEnd,
			String finishTimeStart,String finishTimeEnd,Integer state,Integer userId,int page,int rows,String sort,String order) {
		
		//System.out.println("uploadUserName="+uploadUserName);
		//System.out.println("orderUserName="+orderUserName);
		//System.out.println("agreeUserName="+agreeUserName);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count = taskOrderService.queryForInt(no,taskBagName,projectName,uploadUserName,orderUserName,agreeUserName,createTimeStart,createTimeEnd,finishTimeStart,finishTimeEnd,state,userId);
			List<TaskOrder> taskOrderList=taskOrderService.queryList(no,taskBagName,projectName,uploadUserName,orderUserName,agreeUserName,createTimeStart,createTimeEnd,finishTimeStart,finishTimeEnd,state,userId, page, rows, sort, order);
			
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

	@RequestMapping(value="/startTestOrder",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String startTestOrder(Integer taskOrderId,String taskOrderNo,Integer taskBagId,Integer orderUserId) {
		int count=taskOrderService.startTest(taskOrderId,taskOrderNo,taskBagId,orderUserId);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("开始测试失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("任务单已是测试中状态，请完成测试后上传测试结果。");
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
						jsonStr = FileUtil.appUploadContentImg(fileArr[i],folder);
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

	//http://192.168.1.102:8080/OutSouPlat/taskBagMana/download
	@RequestMapping(value="/download")
	public void download(HttpServletRequest request, HttpServletResponse response) {
		
		Integer place = Integer.valueOf(request.getParameter("place"));
		if(place==FileUtil.LOCAL)
			FileUtil.downloadLocal(request, response);
		else if(place==FileUtil.REMOTE)
			FileUtil.downloadRemote(request, response);
	}
}
