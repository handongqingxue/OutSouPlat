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
	public List<Role> queryCBBList() {
		// TODO Auto-generated method stub
		return roleDao.queryCBBList();
	}
}
