package com.outSouPlat.entity;

public class TestResult {

	/**
	 * 合格
	 */
	public static final boolean PASS=true;
	/**
	 * 不合格
	 */
	public static final boolean UN_PASS=false;
	
	/**
	 * 合格
	 */
	public static final String PASS_NAME="合格";
	/**
	 * 不合格
	 */
	public static final String UN_PASS_NAME="不合格";
	
	private Integer id;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getTaskBagName() {
		return taskBagName;
	}
	public void setTaskBagName(String taskBagName) {
		this.taskBagName = taskBagName;
	}
	public String getUploadUserName() {
		return uploadUserName;
	}
	public void setUploadUserName(String uploadUserName) {
		this.uploadUserName = uploadUserName;
	}
	public Integer getOrderUserId() {
		return orderUserId;
	}
	public void setOrderUserId(Integer orderUserId) {
		this.orderUserId = orderUserId;
	}
	public String getOrderUserName() {
		return orderUserName;
	}
	public void setOrderUserName(String orderUserName) {
		this.orderUserName = orderUserName;
	}
	public String getAgreeUserName() {
		return agreeUserName;
	}
	public void setAgreeUserName(String agreeUserName) {
		this.agreeUserName = agreeUserName;
	}
	public Integer getTestUserId() {
		return testUserId;
	}
	public void setTestUserId(Integer testUserId) {
		this.testUserId = testUserId;
	}
	public String getTestUserName() {
		return testUserName;
	}
	public void setTestUserName(String testUserName) {
		this.testUserName = testUserName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public Boolean getResult() {
		return result;
	}
	public void setResult(Boolean result) {
		this.result = result;
	}
	private Integer orderId;
	private String orderNo;
	private String taskBagName;
	private String uploadUserName;
	private Integer orderUserId;
	private String orderUserName;
	private String agreeUserName;
	private Integer testUserId;
	private String testUserName;
	private String createTime;
	private String phone;
	private String desc;
	private Boolean result;
}
