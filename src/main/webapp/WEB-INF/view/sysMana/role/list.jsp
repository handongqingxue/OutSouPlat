<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
.tab1_div .toolbar .name_span{
	margin-left: 13px;
}
.tab1_div .toolbar .name_inp{
	width: 120px;height: 25px;
}
.tab1_div .toolbar .search_but{
	margin-left: 13px;
}
</style>
<title>Insert title here</title>
<script type="text/javascript">
var path='<%=basePath %>';
var sysManaPath=path+'sysMana/';

var sessionUsernameStr='${sessionUsernameStr}';
var usernameStr='${usernameStr}';

var showEditOptionBut=false;

$(function(){
	showCompontByPermission();
	showOptionByPermission();
	
	initSearchLB();
	initTab1();
	
});

function showCompontByPermission(){
	if(sessionUsernameStr==usernameStr)
		initAddLB();
}

function showOptionByPermission(){
	if(sessionUsernameStr==usernameStr)
		showEditOptionBut=true;
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var name=$("#toolbar #name").val();
			tab1.datagrid("load",{name:name});
		}
	});
}

function initAddLB(){
	addLB=$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=sysManaPath+"role/new";
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"系统管理-角色查询-列表",
		url:sysManaPath+"queryRoleList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"名称",width:150},
			{field:"describe",title:"描述",width:300},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	var str="";
	            	if(showEditOptionBut)
		            	str+="<a href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;";
	            	str+="<a href=\"detail?id="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{name:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"name",colspan:3});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-250;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../inc/side.jsp"%>
	<div class="tab1_div" id="tab1_div">
		<div class="toolbar" id="toolbar">
			<span class="name_span">名称：</span>
			<input type="text" class="name_inp" id="name" placeholder="请输入名称"/>
			<a class="search_but" id="search_but">查询</a>
			<c:if test="${sessionUsernameStr eq usernameStr}">
			<a id="add_but">添加</a>
			</c:if>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>