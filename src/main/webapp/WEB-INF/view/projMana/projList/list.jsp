<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<c:set var="projAddPermStr" value=",${requestScope.projAddPerm},"></c:set>
<c:set var="projDelPermStr" value=",${requestScope.projDelPerm},"></c:set>
<c:set var="projEditPermStr" value=",${requestScope.projEditPerm},"></c:set>
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
	height:64px;
}
.tab1_div .toolbar .row_div{
	height:32px;
}
.tab1_div .toolbar .row_div .name_span,
.tab1_div .toolbar .row_div .state_span,
.tab1_div .toolbar .row_div .deveLang_span,
.tab1_div .toolbar .row_div .database_span,
.tab1_div .toolbar .row_div .deveTool_span,
.tab1_div .toolbar .row_div .createTime_span,
.tab1_div .toolbar .row_div .search_but{
	margin-left: 13px;
}
.tab1_div .toolbar .row_div .name_inp,
.tab1_div .toolbar .row_div .deveLang_inp,
.tab1_div .toolbar .row_div .database_inp,
.tab1_div .toolbar .row_div .deveTool_inp{
	width: 120px;
	height: 25px;
}
</style>
<title>Insert title here</title>
<script type="text/javascript">
var path='<%=basePath %>';
var projManaPath=path+'projMana/';

var sessionUsernameStr='${sessionUsernameStr}';
var usernameStr='${usernameStr}';
var permissionIdsStr='${permissionIdsStr}';
var projAddPermStr='${projAddPermStr}';
var projDelPermStr='${projDelPermStr}';
var projEditPermStr='${projEditPermStr}';

var showEditOptionBut=false;

var unContractState;
var contractedState;
var developingState;
var finishState;

var unContractStateName;
var contractedStateName;
var developingStateName;
var finishStateName;
$(function(){
	initStateVar();
	showCompontByPermission();
	showOptionByPermission();
	
	initCreateTimeStartDTB();
	initCreateTimeEndDTB();
	initStateCBB();
	initSearchLB();
	initTab1();
});

function showCompontByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(projAddPermStr)!=-1)
		initAddLB();
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(projDelPermStr)!=-1)
		initRemoveLB();
}

function showOptionByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(projEditPermStr)!=-1)
		showEditOptionBut=true;
}

function initStateVar(){
	unContractState=parseInt('${requestScope.unContractState}');
	contractedState=parseInt('${requestScope.contractedState}');
	developingState=parseInt('${requestScope.developingState}');
	finishState=parseInt('${requestScope.finishState}');

	unContractStateName='${requestScope.unContractStateName}';
	contractedStateName='${requestScope.contractedStateName}';
	developingStateName='${requestScope.developingStateName}';
	finishStateName='${requestScope.finishStateName}';
}

function initCreateTimeStartDTB(){
	createTimeStartDTB=$("#createTimeStart_dtb").datetimebox({
        required:false
    });
}

function initCreateTimeEndDTB(){
	createTimeEndDTB=$("#createTimeEnd_dtb").datetimebox({
        required:false
    });
}

function initStateCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":unContractState,"text":unContractStateName});
	data.push({"value":contractedState,"text":contractedStateName});
	data.push({"value":developingState,"text":developingStateName});
	data.push({"value":finishState,"text":finishStateName});
	
	stateCBB=$("#state_cbb").combobox({
		valueField:"value",
		textField:"text",
		//multiple:true,
		data:data
	});
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var name=$("#toolbar #name").val();
			var deveLang=$("#toolbar #deveLang").val();
			var database=$("#toolbar #database").val();
			var deveTool=$("#toolbar #deveTool").val();
			var createTimeStart=createTimeStartDTB.datetimebox("getValue");
			var createTimeEnd=createTimeEndDTB.datetimebox("getValue");
			var state=stateCBB.combobox("getValue");
			
			tab1.datagrid("load",{name:name,deveLang:deveLang,database:database,deveTool:deveTool,
				createTimeStart:createTimeStart,createTimeEnd:createTimeEnd,state:state});
		}
	});
}

function initAddLB(){
	addLB=$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=projManaPath+"projList/new";
		}
	});
}

function initRemoveLB(){
	removeLB=$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			deleteByIds();
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"项目列表",
		url:projManaPath+"queryList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"项目名称",width:150},
			{field:"deveLang",title:"开发语言",width:150},
			{field:"database",title:"数据库",width:150},
			{field:"deveTool",title:"开发工具",width:150},
			{field:"outCount",title:"外包人数",width:100},
			{field:"taskBagCount",title:"任务包数量",width:150},
			{field:"createTime",title:"发布时间",width:150},
            {field:"state",title:"状态",width:100,formatter:function(value,row){
            	return getStateNameById(value);
            }},
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str="";
	            	if(showEditOptionBut)
	            		str+="<a href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;"
            		str+="<a href=\"detail?id="+value+"\">详情</a>&nbsp;&nbsp;";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{name:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"name",colspan:9});
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
	case unContractState:
		str=unContractStateName;//待承包
		break;
	case contractedState:
		str=contractedStateName;//已承包
		break;
	case developingState:
		str=developingStateName;//开发中
		break;
	case finishState:
		str=finishStateName;//已完成
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
	case "panel_window":
		space=355;
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
			<div class="row_div">
				<span class="name_span">项目名称：</span>
				<input type="text" class="name_inp" id="name" placeholder="请输入项目名称"/>
				<span class="deveLang_span">开发语言：</span>
				<input type="text" class="deveLang_inp" id="deveLang" placeholder="请输入开发语言"/>
				<span class="database_span">数据库：</span>
				<input type="text" class="database_inp" id="database" placeholder="请输入数据库"/>
				<span class="deveTool_span">开发工具：</span>
				<input type="text" class="deveTool_inp" id="deveTool" placeholder="请输入开发工具"/>
			</div>
			<div class="row_div">
				<span class="createTime_span">发布时间：</span>
				<input id="createTimeStart_dtb"/>-
				<input id="createTimeEnd_dtb"/>
				<span class="state_span">状态：</span>
				<input id="state_cbb"/>
				<a class="search_but" id="search_but">查询</a>
				<c:if test="${sessionScope.user.username eq usernameStr||fn:contains(permissionIdsStr,projAddPermStr)}">
				<a id="add_but">添加</a>
				</c:if>
				<c:if test="${sessionScope.user.username eq usernameStr||fn:contains(permissionIdsStr,projDelPermStr)}">
				<a id="remove_but">删除</a>
				</c:if>
			</div>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>