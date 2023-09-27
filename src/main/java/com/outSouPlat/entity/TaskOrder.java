package com.outSouPlat.entity;

public class TaskOrder {

	private Integer id;
	private String no;
	private Integer taskBagId;
	private String taskBagName;
	private Integer userId;
	private String userName;
	private String createTime;
	private String finishTime;
	private Long codeFileSize;
	private String codeFileUrl;
	private Integer state;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public Integer getTaskBagId() {
		return taskBagId;
	}
	public void setTaskBagId(Integer taskBagId) {
		this.taskBagId = taskBagId;
	}
	public String getTaskBagName() {
		return taskBagName;
	}
	public void setTaskBagName(String taskBagName) {
		this.taskBagName = taskBagName;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(String finishTime) {
		this.finishTime = finishTime;
	}
	public Long getCodeFileSize() {
		return codeFileSize;
	}
	public void setCodeFileSize(Long codeFileSize) {
		this.codeFileSize = codeFileSize;
	}
	public String getCodeFileUrl() {
		return codeFileUrl;
	}
	public void setCodeFileUrl(String codeFileUrl) {
		this.codeFileUrl = codeFileUrl;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
}
