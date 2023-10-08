<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.tab1_div{
	margin-top:80px;
	margin-left: 220px;
	position: fixed;
}
.tab1_div .toolbar{
	height:32px;
}
.tab1_div .toolbar .username_span{
	margin-left: 13px;
}
.tab1_div .toolbar .username_inp{
	width: 120px;height: 25px;
}
.tab1_div .toolbar .search_but{
	margin-left: 13px;
}
.tab1_div .edit_a{
	/*
	visibility: hidden;
	*/
}
</style>
<title>Insert title here</title>
<%@include file="../../inc/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var sysManaPath=path+'sysMana/';

var noCheckState;
var checkedState;
var editingState;

var noCheckStateName;
var checkedStateName;
var editingStateName;
$(function(){
	initStateVar();
	initSearchLB();
	initTab1();
});

function initStateVar(){
	noCheckState=parseInt('${requestScope.noCheckState}');
	checkedState=parseInt('${requestScope.checkedState}');
	editingState=parseInt('${requestScope.editingState}');

	noCheckStateName='${requestScope.noCheckStateName}';
	checkedStateName='${requestScope.checkedStateName}';
	editingStateName='${requestScope.editingStateName}';
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var username=$("#toolbar #username").val();
			tab1.datagrid("load",{username:username});
		}
	});
}

function initOutputBut(){
	opBut=$("#output_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			openOutputExcelDialog(true);
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"系统管理-用户查询-列表",
		url:sysManaPath+"queryUserList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"username",title:"用户名",width:150},
			{field:"phone",title:"手机号",width:150},
			{field:"qq",title:"qq号",width:150},
			{field:"weixin",title:"微信号",width:150},
			{field:"roleNames",title:"角色",width:150},
			{field:"createTime",title:"创建时间",width:150},
			{field:"state",title:"审核状态",width:100,formatter:function(value,row){
				return getStateNameById(value);
			}},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	var str="<a class=\"edit_a\" href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;"
            		+"<a href=\"detail?id="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{username:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"username",colspan:8});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
}

function getStateNameById(stateId){
	var str;
	switch (stateId) {
	case noCheckState:
		str=noCheckStateName;//待审核
		break;
	case checkedState:
		str=checkedStateName;//审核通过
		break;
	case editingState:
		str=editingStateName;//编辑中
		break;
	}
	return str;
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "tab1_div":
		space=250;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../inc/side.jsp"%>
	<div class="tab1_div" id="tab1_div">
		<div class="toolbar" id="toolbar">
			<span class="username_span">用户名：</span>
			<input type="text" class="username_inp" id="username" placeholder="请输入用户名"/>
			<a class="search_but" id="search_but">查询</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>