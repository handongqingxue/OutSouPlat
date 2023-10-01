package com.outSouPlat.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleMapper roleDao;

	@Override
	public int add(Role role) {
		// TODO Auto-generated method stub
		return roleDao.add(role);
	}

	@Override
	public int queryForInt(String name) {
		// TODO Auto-generated method stub
		return roleDao.queryForInt(name);
	}

	@Override
	public List<Role> queryList(String name, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return roleDao.queryList(name, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<Role> queryCBBList() {
		// TODO Auto-generated method stub
		return roleDao.queryCBBList();
	}

	@Override
	public Role selectById(String id) {
		// TODO Auto-generated method stub
		return roleDao.selectById(id);
	}
}
