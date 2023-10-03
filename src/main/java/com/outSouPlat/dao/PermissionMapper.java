package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface PermissionMapper {

	int add(Permission permission);

	int queryForInt(@Param("name") String name);

	List<Permission> queryList(@Param("name") String name, @Param("rowNum") int rowNum, @Param("rows") int rows, String sort, String order);

	List<Permission> queryCBBList();

}
