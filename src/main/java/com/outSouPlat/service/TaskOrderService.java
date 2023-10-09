package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface TaskOrderService {

	int add(TaskOrder taskOrder);

	int queryForInt(String no, String taskBagName, String userName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state);

	List<TaskOrder> queryList(String no, String taskBagName, String userName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state, 
			int page, int rows, String sort, String order);

	TaskOrder selectById(String id);

	int uploadCodeFile(TaskOrder taskOrder);
}
