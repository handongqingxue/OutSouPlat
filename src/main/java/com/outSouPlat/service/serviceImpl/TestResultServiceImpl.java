package com.outSouPlat.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class TestResultServiceImpl implements TestResultService {

	@Autowired
	private TestResultMapper testResultDao;

	@Override
	public int add(TestResult testResult) {
		// TODO Auto-generated method stub
		return testResultDao.add(testResult);
	}

	@Override
	public int queryForInt(String orderNo, String taskBagName, String testUserName, String phone, String createTimeStart, String createTimeEnd,
			Integer state) {
		// TODO Auto-generated method stub
		return testResultDao.queryForInt(orderNo, taskBagName, testUserName, phone, createTimeStart, createTimeEnd, state);
	}

	@Override
	public List<TestResult> queryList(String orderNo, String taskBagName, String testUserName, String phone, String createTimeStart,
			String createTimeEnd, Integer state, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return testResultDao.queryList(orderNo, taskBagName, testUserName, phone, createTimeStart, createTimeEnd, 
				state, (page-1)*rows, rows, sort, order);
	}
}
