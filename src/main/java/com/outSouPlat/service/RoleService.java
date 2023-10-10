package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface RoleService {

	int add(Role role);

	int edit(Role role);

	int queryForInt(String name);

	List<Role> queryList(String name, int page, int rows, String sort, String order);

	List<Role> queryCBBList();

	Role selectById(String id);

	String getPermissionIdsByIds(String ids);
}
