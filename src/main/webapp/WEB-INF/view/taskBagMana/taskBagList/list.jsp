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
.tab1_div .toolbar .row_div .name_span,
.tab1_div .toolbar .row_div .state_span,
.tab1_div .toolbar .row_div .projectName_span,
.tab1_div .toolbar .row_div .uploadUserName_span,
.tab1_div .toolbar .row_div .createTime_span,
.tab1_div .toolbar .row_div .search_but{
	margin-left: 13px;
}
.tab1_div .toolbar .row_div .name_inp,
.tab1_div .toolbar .row_div .projectName_inp,
.tab1_div .toolbar .row_div .uploadUserName_inp{
	width: 120px;
	height: 25px;
}
</style>
<%@include file="../../inc/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var taskBagManaPath=path+'taskBagMana/';
$(function(){
	initCreateTimeStartDTB();
	initCreateTimeEndDTB();
	initStateCBB();
	initSearchLB();
	initAddLB();
	initRemoveLB();
	initTab1();
});

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
	data.push({"value":"1","text":"未发布"});
	data.push({"value":"2","text":"未接单"});
	data.push({"value":"3","text":"开发中"});
	data.push({"value":"4","text":"测试中"});
	data.push({"value":"5","text":"已完成"});
	
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
			var projectName=$("#toolbar #projectName").val();
			var uploadUserName=$("#toolbar #uploadUserName").val();
			var deveTool=$("#toolbar #deveTool").val();
			var createTimeStart=createTimeStartDTB.datetimebox("getValue");
			var createTimeEnd=createTimeEndDTB.datetimebox("getValue");
			var state=stateCBB.combobox("getValue");
			
			tab1.datagrid("load",{name:name,projectName:projectName,uploadUserName:uploadUserName,deveTool:deveTool,
				createTimeStart:createTimeStart,createTimeEnd:createTimeEnd,state:state});
		}
	});
}

function initAddLB(){
	addLB=$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=taskBagManaPath+"projList/new";
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
		title:"任务包列表",
		url:taskBagManaPath+"queryList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"项目名称",width:150},
			{field:"projectName",title:"项目",width:150},
			{field:"database",title:"佣金",width:150},
			{field:"uploadUserName",title:"上传者",width:150},
			{field:"createTime",title:"发布时间",width:150},
            {field:"state",title:"状态",width:100,formatter:function(value,row){
            	var stateName;
            	switch (value) {
				case 1:
					stateName="未发布";
					break;
				case 2:
					stateName="未接单";
					break;
				case 3:
					stateName="开发中";
					break;
				case 4:
					stateName="测试中";
					break;
				case 5:
					stateName="已完成";
					break;
				}
            	return stateName;
            }},
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str="<a href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;"
	            	   +"<a href=\"detail?id="+value+"\">详情</a>&nbsp;&nbsp;";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{name:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"name",colspan:7});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
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
				<span class="projectName_span">项目：</span>
				<input type="text" class="projectName_inp" id="projectName" placeholder="请输入项目"/>
				<span class="uploadUserName_span">上传者：</span>
				<input type="text" class="uploadUserName_inp" id="uploadUserName" placeholder="请输入上传者"/>
			</div>
			<div class="row_div">
				<span class="createTime_span">发布时间：</span>
				<input id="createTimeStart_dtb"/>-
				<input id="createTimeEnd_dtb"/>
				<span class="state_span">状态：</span>
				<input id="state_cbb"/>
				<a class="search_but" id="search_but">查询</a>
				<a id="add_but">添加</a>
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