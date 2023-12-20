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
	@Autowired
	private TaskOrderMapper taskOrderDao;
	@Autowired
	private TaskBagMapper taskBagDao;
	@Autowired
	private SysNoticeMapper sysNoticeDao;

	@Override
	public int add(TestResult testResult) {
		// TODO Auto-generated method stub
		int count=0;
		count=testResultDao.add(testResult);
		if(count>0) {
			Boolean result = testResult.getResult();
			int state=result?TaskOrder.UN_PAY:TaskOrder.REWORKING;
			taskOrderDao.updateStateById(state, testResult.getOrderId());
			if(!result)
				taskBagDao.updateStateById(TaskBag.DEVELOPING, testResult.getBagId());
			
			SysNotice sysNotice=new SysNotice();
			sysNotice.setSendUserId(testResult.getTestUserId());
			sysNotice.setReceiveUserId(testResult.getOrderUserId());
			sysNotice.setTitle("测试结果通知");
			sysNotice.setContent("您的任务单号"+testResult.getOrderNo()+"测试"+(result?"合格":"不合格")+"，测试用户"+testResult.getTestUserName()+"，请到测试结果-综合查询里查看。");
			sysNoticeDao.add(sysNotice);
		}
		return count;
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
