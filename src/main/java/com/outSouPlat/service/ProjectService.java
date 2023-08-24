package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface ProjectService {

	int queryForInt(String name,String deveLang,String database,String deveTool,Integer outCount,
			Integer taskBagCount,String createTimeStart,String createTimeEnd,Integer state);

	List<Project> queryList(String name,String deveLang,String database,String deveTool,Integer outCount,
			Integer taskBagCount,String createTimeStart,String createTimeEnd,Integer state, int page, int rows, String sort, String order);
}
