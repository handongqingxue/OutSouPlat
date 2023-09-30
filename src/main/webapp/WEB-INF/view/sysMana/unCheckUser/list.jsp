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
.tab1_div .toolbar .yhm_span{
	margin-left: 13px;
}
.tab1_div .toolbar .yhm_inp{
	width: 120px;height: 25px;
}
.tab1_div .toolbar .search_but{
	margin-left: 13px;
}

.output_excel_bg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,.45);
	position: fixed;
	z-index: 9016;
	display:none;
}

.output_excel_div{
	width: 500px;
	height: 210px;
	margin: 250px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}
</style>
<title>Insert title here</title>
<%@include file="../../inc/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var sysManaPath=path+'sysMana/';

var defaultState=1;//'${requestScope.dshShzt}';

$(function(){
	initSearchLB();
	initSHTGLB();
	initTuiHuiLB();
	initTab1();
});

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var yhm=$("#toolbar #yhm").val();
			tab1.datagrid("load",{yhm:yhm,shzt:defaultState});
		}
	});
}

//初始化审核通过按钮
function initSHTGLB(){
	$("#shtg_but").linkbutton({
		iconCls:"icon-ok",
		onClick:function(){
			checkByIds(true);
		}
	});
}

function initTuiHuiLB(){
	$("#tuiHui_but").linkbutton({
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
			<span class="yhm_span">用户名：</span>
			<input type="text" class="yhm_inp" id="yhm" placeholder="请输入用户名"/>
			<a class="search_but" id="search_but">查询</a>
			<a id="shtg_but">审核通过</a>
			<a id="tuiHui_but">退回</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>