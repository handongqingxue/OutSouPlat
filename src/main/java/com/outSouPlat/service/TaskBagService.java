package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.TaskBag;

public interface TaskBagService {

	int queryForInt(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state);

	List<TaskBag> queryList(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state, int page, int rows, String sort, String order);

}
