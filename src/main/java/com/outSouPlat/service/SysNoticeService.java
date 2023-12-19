package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface SysNoticeService {

	int queryForInt(String title,String sendUserName,String receiveUserName,String createTimeStart,String createTimeEnd,Boolean read, Integer userId);

	List<SysNotice> queryList(String title,String sendUserName,String receiveUserName,String createTimeStart,String createTimeEnd,Boolean read, Integer userId, int page, int rows, String sort, String order);
}
