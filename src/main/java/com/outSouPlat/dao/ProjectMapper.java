package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface ProjectMapper {

	int add(Project project);

	int edit(Project project);

	int queryForInt(@Param("name") String name, @Param("deveLang") String deveLang, @Param("database") String database, @Param("deveTool") String deveTool, @Param("createTimeStart") String createTimeStart, @Param("createTimeEnd") String createTimeEnd, @Param("state") Integer state);

	List<Project> queryList(@Param("name") String name, @Param("deveLang") String deveLang, @Param("database") String database, @Param("deveTool") String deveTool, @Param("createTimeStart") String createTimeStart, @Param("createTimeEnd") String createTimeEnd, @Param("state") Integer state, 
			@Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);

	Project selectById(String id);

}
