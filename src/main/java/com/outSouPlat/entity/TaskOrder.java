package com.outSouPlat.entity;

public class TaskOrder {
	
	/**
	 * 开发中
	 */
	public static final int DEVELOPING=1;
	/**
	 * 待测试
	 */
	public static final int UN_TEST=2;
	/**
	 * 测试中
	 */
	public static final int TESTING=3;
	/**
	 * 不合格
	 */
	public static final int UN_PASS=4;
	/**
	 * 待支付佣金
	 */
	public static final int UN_PAY=5;
	/**
	 * 已支付佣金
	 */
	public static final int PAID=6;
	/**
	 * 已完成
	 */
	public static final int FINISHED=7;
	/**
	 * 已废弃
	 */
	public static final int DISCARDED=8;
	
	/**
	 * 开发中
	 */
	public static final String DEVELOPING_NAME="开发中";
	/**
	 * 已完成
	 */
	public static final String FINISHED_NAME="已完成";
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
	/**
	 * 已废弃
	 */
	public static final String DISCARDED_NAME="已废弃";

	private Integer id;
	private String no;
	private Integer taskBagId;
	private String taskBagName;
	private String uploadUserName;
	private Integer agreeUserId;
	private String agreeUserName;
	private Integer orderUserId;
	private String orderUserName;
	private String createTime;
	private String finishTime;
	private Long annexFileSize;
	private String annexFileUrl;
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
	public String getUploadUserName() {
		return uploadUserName;
	}
	public void setUploadUserName(String uploadUserName) {
		this.uploadUserName = uploadUserName;
	}
	public Integer getAgreeUserId() {
		return agreeUserId;
	}
	public void setAgreeUserId(Integer agreeUserId) {
		this.agreeUserId = agreeUserId;
	}
	public String getAgreeUserName() {
		return agreeUserName;
	}
	public void setAgreeUserName(String agreeUserName) {
		this.agreeUserName = agreeUserName;
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
	public Long getAnnexFileSize() {
		return annexFileSize;
	}
	public void setAnnexFileSize(Long annexFileSize) {
		this.annexFileSize = annexFileSize;
	}
	public String getAnnexFileUrl() {
		return annexFileUrl;
	}
	public void setAnnexFileUrl(String annexFileUrl) {
		this.annexFileUrl = annexFileUrl;
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
