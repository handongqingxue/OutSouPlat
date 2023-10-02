package com.outSouPlat.entity;

public class Role {

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
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getPermissionIds() {
		return permissionIds;
	}
	public void setPermissionIds(String permissionIds) {
		this.permissionIds = permissionIds;
	}
	public String getPermissionNames() {
		return permissionNames;
	}
	public void setPermissionNames(String permissionNames) {
		this.permissionNames = permissionNames;
	}
	private String name;
	private String describe;
	private String permissionIds;
	private String permissionNames;
}
