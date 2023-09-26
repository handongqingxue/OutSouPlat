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
	private Long codeFileSize;
	private String codeFileUrl;
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
