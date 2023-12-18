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
.tab1_div .toolbar .title_span{
	margin-left: 13px;
}
.tab1_div .toolbar .title_inp{
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

$(function(){
	initSearchLB();
	initTab1();
});

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var title=$("#toolbar #title").val();
			tab1.datagrid("load",{title:title});
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"系统管理-通知查询-列表",
		url:sysManaPath+"querySysNoticeList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"title",title:"标题",width:150},
			{field:"content",title:"内容",width:300},
			{field:"sendUserName",title:"发送人",width:150},
			{field:"receiveUserName",title:"接收人",width:150},
			{field:"createTime",title:"创建时间",width:150},
			{field:"read",title:"是否已读",width:100,formatter:function(value,row){
				return value?"已读":"未读";
			}},
            {field:"id",title:"操作",width:110,formatter:function(value,row){
            	var str="";
	            	str+="<a href=\"detail?id="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{title:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"title",colspan:7});
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
			<span class="title_span">标题：</span>
			<input type="text" class="title_inp" id="title" placeholder="请输入标题"/>
			<a class="search_but" id="search_but">查询</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>