package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface TaskBagMapper {

	int queryForInt(@Param("name") String name, @Param("projectName") String projectName, @Param("uploadUserName") String uploadUserName, 
			@Param("createTimeStart") String createTimeStart, @Param("createTimeEnd") String createTimeEnd, @Param("state") Integer state);

	List<TaskBag> queryList(@Param("name") String name, @Param("projectName") String projectName, @Param("uploadUserName") String uploadUserName, @Param("createTimeStart") String createTimeStart,
			@Param("createTimeEnd") String createTimeEnd, @Param("state") Integer state, @Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);

	int add(TaskBag taskBag);

	int deleteByIds(List<String> idList);

	int edit(TaskBag taskBag);

	TaskBag selectById(@Param("id") String id);

	int updateStateById(@Param("state") int state, @Param("id") Integer id);

}
