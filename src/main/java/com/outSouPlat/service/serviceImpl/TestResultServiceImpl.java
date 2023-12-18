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
	public int edit(TestResult testResult) {
		// TODO Auto-generated method stub
		return testResultDao.edit(testResult);
	}

	@Override
	public int queryForInt(String orderNo, String taskBagName, String uploadUserName, String orderUserName, String agreeUserName, String testUserName, String phone, String createTimeStart, String createTimeEnd,
			Boolean result, Integer userId, Integer roleFlag) {
		// TODO Auto-generated method stub
		return testResultDao.queryForInt(orderNo, taskBagName, uploadUserName, orderUserName, agreeUserName, testUserName, phone, createTimeStart, createTimeEnd, result, userId, roleFlag);
	}

	@Override
	public List<TestResult> queryList(String orderNo, String taskBagName, String uploadUserName, String orderUserName, String agreeUserName, String testUserName, String phone, String createTimeStart,
			String createTimeEnd, Boolean result, Integer userId, Integer roleFlag, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return testResultDao.queryList(orderNo, taskBagName, uploadUserName, orderUserName, agreeUserName, testUserName, phone, createTimeStart, createTimeEnd, 
				result, userId, roleFlag, (page-1)*rows, rows, sort, order);
	}

	@Override
	public TestResult selectById(String id) {
		// TODO Auto-generated method stub
		return testResultDao.selectById(id);
	}
}
