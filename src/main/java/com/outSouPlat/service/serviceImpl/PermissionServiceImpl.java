package com.outSouPlat.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	private PermissionMapper permissionDao;

	@Override
	public int add(Permission permission) {
		// TODO Auto-generated method stub
		return permissionDao.add(permission);
	}

	@Override
	public int queryForInt(String name) {
		// TODO Auto-generated method stub
		return permissionDao.queryForInt(name);
	}

	@Override
	public List<Permission> queryList(String name, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return permissionDao.queryList(name, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<Permission> queryCBBList() {
		// TODO Auto-generated method stub
		return permissionDao.queryCBBList();
	}
}
