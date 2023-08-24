package com.outSouPlat.service.serviceImpl;

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
	public int queryForInt(String name, String deveLang, String database, String deveTool, Integer outCount,
			Integer taskBagCount, String createTimeStart, String createTimeEnd, Integer state) {
		// TODO Auto-generated method stub
		return projectDao.queryForInt(name, deveLang, database, deveTool, outCount, taskBagCount, createTimeStart, createTimeEnd, state);
	}

	@Override
	public List<Project> queryList(String name, String deveLang, String database, String deveTool, Integer outCount,
			Integer taskBagCount, String createTimeStart, String createTimeEnd, Integer state, int page, int rows,
			String sort, String order) {
		// TODO Auto-generated method stub
		return projectDao.queryList(name, deveLang, database, deveTool, outCount, taskBagCount, createTimeStart, 
				createTimeEnd, state, (page-1)*rows, rows, sort, order);
	}

}
