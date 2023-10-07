package com.outSouPlat.entity;

public class TaskBag {
	
	/**
	 * 未发布
	 */
	public static final int UN_SUBMIT=1;
	/**
	 * 未接单
	 */
	public static final int UN_ORDER=2;
	/**
	 * 开发中
	 */
	public static final int DEVELOPING=3;
	/**
	 * 测试中
	 */
	public static final int TESTING=4;
	/**
	 * 已完成
	 */
	public static final int FINISH=5;
	
	/**
	 * 未发布
	 */
	public static final String UN_SUBMIT_NAME="未发布";
	/**
	 * 未接单
	 */
	public static final String UN_ORDER_NAME="未接单";
	/**
	 * 开发中
	 */
	public static final String DEVELOPING_NAME="开发中";
	/**
	 * 测试中
	 */
	public static final String TESTING_NAME="测试中";
	/**
	 * 已完成
	 */
	public static final String FINISH_NAME="已完成";

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
	public Float getCommission() {
		return commission;
	}
	public void setCommission(Float commission) {
		this.commission = commission;
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
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getUploadUserId() {
		return uploadUserId;
	}
	public void setUploadUserId(Integer uploadUserId) {
		this.uploadUserId = uploadUserId;
	}
	public String getUploadUserName() {
		return uploadUserName;
	}
	public void setUploadUserName(String uploadUserName) {
		this.uploadUserName = uploadUserName;
	}
	public Integer getDownloadCount() {
		return downloadCount;
	}
	public void setDownloadCount(Integer downloadCount) {
		this.downloadCount = downloadCount;
	}
	public String getMakeTime() {
		return makeTime;
	}
	public void setMakeTime(String makeTime) {
		this.makeTime = makeTime;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
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
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	private String name;
	private Float commission;
	private Long annexFileSize;
	private String annexFileUrl;
	private String createTime;
	private Integer uploadUserId;
	private String uploadUserName;
	private Integer downloadCount;
	private String makeTime;
	private String describe;
	private Integer projectId;
	private String projectName;
	private Integer state;
}
