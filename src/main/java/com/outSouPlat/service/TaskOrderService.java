package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface TaskOrderService {

	int add(TaskOrder taskOrder);

	int discardByIds(String ids, String nos, String codeFileUrls, String taskBagIds, Integer sendUserId, String sendUsername);

	int queryForInt(String no, String taskBagName,String uploadUserName, String orderUserName,String agreeUserName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state, Integer userId);

	List<TaskOrder> queryList(String no, String taskBagName,String uploadUserName, String orderUserName,String agreeUserName, String createTimeStart,
			String createTimeEnd, String finishTimeStart, String finishTimeEnd, Integer state, Integer userId, 
			int page, int rows, String sort, String order);

	TaskOrder selectById(String id);

	int uploadCodeFile(TaskOrder taskOrder);

	int startTest(Integer orderId, String orderNo,Integer taskBagId, Integer orderUserId);

	int comfirmPay(String orderIds, String orderNos, String orderUserIds);

	int comfirmPaid(String orderIds, String taskBagIds, String projectIds);
}
