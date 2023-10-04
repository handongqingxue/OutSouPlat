package com.outSouPlat.service.serviceImpl;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.outSouPlat.entity.*;
import com.outSouPlat.dao.*;
import com.outSouPlat.service.*;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userDao;
	@Autowired
	private UserCheckRecMapper userCheckRecDao;
	@Autowired
	private RoleMapper roleDao;
	
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

	@Override
	public User selectById(String id) {
		// TODO Auto-generated method stub
		User user = userDao.selectById(id);
		List<Role> roleList = roleDao.queryCBBList();
		String roleIds = user.getRoleIds();
		if(!StringUtils.isEmpty(roleIds)) {
			String[] roleIdArr = roleIds.split(",");
			String roleNames = "";
			for (String roleIdStr : roleIdArr) {
				int roleId = Integer.valueOf(roleIdStr);
				for (int i = 0; i < roleList.size(); i++) {
					Role role = roleList.get(i);
					if(roleId==role.getId()) {
						roleNames+=","+role.getName();
						break;
					}
				}
			}
			user.setRoleNames(roleNames.substring(1));
		}
		return user;
	}

	@Override
	public int edit(User user) {
		// TODO Auto-generated method stub
		return userDao.edit(user);
	}

	@Override
	public int checkByIds(String ids, UserCheckRec ucr) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		if(userDao.checkByIds(idList,ucr.getResult())>0) {
			for (String idStr : idList) {
				Integer userId = Integer.valueOf(idStr);
				ucr.setUserId(userId);
				count+=userCheckRecDao.add(ucr);
			}
		}
		return count;
	}

	@Override
	public boolean checkPassword(String password, String username) {
		// TODO Auto-generated method stub

		String password1 = userDao.getPasswordByUsername(username);
		if(password1.equals(password)) {
			return true;
		}
		else
			return false;
	}

	@Override
	public int updatePwdById(String password, Integer id) {
		// TODO Auto-generated method stub
		return userDao.updatePwdById(password,id);
	}

}
