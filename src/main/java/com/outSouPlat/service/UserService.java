package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface UserService {

	int queryForInt(String username, Integer state);

	List<User> queryList(String username, Integer state, int page, int rows, String sort, String order);

	boolean checkUsernameIfExist(String username);

	int add(User user);

	User selectById(String id);

	int edit(User user);

	int checkByIds(String ids, UserCheckRec ucr);

	boolean checkPassword(String password, String username);

	int updatePwdById(String password, Integer id);

}
