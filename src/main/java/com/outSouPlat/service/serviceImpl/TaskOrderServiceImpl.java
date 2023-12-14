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
	private DateFormat yMdHmsSDF=new SimpleDateFormat("yyyyMMddHHmmss");

	@Override
	public int add(TaskOrder taskOrder) {
		// TODO Auto-generated method stub
		int count=0;
		Integer taskBagId = taskOrder.getTaskBagId();
		taskOrder.setNo(yMdHmsSDF.format(new Date())+taskBagId+taskOrder.getUserId());
		count=taskOrderDao.add(taskOrder);
		if(count>0)
			count=taskBagDao.updateStateById(TaskBag.DEVELOPING,taskBagId);
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
		}
		return count;
	}

	@Override
	public int queryForInt(String no, String taskBagName, String userName, String createTimeStart, String createTimeEnd,
			String finishTimeStart, String finishTimeEnd, Integer state) {
		// TODO Auto-generated method stub
		return taskOrderDao.queryForInt(no, taskBagName, userName, createTimeStart, createTimeEnd, finishTimeStart, finishTimeEnd, state);
	}

	@Override
	public List<TaskOrder> queryList(String no, String taskBagName, String userName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state, int page, int rows,
			String sort, String order) {
		// TODO Auto-generated method stub
		return taskOrderDao.queryList(no, taskBagName, userName, createTimeStart, createTimeEnd, 
				finishTimeStart, finishTimeEnd, state, (page-1)*rows, rows, sort, order);
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
