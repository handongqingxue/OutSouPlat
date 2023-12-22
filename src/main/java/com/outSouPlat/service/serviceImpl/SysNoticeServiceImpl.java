package com.outSouPlat.service.serviceImpl;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class SysNoticeServiceImpl implements SysNoticeService {

	@Autowired
	private SysNoticeMapper sysNoticeDao;

	@Override
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return sysNoticeDao.deleteByIdList(idList);
	}

	@Override
	public int queryForInt(String title,String sendUserName,String receiveUserName,String createTimeStart,String createTimeEnd,Boolean read, Integer userId) {
		// TODO Auto-generated method stub
		return sysNoticeDao.queryForInt(title,sendUserName,receiveUserName,createTimeStart,createTimeEnd,read, userId);
	}

	@Override
	public List<SysNotice> queryList(String title,String sendUserName,String receiveUserName,String createTimeStart,String createTimeEnd,Boolean read, Integer userId, 
			int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return sysNoticeDao.queryList(title,sendUserName,receiveUserName,createTimeStart,createTimeEnd,read, userId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public SysNotice selectById(String id) {
		// TODO Auto-generated method stub
		return sysNoticeDao.selectById(id);
	}

	@Override
	public int signRead(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return sysNoticeDao.signRead(idList);
	}
}
