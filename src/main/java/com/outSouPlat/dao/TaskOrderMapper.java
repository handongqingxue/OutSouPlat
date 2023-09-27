package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface TaskOrderMapper {

	int queryForInt(@Param("no") String no, @Param("taskBagName") String taskBagName, @Param("userName") String userName, @Param("createTimeStart") String createTimeStart, 
			@Param("createTimeEnd") String createTimeEnd, @Param("finishTimeStart") String finishTimeStart, @Param("finishTimeEnd") String finishTimeEnd, @Param("state") Integer state);

	List<TaskOrder> queryList(@Param("no") String no, @Param("taskBagName") String taskBagName, @Param("userName") String userName, @Param("createTimeStart") String createTimeStart,
			@Param("createTimeEnd") String createTimeEnd, @Param("finishTimeStart") String finishTimeStart, @Param("finishTimeEnd") String finishTimeEnd, @Param("state") Integer state, 
			@Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);

	TaskOrder selectById(@Param("id") String id);
}
