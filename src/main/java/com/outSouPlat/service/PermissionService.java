package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface PermissionService {

	int add(Permission permission);

	int queryForInt(String name);

	List<Permission> queryList(String name, int page, int rows, String sort, String order);

	List<Permission> queryCBBList();

}
