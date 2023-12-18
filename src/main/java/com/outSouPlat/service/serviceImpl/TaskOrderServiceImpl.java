package com.outSouPlat.service.serviceImpl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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
	private SysNoticeMapper sysNoticeDao;
	private DateFormat yMdHmsSDF=new SimpleDateFormat("yyyyMMddHHmmss");

	@Override
	public int add(TaskOrder taskOrder) {
		// TODO Auto-generated method stub
		int count=0;
		Integer taskBagId = taskOrder.getTaskBagId();
		String taskOrderNo = yMdHmsSDF.format(new Date())+"_"+taskBagId+"_"+taskOrder.getAgreeUserId()+"_"+taskOrder.getOrderUserId();
		taskOrder.setNo(taskOrderNo);
		count=taskOrderDao.add(taskOrder);
		if(count>0) {
			count=taskBagDao.updateStateById(TaskBag.DEVELOPING,taskBagId);

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
	public int discardByIds(String ids, String nos, String codeFileUrls, String taskBagIds, Integer sendUserId, String sendUsername) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=taskOrderDao.updateStateByIdList(TaskOrder.DISCARDED,idList);
		if(count>0) {
			FileUtil.delete(codeFileUrls);
			List<String> taskBagIdList = Arrays.asList(taskBagIds.split(","));
			count=taskBagDao.updateStateByIdList(TaskBag.UN_ORDER,taskBagIdList);
			
			SysNotice sysNotice=new SysNotice();
			sysNotice.setSendUserId(sendUserId);
			sysNotice.setTitle("任务单废弃");
			sysNotice.setContent("任务单"+nos+"已废弃，操作用户"+sendUsername);
			sysNoticeDao.add(sysNotice);
		}
		return count;
	}

	@Override
	public int queryForInt(String no, String taskBagName,String uploadUserName, String orderUserName,String agreeUserName, String createTimeStart, String createTimeEnd,
			String finishTimeStart, String finishTimeEnd, Integer state, Integer userId) {
		// TODO Auto-generated method stub
		return taskOrderDao.queryForInt(no, taskBagName, uploadUserName, orderUserName, agreeUserName, createTimeStart, createTimeEnd, finishTimeStart, finishTimeEnd, state, userId);
	}

	@Override
	public List<TaskOrder> queryList(String no, String taskBagName,String uploadUserName, String orderUserName,String agreeUserName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state, Integer userId, 
			int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return taskOrderDao.queryList(no, taskBagName, uploadUserName, orderUserName, agreeUserName, createTimeStart, createTimeEnd, 
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
		return taskOrderDao.uploadCodeFile(taskOrder);
	}
}
