package com.outSouPlat.util.shiro.realm;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.outSouPlat.dao.*;
import com.outSouPlat.entity.*;

public class MyRealm extends AuthorizingRealm {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private RoleMapper roleDao;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		// TODO Auto-generated method stub
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		User resultMsg=userMapper.get(token.getUsername(),String.valueOf(token.getPassword()));
		if(token.getUsername().equals(resultMsg.getUsername())&&
		   String.valueOf(token.getPassword()).equals(resultMsg.getPassword())){
			String roleNames = "";
			String username = resultMsg.getUsername();
			if("admin".equals(username)) {
				roleNames="超级管理员";
			}
			else {
				List<Role> roleList = roleDao.queryCBBList();
				String roleIds = resultMsg.getRoleIds();
				if(!StringUtils.isEmpty(roleIds)) {
					String[] roleIdArr = roleIds.split(",");
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
					roleNames=roleNames.substring(1);
				}
			}
			resultMsg.setRoleNames(roleNames);
			return new SimpleAuthenticationInfo(resultMsg,resultMsg.getPassword(),resultMsg.getUsername());
		}
		else{
			throw new AuthenticationException();
		}
	}

}
