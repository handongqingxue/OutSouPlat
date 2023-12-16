package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface TestResultService {

	int add(TestResult testResult);

	int edit(TestResult testResult);

	int queryForInt(String orderNo, String taskBagName, String testUserName, String phone, String createTimeStart,
			String createTimeEnd, Integer state, Integer userId, Integer roleFlag);

	List<TestResult> queryList(String orderNo, String taskBagName, String testUserName, String phone, String createTimeStart,
			String createTimeEnd, Integer state, Integer userId, Integer roleFlag, int page, int rows, String sort, String order);

	TestResult selectById(String id);
}
