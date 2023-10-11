package com.outSouPlat.service.serviceImpl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleMapper roleDao;
	@Autowired
	private PermissionMapper permissionDao;

	@Override
	public int add(Role role) {
		// TODO Auto-generated method stub
		return roleDao.add(role);
	}

	@Override
	public int edit(Role role) {
		// TODO Auto-generated method stub
		return roleDao.edit(role);
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
		Role role = roleDao.selectById(id);
		List<Permission> permissionList = permissionDao.queryCBBList();
		String permissionIds = role.getPermissionIds();
		if(!StringUtils.isEmpty(permissionIds)) {
			String[] permissionIdArr = permissionIds.split(",");
			String permissionNames = "";
			for (String permissionIdStr : permissionIdArr) {
				int permissionId = Integer.valueOf(permissionIdStr);
				for (int i = 0; i < permissionList.size(); i++) {
					Permission permission = permissionList.get(i);
					if(permissionId==permission.getId()) {
						permissionNames+=","+permission.getName();
						break;
					}
				}
			}
			role.setPermissionNames(permissionNames.substring(1));
		}
		return role;
	}

	@Override
	public String getPermissionIdsByIds(String ids) {
		// TODO Auto-generated method stub
		String[] roleIdArr = ids.split(",");
		List<String> permissionIdList=new ArrayList<String>();
		List<String> roleIdList = Arrays.asList(roleIdArr);
		List<String> permissionIdsList=roleDao.getPermissionIdsListByIdList(roleIdList);
		for (int i = 0; i < permissionIdsList.size(); i++) {
			String permissionIds = permissionIdsList.get(i);
			String[] permissionIdArr = permissionIds.split(",");
			for (int j = 0; j < permissionIdArr.length; j++) {
				String permissionId=permissionIdArr[j];
				boolean exist=checkPermissionIdExistInList(permissionId,permissionIdList);
				if(!exist)
					permissionIdList.add(permissionId);
			}
		}
		String permissionIds="";
		for (int i = 0; i < permissionIdList.size(); i++) {
			String permissionId = permissionIdList.get(i);
			permissionIds+=","+permissionId;
		}
		return permissionIds.substring(1);
	}

	private boolean checkPermissionIdExistInList(String checkPermissionId, List<String> permissionIdList) {
		// TODO Auto-generated method stub
		boolean exist=false;
		for (int i = 0; i < permissionIdList.size(); i++) {
			String permissionId = permissionIdList.get(i);
			if(checkPermissionId.equals(permissionId)) {
				exist=true;
				break;
			}
		}
		return exist;
	}
}
