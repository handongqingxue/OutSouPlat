package com.outSouPlat.entity;

public class User {
	
	/**
	 * 待审核
	 */
	public static final int NO_CHECK=1;
	/**
	 * 审核通过
	 */
	public static final int CHECKED=2;
	/**
	 * 编辑中
	 */
	public static final int EDITING=3;

	/**
	 * 待审核
	 */
	public static final String NO_CHECK_NAME="待审核";
	/**
	 * 审核通过
	 */
	public static final String CHECKED_NAME="审核通过";
	/**
	 * 编辑中
	 */
	public static final String EDITING_NAME="编辑中";

	private Integer id;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWeixin() {
		return weixin;
	}
	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getDeveLang() {
		return deveLang;
	}
	public void setDeveLang(String deveLang) {
		this.deveLang = deveLang;
	}
	public String getProExp() {
		return proExp;
	}
	public void setProExp(String proExp) {
		this.proExp = proExp;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getRoleIds() {
		return roleIds;
	}
	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}
	public String getRoleNames() {
		return roleNames;
	}
	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}
	public String getPermissionIds() {
		return permissionIds;
	}
	public void setPermissionIds(String permissionIds) {
		this.permissionIds = permissionIds;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	private String username;
	private String password;
	private String phone;
	private String qq;
	private String weixin;
	private String education;//学历
	private String deveLang;//擅长的开发语言
	private String proExp;//项目经历
	private String createTime;
	private String roleIds;
	private String roleNames;
	private String permissionIds;
	private Integer state;//1.待审核 2.审核通过 3.编辑中
}
