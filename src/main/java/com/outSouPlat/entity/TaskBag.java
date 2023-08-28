package com.outSouPlat.entity;

public class TaskBag {

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
	public Float getCodeFileSize() {
		return codeFileSize;
	}
	public void setCodeFileSize(Float codeFileSize) {
		this.codeFileSize = codeFileSize;
	}
	public String getCodeFileUrl() {
		return codeFileUrl;
	}
	public void setCodeFileUrl(String codeFileUrl) {
		this.codeFileUrl = codeFileUrl;
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
	public Integer getDownloadCount() {
		return downloadCount;
	}
	public void setDownloadCount(Integer downloadCount) {
		this.downloadCount = downloadCount;
	}
	public Float getMakeTime() {
		return makeTime;
	}
	public void setMakeTime(Float makeTime) {
		this.makeTime = makeTime;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	private String name;
	private Float commission;
	private Float codeFileSize;
	private String codeFileUrl;
	private String createTime;
	private Integer uploadUserId;
	private Integer downloadCount;
	private Float makeTime;
	private String describe;
	private Integer state;
	private Integer projectId;
}
