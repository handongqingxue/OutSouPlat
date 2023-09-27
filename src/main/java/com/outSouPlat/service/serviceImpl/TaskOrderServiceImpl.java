package com.outSouPlat.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class TaskOrderServiceImpl implements TaskOrderService {

	@Autowired
	private TaskOrderMapper taskOrderDao;

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
}
