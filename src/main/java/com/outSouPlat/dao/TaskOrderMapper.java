package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface TaskOrderMapper {

	int add(TaskOrder taskOrder);

	int queryForInt(@Param("no") String no, @Param("taskBagName") String taskBagName,@Param("uploadUserName") String uploadUserName, @Param("orderUserName") String orderUserName, @Param("agreeUserName") String agreeUserName, @Param("createTimeStart") String createTimeStart, 
			@Param("createTimeEnd") String createTimeEnd, @Param("finishTimeStart") String finishTimeStart, @Param("finishTimeEnd") String finishTimeEnd, @Param("state") Integer state, @Param("userId") Integer userId);

	List<TaskOrder> queryList(@Param("no") String no, @Param("taskBagName") String taskBagName,@Param("uploadUserName") String uploadUserName, @Param("orderUserName") String orderUserName, @Param("agreeUserName") String agreeUserName, @Param("createTimeStart") String createTimeStart,
			@Param("createTimeEnd") String createTimeEnd, @Param("finishTimeStart") String finishTimeStart, @Param("finishTimeEnd") String finishTimeEnd, @Param("state") Integer state, @Param("userId") Integer userId, 
			@Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);

	TaskOrder selectById(@Param("id") String id);

	int uploadCodeFile(TaskOrder taskOrder);

	int updateStateByIdList(@Param("state") int state, @Param("idList")List<String> idList);
}
