package com.outSouPlat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.outSouPlat.entity.*;

public interface SysNoticeMapper {

	int add(SysNotice sysNotice);

	int queryForInt(@Param("title") String title,@Param("sendUserName") String sendUserName,@Param("receiveUserName") String receiveUserName,@Param("createTimeStart") String createTimeStart,@Param("createTimeEnd") String createTimeEnd,@Param("read") Boolean read, @Param("userId") Integer userId);

	List<SysNotice> queryList(@Param("title") String title,@Param("sendUserName") String sendUserName,@Param("receiveUserName") String receiveUserName,@Param("createTimeStart") String createTimeStart,@Param("createTimeEnd") String createTimeEnd,@Param("read") Boolean read, @Param("userId") Integer userId, @Param("rowNum") int rowNum, @Param("rows") int rows, @Param("sort") String sort, @Param("order") String order);
}
