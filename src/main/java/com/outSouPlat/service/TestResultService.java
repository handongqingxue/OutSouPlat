package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface TestResultService {

	int queryForInt(String orderNo, String taskBagName, String testUserName, String createTimeStart,
			String createTimeEnd, Integer state);

	List<TestResult> queryList(String orderNo, String taskBagName, String testUserName, String createTimeStart,
			String createTimeEnd, Integer state, int page, int rows, String sort, String order);
}
