package com.outSouPlat.entity;

public class TaskOrder {
	
	/**
	 * 未完成
	 */
	public static final int UN_FINISH=1;
	/**
	 * 已完成
	 */
	public static final int FINISHED=2;
	/**
	 * 已废弃
	 */
	public static final int DISCARDED=3;
	
	/**
	 * 未完成
	 */
	public static final String UN_FINISH_NAME="未完成";
	/**
	 * 已完成
	 */
	public static final String FINISHED_NAME="已完成";
	/**
	 * 已废弃
	 */
	public static final String DISCARDED_NAME="已废弃";

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
