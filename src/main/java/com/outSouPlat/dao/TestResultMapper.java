package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface TestResultMapper {

	int add(TestResult testResult);

	int deleteByIdList(@Param("idList")List<String> idList);

	int edit(TestResult testResult);

	int queryForInt(@Param("taskOrderNo") String taskOrderNo, @Param("taskBagName") String taskBagName,@Param("projectName") String projectName, @Param("uploadUserName") String uploadUserName, @Param("orderUserName") String orderUserName, @Param("agreeUserName") String agreeUserName, @Param("testUserName") String testUserName, @Param("phone") String phone,
			@Param("createTimeStart") String createTimeStart, @Param("createTimeEnd") String createTimeEnd, @Param("result") Boolean result, @Param("userId") Integer userId, @Param("roleFlag") Integer roleFlag);
	
	List<TestResult> queryList(@Param("taskOrderNo") String taskOrderNo, @Param("taskBagName") String taskBagName,@Param("projectName") String projectName, @Param("uploadUserName") String uploadUserName, @Param("orderUserName") String orderUserName, @Param("agreeUserName") String agreeUserName, @Param("testUserName") String testUserName, @Param("phone") String phone, @Param("createTimeStart") String createTimeStart,
			@Param("createTimeEnd") String createTimeEnd, @Param("result") Boolean result, @Param("userId") Integer userId, @Param("roleFlag") Integer roleFlag, @Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);

	TestResult selectById(@Param("id") String id);
}
