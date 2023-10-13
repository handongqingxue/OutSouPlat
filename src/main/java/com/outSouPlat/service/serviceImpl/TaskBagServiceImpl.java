package com.outSouPlat.service.serviceImpl;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class TaskBagServiceImpl implements TaskBagService {

	@Autowired
	private ProjectMapper projectDao;
	@Autowired
	private TaskBagMapper taskBagDao;

	@Override
	public int queryForInt(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state) {
		// TODO Auto-generated method stub
		return taskBagDao.queryForInt(name, projectName, uploadUserName, createTimeStart, createTimeEnd, state);
	}

	@Override
	public List<TaskBag> queryList(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return taskBagDao.queryList(name, projectName, uploadUserName, createTimeStart, 
				createTimeEnd, state, (page-1)*rows, rows, sort, order);
	}

	@Override
	public int add(TaskBag taskBag) {
		// TODO Auto-generated method stub
		int count=0;
		count=taskBagDao.add(taskBag);
		if(count>0)
			count=projectDao.updateTaskBagCountById(Project.ADD_TASK_BAG,taskBag.getProjectId());
		return count;
	}

	@Override
	public int edit(TaskBag taskBag) {
		// TODO Auto-generated method stub
		return taskBagDao.edit(taskBag);
	}

	@Override
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=taskBagDao.deleteByIds(idList);
		return count;
	}

	@Override
	public TaskBag selectById(String id) {
		// TODO Auto-generated method stub
		return taskBagDao.selectById(id);
	}

	@Override
	public int submitById(Integer id) {
		// TODO Auto-generated method stub
		return taskBagDao.updateStateById(TaskBag.UN_ORDER, id);
	}
}
