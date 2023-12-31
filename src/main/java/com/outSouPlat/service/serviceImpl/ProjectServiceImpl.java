package com.outSouPlat.service.serviceImpl;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Autowired
	private ProjectMapper projectDao;

	@Override
	public int add(Project project) {
		// TODO Auto-generated method stub
		return projectDao.add(project);
	}

	@Override
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=projectDao.deleteByIds(idList);
		return count;
	}

	@Override
	public int edit(Project project) {
		// TODO Auto-generated method stub
		return projectDao.edit(project);
	}

	@Override
	public int queryForInt(String name, String deveLang, String database, String deveTool, String createTimeStart, String createTimeEnd, Integer state) {
		// TODO Auto-generated method stub
		return projectDao.queryForInt(name, deveLang, database, deveTool, createTimeStart, createTimeEnd, state);
	}

	@Override
	public List<Project> queryList(String name, String deveLang, String database, String deveTool, String createTimeStart, String createTimeEnd, Integer state, int page, int rows,
			String sort, String order) {
		// TODO Auto-generated method stub
		return projectDao.queryList(name, deveLang, database, deveTool, createTimeStart, 
				createTimeEnd, state, (page-1)*rows, rows, sort, order);
	}

	@Override
	public Project selectById(String id) {
		// TODO Auto-generated method stub
		return projectDao.selectById(id);
	}

	@Override
	public List<Project> queryCBBList() {
		// TODO Auto-generated method stub
		return projectDao.queryCBBList();
	}
}
