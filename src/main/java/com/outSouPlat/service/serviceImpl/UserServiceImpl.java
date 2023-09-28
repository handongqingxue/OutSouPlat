package com.outSouPlat.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.dao.*;
import com.outSouPlat.entity.User;
import com.outSouPlat.service.*;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userDao;
	
	@Override
	public int queryForInt(String username, Integer state) {
		// TODO Auto-generated method stub
		return userDao.queryForInt(username,state);
	}

	@Override
	public List<User> queryList(String username, Integer state, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return userDao.queryList(username, state, (page-1)*rows, rows, sort, order);
	}

	@Override
	public boolean checkUsernameIfExist(String username) {
		// TODO Auto-generated method stub
		int count=userDao.getCountByUsername(username);
		return count==0?false:true;
	}

	@Override
	public int add(User user) {
		// TODO Auto-generated method stub
		return userDao.add(user);
	}

}
