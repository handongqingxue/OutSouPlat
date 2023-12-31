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
	 * 返工中
	 */
	public static final int REWORKING=4;
	/**
	 * 已完成
	 */
	public static final int FINISHED=5;
	
	/**
	 * 开发中
	 */
	public static final String DEVELOPING_NAME="开发中";
	/**
	 * 待测试
	 */
	public static final String UN_TEST_NAME="待测试";
	/**
	 * 测试中
	 */
	public static final String TESTING_NAME="测试中";
	/**
	 * 返工中
	 */
	public static final String REWORKING_NAME="返工中";
	/**
	 * 已完成
	 */
	public static final String FINISHED_NAME="已完成";

	private Integer id;
	private String no;
	private Integer taskBagId;
	private String taskBagName;
	private Integer projectId;
	private String projectName;
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
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
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
