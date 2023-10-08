package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface TestResultMapper {

	int queryForInt(@Param("orderNo") String orderNo, @Param("taskBagName") String taskBagName, @Param("testUserName") String testUserName, 
			@Param("createTimeStart") String createTimeStart, @Param("createTimeEnd") String createTimeEnd, @Param("state") Integer state);
	
	List<TestResult> queryList(@Param("orderNo") String orderNo, @Param("taskBagName") String taskBagName, @Param("testUserName") String testUserName, @Param("createTimeStart") String createTimeStart,
			@Param("createTimeEnd") String createTimeEnd, @Param("state") Integer state, @Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);
}