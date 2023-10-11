<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<c:set var="userCheckPermStr" value=",${requestScope.userCheckPerm},"></c:set>
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
.tab1_div .toolbar .username_span{
	margin-left: 13px;
}
.tab1_div .toolbar .username_inp{
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
var permissionIdsStr='${permissionIdsStr}';
var userCheckPermStr='${userCheckPermStr}';

var defaultState=1;//'${requestScope.dshShzt}';

$(function(){
	showCompontByPermission();
	
	initSearchLB();
	initTab1();
});

function showCompontByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(userCheckPermStr)!=-1){
		initPassLB();
		initReturnLB();
	}
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var username=$("#toolbar #username").val();
			tab1.datagrid("load",{username:username,state:defaultState});
		}
	});
}

//初始化审核通过按钮
function initPassLB(){
	$("#pass_but").linkbutton({
		iconCls:"icon-ok",
		onClick:function(){
			checkByIds(true);
		}
	});
}

function initReturnLB(){
	$("#back_but").linkbutton({
		iconCls:"icon-back",
		onClick:function(){
			checkByIds(false);
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"系统管理-待审核用户-列表",
		url:sysManaPath+"queryUserList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		queryParams:{state:defaultState},
		columns:[[
			{field:"username",title:"用户名",width:150},
			{field:"phone",title:"手机号",width:150},
			{field:"qq",title:"qq号",width:150},
			{field:"weixin",title:"微信号",width:150},
			{field:"roleIdNames",title:"角色",width:150},
			{field:"createTime",title:"创建时间",width:150},
            {field:"id",title:"操作",width:50,formatter:function(value,row){
            	return "";
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{username:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"username",colspan:7});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
}

function checkByIds(result) {
	var tsStr;
	if(result)
		tsStr="审核";
	else
		tsStr="退回";
	
	var rows=tab1.datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("提示","请选择要"+tsStr+"的信息！","warning");
		return false;
	}
	
	$.messager.confirm("提示","确定要"+tsStr+"吗？",function(r){
		if(r){
			var ids = "";
			for (var i = 0; i < rows.length; i++) {
				ids += "," + rows[i].id;
			}
			ids=ids.substring(1);

			var checkUserId='${sessionScope.user.id}';
			$.ajaxSetup({async:false});
			$.post(sysManaPath + "checkUserByIds",
				{ids:ids,result:result,checkUserId:checkUserId},
				function(result){
					if(result.status==1){
						alert(result.msg);
						tab1.datagrid("load");
					}
					else{
						alert(result.msg);
					}
				}
			,"json");
			
		}
	});
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
			<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,userCheckPermStr)}">
			<a id="pass_but">审核通过</a>
			<a id="back_but">退回</a>
			</c:if>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>