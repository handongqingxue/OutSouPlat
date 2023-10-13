package com.outSouPlat.entity;

public class Project {
	
	/**
	 * 待承包
	 */
	public static final int UN_CONTRACT=1;
	/**
	 * 已承包
	 */
	public static final int CONTRACTED=2;
	/**
	 * 开发中
	 */
	public static final int DEVELOPING=3;
	/**
	 * 已完成
	 */
	public static final int FINISH=4;
	
	/**
	 * 待承包
	 */
	public static final String UN_CONTRACT_NAME="待承包";
	/**
	 * 已承包
	 */
	public static final String CONTRACTED_NAME="已承包";
	/**
	 * 开发中
	 */
	public static final String DEVELOPING_NAME="开发中";
	/**
	 * 已完成
	 */
	public static final String FINISH_NAME="已完成";
	
	/**
	 * 添加任务包
	 */
	public static final boolean ADD_TASK_BAG=true;
	/**
	 * 删除任务包
	 */
	public static final boolean DEL_TASK_BAG=false;

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
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getIllusUrl() {
		return illusUrl;
	}
	public void setIllusUrl(String illusUrl) {
		this.illusUrl = illusUrl;
	}
	public String getDeveLang() {
		return deveLang;
	}
	public void setDeveLang(String deveLang) {
		this.deveLang = deveLang;
	}
	public String getDatabase() {
		return database;
	}
	public void setDatabase(String database) {
		this.database = database;
	}
	public String getDeveTool() {
		return deveTool;
	}
	public void setDeveTool(String deveTool) {
		this.deveTool = deveTool;
	}
	public Integer getOutCount() {
		return outCount;
	}
	public void setOutCount(Integer outCount) {
		this.outCount = outCount;
	}
	public Integer getTaskBagCount() {
		return taskBagCount;
	}
	public void setTaskBagCount(Integer taskBagCount) {
		this.taskBagCount = taskBagCount;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	private String name;
	private String intro;
	private String illusUrl;
	private String deveLang;
	private String database;
	private String deveTool;
	private Integer outCount;
	private Integer taskBagCount;
	private String createTime;
	private Integer state;
}
