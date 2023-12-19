package com.outSouPlat.entity;

public class SysNotice {

	public static final boolean READ=true;
	public static final boolean UN_READ=false;

	public static final String READ_NAME="已读";
	public static final String UN_READ_NAME="未读";
	
	private Integer id;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSendUserId() {
		return sendUserId;
	}
	public void setSendUserId(Integer sendUserId) {
		this.sendUserId = sendUserId;
	}
	public String getSendUserName() {
		return sendUserName;
	}
	public void setSendUserName(String sendUserName) {
		this.sendUserName = sendUserName;
	}
	public Integer getReceiveUserId() {
		return receiveUserId;
	}
	public void setReceiveUserId(Integer receiveUserId) {
		this.receiveUserId = receiveUserId;
	}
	public String getReceiveUserName() {
		return receiveUserName;
	}
	public void setReceiveUserName(String receiveUserName) {
		this.receiveUserName = receiveUserName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContentSubStr() {
		return contentSubStr;
	}
	public void setContentSubStr(String contentSubStr) {
		this.contentSubStr = contentSubStr;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Boolean getRead() {
		return read;
	}
	public void setRead(Boolean read) {
		this.read = read;
	}
	private Integer sendUserId;
	private String sendUserName;
	private Integer receiveUserId;
	private String receiveUserName;
	private String title;
	private String content;
	private String contentSubStr;
	private String createTime;
	private Boolean read;
}
