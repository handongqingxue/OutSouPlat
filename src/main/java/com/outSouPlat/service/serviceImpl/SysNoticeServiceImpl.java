package com.outSouPlat.service.serviceImpl;

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
	public int queryForInt(String title) {
		// TODO Auto-generated method stub
		return sysNoticeDao.queryForInt(title);
	}

	@Override
	public List<SysNotice> queryList(String title, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return sysNoticeDao.queryList(title, (page-1)*rows, rows, sort, order);
	}
}
