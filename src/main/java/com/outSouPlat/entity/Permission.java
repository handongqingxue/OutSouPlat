package com.outSouPlat.entity;

public class Permission {
	
	/**
	 * 项目添加
	 */
	public static final int PROJ_ADD=1;
	/**
	 * 项目删除
	 */
	public static final int PROJ_DEL=2;
	/**
	 * 项目编辑
	 */
	public static final int PROJ_EDIT=3;
	/**
	 * 项目查询
	 */
	public static final int PROJ_SEAR=4;
	/**
	 * 任务包添加
	 */
	public static final int TASK_BAG_ADD=5;
	/**
	 * 任务包删除
	 */
	public static final int TASK_BAG_DEL=6;
	/**
	 * 任务包编辑
	 */
	public static final int TASK_BAG_EDIT=7;
	/**
	 * 任务包查询
	 */
	public static final int TASK_BAG_SEAR=8;
	/**
	 * 任务单添加
	 */
	public static final int TASK_ORDER_ADD=9;
	/**
	 * 任务单删除
	 */
	public static final int TASK_ORDER_DEL=10;
	/**
	 * 任务单编辑
	 */
	public static final int TASK_ORDER_EDIT=11;
	/**
	 * 任务单查询
	 */
	public static final int TASK_ORDER_SEAR=12;
	/**
	 * 测试结果添加
	 */
	public static final int TEST_RESULT_ADD=13;
	/**
	 * 测试结果删除
	 */
	public static final int TEST_RESULT_DEL=14;
	/**
	 * 测试结果编辑
	 */
	public static final int TEST_RESULT_EDIT=15;
	/**
	 * 测试结果查询
	 */
	public static final int TEST_RESULT_SEAR=16;
	/**
	 * 用户查询
	 */
	public static final int USER_SEAR=17;
	/**
	 * 用户编辑
	 */
	public static final int USER_EDIT=18;
	/**
	 * 用户审核
	 */
	public static final int USER_CHECK=19;
	/**
	 * 待审核用户查询
	 */
	public static final int UN_CHECK_USER_SEAR=20;

	private Integer id;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	private String name;
	private Integer sort;
	private String describe;
}
