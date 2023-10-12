package com.outSouPlat.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		Constant.setUserPermissionInRequest(request);
		
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
		
		Constant.setUserPermissionInRequest(request);
		
		return MODULE_NAME+"/taskBagList/edit";
	}
	
	@RequestMapping(value="/taskBagList/list")
	public String goTaskBagListList(HttpServletRequest request) {
		
		//publicService.selectNav(request);
		Constant.setUserPermissionInRequest(request);
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
		
		Constant.setUserPermissionInRequest(request);
			
		return MODULE_NAME+"/taskBagList/detail";
	}
	
	@RequestMapping(value="/taskOrder/list")
	public String goTaskOrderList(HttpServletRequest request) {
		
		//publicService.selectNav(request);

		Constant.setUserPermissionInRequest(request);
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

		Constant.setUserPermissionInRequest(request);
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

	//https://blog.csdn.net/m0_59800431/article/details/129662276
	//http://192.168.1.102:8080/OutSouPlat/taskBagMana/downloadLocal
	@RequestMapping(value="/downloadLocal")
	public void downloadLocal(HttpServletRequest request, HttpServletResponse response) {
		try {
			//1.要获取下载文件的路径
			String realPath = "D:/resource/OutSouPlat/TaskBag/annex/1695712914708.txt";
			System.out.println("下载文件的路径："+realPath);
			//2.下载的文件名是什么？
			String filename = realPath.substring(realPath.lastIndexOf("/") + 1);
			//3.设置想办法让浏览器能够支持下载我们需要的东西
			response.setHeader("Content-Disposition","attachment;filename="+filename);
			//4.获取下载文件的输入流
			FileInputStream in = new FileInputStream(realPath);
			//5.创建缓冲区
			int len=0;
			byte[] buffer = new byte[1024];
			//6.获取OutputStream对象
			ServletOutputStream out = response.getOutputStream();
			//7.将FileOutputStream流写入到buffer缓冲区,使用OutputStream将缓冲区中的数据输出到客户端
			while((len=in.read(buffer))>0) {
			    out.write(buffer,0,len);
			}
			in.close();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//http://192.168.1.102:8080/OutSouPlat/taskBagMana/downloadRemote
	@RequestMapping(value="/downloadRemote")
	public void downloadRemote(HttpServletRequest request, HttpServletResponse response) {
		try {
			//1.要获取下载文件的路径
			String realPath = "http://192.168.1.102:8080//OutSouPlat//upload//TaskBag//annex//3H3fcrenzheshengui3wudiban.rar";
			System.out.println("下载文件的路径："+realPath);
			//2.下载的文件名是什么？
			String filename = realPath.substring(realPath.lastIndexOf("//") + 2);
			//3.设置想办法让浏览器能够支持下载我们需要的东西
			response.setHeader("Content-Disposition","attachment;filename="+filename);
			//4.获取下载文件的输入流
			URL url = new URL(realPath);
			URLConnection conn = url.openConnection();
			InputStream in = conn.getInputStream();
			//5.创建缓冲区
			int len=0;
			byte[] buffer = new byte[1024];
			//6.获取OutputStream对象
			ServletOutputStream out = response.getOutputStream();
			//7.将FileOutputStream流写入到buffer缓冲区,使用OutputStream将缓冲区中的数据输出到客户端
			while((len=in.read(buffer))>0) {
			    out.write(buffer,0,len);
			}
			in.close();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
