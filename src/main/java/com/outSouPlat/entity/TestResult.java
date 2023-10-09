package com.outSouPlat.entity;

public class TestResult {

	/**
	 * 待测试
	 */
	public static final int UN_TEST=1;
	/**
	 * 测试中
	 */
	public static final int TESTING=2;
	/**
	 * 不合格
	 */
	public static final int UN_PASS=3;
	/**
	 * 待支付佣金
	 */
	public static final int UN_PAY=4;
	/**
	 * 已支付佣金
	 */
	public static final int PAID=5;
	
	/**
	 * 待测试
	 */
	public static final String UN_TEST_NAME="待测试";
	/**
	 * 测试中
	 */
	public static final String TESTING_NAME="测试中";
	/**
	 * 不合格
	 */
	public static final String UN_PASS_NAME="不合格";
	/**
	 * 待支付佣金
	 */
	public static final String UN_PAY_NAME="待支付佣金";
	/**
	 * 已支付佣金
	 */
	public static final String PAID_NAME="已支付佣金";
	
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
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	private Integer orderId;
	private String orderNo;
	private String taskBagName;
	private Integer testUserId;
	private String testUserName;
	private String createTime;
	private String phone;
	private String desc;
	private Integer state;
}
