package com.outSouPlat.service;

import java.util.List;

import com.outSouPlat.entity.*;

public interface SysNoticeService {

	int queryForInt(String title);

	List<SysNotice> queryList(String title, int page, int rows, String sort, String order);
}
