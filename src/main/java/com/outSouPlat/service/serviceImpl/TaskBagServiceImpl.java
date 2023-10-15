package com.outSouPlat.service.serviceImpl;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;
import com.outSouPlat.util.FileUtil;

@Service
public class TaskBagServiceImpl implements TaskBagService {

	@Autowired
	private ProjectMapper projectDao;
	@Autowired
	private TaskBagMapper taskBagDao;

	@Override
	public int queryForInt(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state) {
		// TODO Auto-generated method stub
		return taskBagDao.queryForInt(name, projectName, uploadUserName, createTimeStart, createTimeEnd, state);
	}

	@Override
	public List<TaskBag> queryList(String name, String projectName, String uploadUserName, String createTimeStart,
			String createTimeEnd, Integer state, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return taskBagDao.queryList(name, projectName, uploadUserName, createTimeStart, 
				createTimeEnd, state, (page-1)*rows, rows, sort, order);
	}

	@Override
	public int add(TaskBag taskBag) {
		// TODO Auto-generated method stub
		int count=0;
		count=taskBagDao.add(taskBag);
		if(count>0)
			count=projectDao.updateTaskBagCountById(Project.ADD_TASK_BAG,count,taskBag.getProjectId());
		return count;
	}

	@Override
	public int edit(TaskBag taskBag) {
		// TODO Auto-generated method stub
		return taskBagDao.edit(taskBag);
	}

	@Override
	public int deleteByIds(String ids, String annexFileUrls, String projectIds) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=taskBagDao.deleteByIds(idList);
		if(count>0) {
			List<HashMap<String,Integer>> countList=createCountListByProIds(projectIds);
			for (HashMap<String,Integer> countMap : countList) {
				Integer projectId = Integer.valueOf(countMap.get("projectId").toString());
				Integer taskBagCount = Integer.valueOf(countMap.get("taskBagCount").toString());
				projectDao.updateTaskBagCountById(Project.DEL_TASK_BAG,taskBagCount,projectId);
			}
			FileUtil.delete(annexFileUrls);
		}
		return count;
	}
	
	private List<HashMap<String,Integer>> createCountListByProIds(String projectIds) {
		List<HashMap<String,Integer>> countList=new ArrayList<HashMap<String,Integer>>();
		String[] projectIdArr = projectIds.split(",");
		for (int i = 0; i < projectIdArr.length; i++) {
			Integer projectId = Integer.valueOf(projectIdArr[i]);
			if(!checkProIdIfExistInList(projectId,countList)) {
				addProInCountList(projectId,countList);
			}
		}
		return countList;
	}
	
	private void addProInCountList(Integer projectId, List<HashMap<String,Integer>> countList) {
		HashMap<String, Integer> countMap = new HashMap<String,Integer>();
		countMap.put("projectId", projectId);
		countMap.put("taskBagCount", 1);
		countList.add(countMap);
	}
	
	private boolean checkProIdIfExistInList(Integer projectId, List<HashMap<String, Integer>> countList) {
		boolean exist=false;
		for (Map<String, Integer> countMap : countList) {
			Integer mapProjectId = Integer.valueOf(countMap.get("projectId").toString());
			if(projectId==mapProjectId) {
				exist=true;
				Integer mapTaskBagCount = Integer.valueOf(countMap.get("taskBagCount").toString());
				mapTaskBagCount++;
				countMap.put("taskBagCount",mapTaskBagCount);
				break;
			}
		}
		return exist;
	}

	@Override
	public TaskBag selectById(String id) {
		// TODO Auto-generated method stub
		return taskBagDao.selectById(id);
	}

	@Override
	public int submitById(Integer id) {
		// TODO Auto-generated method stub
		return taskBagDao.updateStateById(TaskBag.UN_ORDER, id);
	}
}
