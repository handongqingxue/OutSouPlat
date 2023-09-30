package com.outSouPlat.entity;

public class UserCheckRec {

	private Integer id;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public Boolean getResult() {
		return result;
	}
	public void setResult(Boolean result) {
		this.result = result;
	}
	public Integer getCheckUserId() {
		return checkUserId;
	}
	public void setCheckUserId(Integer checkUserId) {
		this.checkUserId = checkUserId;
	}
	public String getCheckUserName() {
		return checkUserName;
	}
	public void setCheckUserName(String checkUserName) {
		this.checkUserName = checkUserName;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	private Integer userId;
	private String userName;
	private String createTime;//审核时间
	private Boolean result;//审核结果
	private Integer checkUserId;//审核人id
	private String checkUserName;//审核人账号
	private String memo;//备注
}
