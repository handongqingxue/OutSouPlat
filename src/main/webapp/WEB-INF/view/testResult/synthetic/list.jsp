<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
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
.tab1_div .toolbar .row_div .no_span,
.tab1_div .toolbar .row_div .state_span,
.tab1_div .toolbar .row_div .taskBagName_span,
.tab1_div .toolbar .row_div .testUserName_span,
.tab1_div .toolbar .row_div .createTime_span,
.tab1_div .toolbar .row_div .finishTime_span,
.tab1_div .toolbar .row_div .search_but{
	margin-left: 13px;
}
.tab1_div .toolbar .row_div .no_inp,
.tab1_div .toolbar .row_div .taskBagName_inp,
.tab1_div .toolbar .row_div .testUserName_inp{
	width: 120px;
	height: 25px;
}
</style>
<%@include file="../../inc/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var taskBagManaPath=path+'taskBagMana/';

var unFinishState;
var finishedState;
var discardedState;

var unFinishStateName;
var finishedStateName;
var discardedStateName;
$(function(){
	initStateVar();
	initCreateTimeStartDTB();
	initCreateTimeEndDTB();
	initFinishTimeStartDTB();
	initFinishTimeEndDTB();
	initStateCBB();
	initSearchLB();
	initRemoveLB();
	initTab1();
});

function initStateVar(){
	unFinishState=parseInt('${requestScope.unFinishState}');
	finishedState=parseInt('${requestScope.finishedState}');
	discardedState=parseInt('${requestScope.discardedState}');

	unFinishStateName='${requestScope.unFinishStateName}';
	finishedStateName='${requestScope.finishedStateName}';
	discardedStateName='${requestScope.discardedStateName}';
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

function initFinishTimeStartDTB(){
	finishTimeStartDTB=$("#finishTimeStart_dtb").datetimebox({
        required:false
    });
}

function initFinishTimeEndDTB(){
	finishTimeEndDTB=$("#finishTimeEnd_dtb").datetimebox({
        required:false
    });
}

function initStateCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":unFinishState,"text":unFinishStateName});
	data.push({"value":finishedState,"text":finishedStateName});
	data.push({"value":discardedState,"text":discardedStateName});
	
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
			var no=$("#toolbar #no").val();
			var taskBagName=$("#toolbar #taskBagName").val();
			var userName=$("#toolbar #userName").val();
			var createTimeStart=createTimeStartDTB.datetimebox("getValue");
			var createTimeEnd=createTimeEndDTB.datetimebox("getValue");
			var finishTimeStart=finishTimeStartDTB.datetimebox("getValue");
			var finishTimeEnd=finishTimeEndDTB.datetimebox("getValue");
			var state=stateCBB.combobox("getValue");
			
			tab1.datagrid("load",{no:no,taskBagName:taskBagName,userName:userName,createTimeStart:createTimeStart,
				createTimeEnd:createTimeEnd,finishTimeStart:finishTimeStart,finishTimeEnd:finishTimeEnd,state:state});
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
		title:"测试结果查询",
		url:taskBagManaPath+"queryTaskOrderList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"no",title:"任务单号",width:150},
			{field:"taskBagName",title:"任务包",width:150},
			{field:"testUserName",title:"测试人",width:150},
			{field:"createTime",title:"测试时间",width:150},
            {field:"state",title:"状态",width:100,formatter:function(value,row){
            	return getStateNameById(value);
            }},
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str="<a href=\"detail?id="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{no:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"no",colspan:6});
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
	case unFinishState:
		str=unFinishStateName;//未完成
		break;
	case finishedState:
		str=finishedStateName;//已完成
		break;
	case discardedState:
		str=discardedStateName;//已废弃
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
				<span class="no_span">任务单号：</span>
				<input type="text" class="no_inp" id="no" placeholder="请输入任务单号"/>
				<span class="taskBagName_span">任务包：</span>
				<input type="text" class="taskBagName_inp" id="taskBagName" placeholder="请输入任务包名"/>
				<span class="testUserName_span">测试人：</span>
				<input type="text" class="testUserName_inp" id="testUserName" placeholder="请输入测试人"/>
				<span class="createTime_span">测试时间：</span>
				<input id="createTimeStart_dtb"/>-
				<input id="createTimeEnd_dtb"/>
			</div>
			<div class="row_div">
				<span class="finishTime_span">完成时间：</span>
				<input id="finishTimeStart_dtb"/>-
				<input id="finishTimeEnd_dtb"/>
				<span class="state_span">状态：</span>
				<input id="state_cbb"/>
				<a class="search_but" id="search_but">查询</a>
				<a id="remove_but">删除</a>
			</div>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>