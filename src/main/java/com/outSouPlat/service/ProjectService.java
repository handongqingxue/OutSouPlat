package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface ProjectService {

	public int add(Project project);

	public int edit(Project project);

	int queryForInt(String name,String deveLang,String database,String deveTool,String createTimeStart,String createTimeEnd,Integer state);

	List<Project> queryList(String name,String deveLang,String database,String deveTool,String createTimeStart,String createTimeEnd,
			Integer state, int page, int rows, String sort, String order);

	public Project selectById(String id);

	public List<Project> queryCBBList();
}
