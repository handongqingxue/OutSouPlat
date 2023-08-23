package com.outSouPlat.dao;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface UserMapper {

	//通过用户信息查询用户
	User get(@Param("username") String username, @Param("password") String password);
}
