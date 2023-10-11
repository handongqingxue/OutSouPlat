<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
.tab1_div .toolbar .mc_span{
	margin-left: 13px;
}
.tab1_div .toolbar .mc_inp{
	width: 120px;height: 25px;
}
.tab1_div .toolbar .search_but{
	margin-left: 13px;
}
.tab1_div .edit_a{
	visibility: hidden;
}
</style>
<title>Insert title here</title>
<%@include file="../../inc/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var sysManaPath=path+'sysMana/';

var xzZt;
var zcsyZt;
var fqZt;
var ywZt;

var xzZtMc;
var zcsyZtMc;
var fqZtMc;
var ywZtMc;
$(function(){
	initSearchLB();
	initAddLB();
	initTab1();
	
	//showCompontByQx();
});

function showCompontByQx(){
	addLB.hide();
	//removeLB.hide();
	if(username=="admin"){
		addLB.show();
		//removeLB.show();
	}
	else{
		var tjjsQx='${requestScope.tjjsQx}';
		var scjsQx='${requestScope.scjsQx}';
		var qxIdsArr=qxIds.split(",");
		for(var i=0;i<qxIdsArr.length;i++){
			if(qxIdsArr[i]==tjjsQx){
				addLB.show();
			}
			if(qxIdsArr[i]==scjsQx){
				//removeLB.show();
			}
		}
	}
}

function showOptionButByQx(){
	if(username=="admin"){
		$(".tab1_div .edit_a").css("visibility","visible");
	}
	else{
		var xgjsQx='${requestScope.xgjsQx}';
		var qxIdsArr=qxIds.split(",");
		for(var i=0;i<qxIdsArr.length;i++){
			if(qxIdsArr[i]==xgjsQx){
				$(".tab1_div .edit_a").css("visibility","visible");
			}
		}
	}
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
            	var str="<a class=\"edit_a\" href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;"
        			+"<a href=\"detail?id="+value+"\">详情</a>";
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
			
			//showOptionButByQx();
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
			<span class="mc_span">名称：</span>
			<input type="text" class="mc_inp" id="mc" placeholder="请输入名称"/>
			<a class="search_but" id="search_but">查询</a>
			<a id="add_but">添加</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>