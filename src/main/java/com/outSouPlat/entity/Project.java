package com.outSouPlat.entity;

public class Project {

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
	private String deveLang;
	private String database;
	private String deveTool;
	private Integer outCount;
	private Integer taskBagCount;
	private String createTime;
	private Integer state;
}
