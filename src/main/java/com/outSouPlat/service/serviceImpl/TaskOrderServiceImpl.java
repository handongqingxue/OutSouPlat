package com.outSouPlat.service.serviceImpl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;
import com.outSouPlat.util.FileUtil;

@Service
public class TaskOrderServiceImpl implements TaskOrderService {

	@Autowired
	private TaskOrderMapper taskOrderDao;
	@Autowired
	private TaskBagMapper taskBagDao;
	@Autowired
	private ProjectMapper projectDao;
	@Autowired
	private SysNoticeMapper sysNoticeDao;
	private DateFormat yMdHmsSDF=new SimpleDateFormat("yyyyMMddHHmmss");

	@Override
	public int add(TaskOrder taskOrder) {
		// TODO Auto-generated method stub
		int count=0;
		Integer taskBagId = taskOrder.getTaskBagId();
		Integer projectId = taskOrder.getProjectId();
		String taskOrderNo = yMdHmsSDF.format(new Date())+"_"+taskBagId+"_"+taskOrder.getAgreeUserId()+"_"+taskOrder.getOrderUserId();
		taskOrder.setNo(taskOrderNo);
		count=taskOrderDao.add(taskOrder);
		if(count>0) {
			count=taskBagDao.updateStateById(TaskBag.DEVELOPING,taskBagId);
			
			Project project = projectDao.selectById(projectId+"");
			if(project.getState()==Project.UN_CONTRACT) {
				projectDao.updateStateById(Project.CONTRACTED, projectId);
			}
			
			projectDao.updateOutCountById(Project.ADD_OUT, 1, projectId);

			Integer agreeUserId = taskOrder.getAgreeUserId();
			String agreeUserName = taskOrder.getAgreeUserName();
			Integer receiveUserId = taskOrder.getOrderUserId();
			
			SysNotice sysNotice=new SysNotice();
			sysNotice.setSendUserId(agreeUserId);
			sysNotice.setReceiveUserId(receiveUserId);
			sysNotice.setTitle("任务单批准通过");
			sysNotice.setContent("您申请的任务单已批准通过，任务单号"+taskOrderNo+"，批准用户"+agreeUserName+"，请到任务包管理-任务单查询里查看。");
			sysNoticeDao.add(sysNotice);
		}
		return count;
	}

	@Override
	public int deleteByIds(String ids, String nos, String projectIds, String codeFileUrls, String taskBagIds, Integer sendUserId, String sendUsername) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=taskOrderDao.deleteByIdList(idList);
		if(count>0) {
			FileUtil.delete(codeFileUrls);
			List<String> taskBagIdList = Arrays.asList(taskBagIds.split(","));
			count=taskBagDao.updateStateByIdList(TaskBag.UN_ORDER,taskBagIdList);

			Map<String,Integer> projectIdCountMap=new HashMap<String,Integer>();
			List<String> projectIdList = Arrays.asList(projectIds.split(","));
			for (String projectId : projectIdList) {
				boolean projectIdExist = checkIfProjectIdExistInMap(projectId,projectIdCountMap);
				if(projectIdExist) {
					int projectIdCount = Integer.valueOf(projectIdCountMap.get(projectId).toString());
					projectIdCount++;
					projectIdCountMap.put(projectId, projectIdCount);
				}
				else {
					projectIdCountMap.put(projectId,1);
				}
			}
			Set<String> projectIdKeySet = projectIdCountMap.keySet();
			for (String projectIdKey : projectIdKeySet) {
				int projectId = Integer.valueOf(projectIdKey);
				int outCount = Integer.valueOf(projectIdCountMap.get(projectIdKey).toString());
				projectDao.updateOutCountById(Project.DEL_OUT, outCount, projectId);
			}
			
			SysNotice sysNotice=new SysNotice();
			sysNotice.setSendUserId(sendUserId);
			sysNotice.setTitle("任务单废弃");
			sysNotice.setContent("任务单"+nos+"已删除，操作用户"+sendUsername);
			sysNoticeDao.add(sysNotice);
		}
		return count;
	}
	
	private boolean checkIfProjectIdExistInMap(String projectId, Map<String,Integer> projectIdCountMap) {
		boolean exist = false;
		Set<String> projectIdKeySet = projectIdCountMap.keySet();
		for (String projectIdKey : projectIdKeySet) {
			if(projectIdKey.equals(projectId)) {
				exist=true;
				break;
			}
		}
		return exist;
	}

	@Override
	public int queryForInt(String no, String taskBagName,String projectName,String uploadUserName, String orderUserName,String agreeUserName, String createTimeStart, String createTimeEnd,
			String finishTimeStart, String finishTimeEnd, Integer state, Integer userId) {
		// TODO Auto-generated method stub
		return taskOrderDao.queryForInt(no, taskBagName, projectName, uploadUserName, orderUserName, agreeUserName, createTimeStart, createTimeEnd, finishTimeStart, finishTimeEnd, state, userId);
	}

	@Override
	public List<TaskOrder> queryList(String no, String taskBagName,String projectName,String uploadUserName, String orderUserName,String agreeUserName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state, Integer userId, 
			int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return taskOrderDao.queryList(no, taskBagName, projectName, uploadUserName, orderUserName, agreeUserName, createTimeStart, createTimeEnd, 
				finishTimeStart, finishTimeEnd, state, userId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public TaskOrder selectById(String id) {
		// TODO Auto-generated method stub
		return taskOrderDao.selectById(id);
	}

	@Override
	public int uploadCodeFile(TaskOrder taskOrder) {
		// TODO Auto-generated method stub
		int count=0;
		count=taskOrderDao.uploadCodeFile(taskOrder);
		if(count>0) {
			SysNotice sysNotice=new SysNotice();
			sysNotice.setSendUserId(taskOrder.getOrderUserId());
			sysNotice.setTitle("任务单代码上传通知");
			sysNotice.setContent("任务单"+taskOrder.getNo()+"代码已上传，请下载代码测试。");
			sysNoticeDao.add(sysNotice);
		}
		return count;
	}

	@Override
	public int startTest(Integer taskOrderId, String taskOrderNo,Integer taskBagId, Integer orderUserId) {
		// TODO Auto-generated method stub
		int count=0;
		count=taskOrderDao.updateStateById(TaskOrder.TESTING, taskOrderId);
		if(count>0) {
			taskBagDao.updateStateById(TaskBag.TESTING, taskBagId);
			
			SysNotice sysNotice=new SysNotice();
			sysNotice.setReceiveUserId(orderUserId);
			sysNotice.setTitle("任务单测试通知");
			sysNotice.setContent("任务单"+taskOrderNo+"已开始测试，请等待测试结果。");
			sysNoticeDao.add(sysNotice);
			
		}
		return count;
	}
}
