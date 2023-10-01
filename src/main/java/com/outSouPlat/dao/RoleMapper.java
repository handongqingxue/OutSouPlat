package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface RoleMapper {

	int add(Role role);

	int queryForInt(@Param("name") String name);

	List<Role> queryList(@Param("name") String name, @Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);

	List<Role> queryCBBList();
}
