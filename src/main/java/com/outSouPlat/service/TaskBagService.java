package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface TaskBagService {

	int queryForInt(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state);

	List<TaskBag> queryList(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state, int page, int rows, String sort, String order);

	int add(TaskBag taskBag);

	int deleteByIds(String ids, String annexFileUrls, String projectIds);

	int edit(TaskBag taskBag);

	TaskBag selectById(String id);

	int submitById(Integer id);

	int updateOrderUserId(Integer id, String name, Integer uploadUserId, Integer orderUserId, String orderUserName, String flag);

}
