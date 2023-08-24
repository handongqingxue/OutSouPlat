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
	height:64px;
}
.tab1_div .toolbar .row_div{
	height:32px;
}
.tab1_div .toolbar .row_div .name_span,
.tab1_div .toolbar .row_div .ddzt_span,
.tab1_div .toolbar .row_div .cph_span,
.tab1_div .toolbar .row_div .yss_span,
.tab1_div .toolbar .row_div .wzMc_span,
.tab1_div .toolbar .row_div .fhdw_span,
.tab1_div .toolbar .row_div .shbm_span,
.tab1_div .toolbar .row_div .sjxm_span,
.tab1_div .toolbar .row_div .sjsfzh_span,
.tab1_div .toolbar .row_div .search_but{
	margin-left: 13px;
}
.tab1_div .toolbar .row_div .name_inp,
.tab1_div .toolbar .row_div .cph_inp,
.tab1_div .toolbar .row_div .yssMc_inp,
.tab1_div .toolbar .row_div .wzMc_inp,
.tab1_div .toolbar .row_div .fhdwMc_inp,
.tab1_div .toolbar .row_div .shbmMc_inp,
.tab1_div .toolbar .row_div .sjxm_inp,
.tab1_div .toolbar .row_div .sjsfzh_inp{
	width: 120px;
	height: 25px;
}
</style>
<title>Insert title here</title>
<%@include file="../../inc/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var projManaPath=path+'projMana/';
$(function(){
	initSearchLB();
	initAddLB();
	initRemoveLB();
	initTab1();
});

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var name=$("#toolbar #name").val();
			var ddztId=ddztCBB.combobox("getValue");
			var cph=$("#toolbar #cph").val();
			var yssMc=$("#toolbar #yssMc").val();
			var wzMc=$("#toolbar #wzMc").val();
			var fhdwMc=$("#toolbar #fhdwMc").val();
			var shbmMc=$("#toolbar #shbmMc").val();
			var sjxm=$("#toolbar #sjxm").val();
			var sjsfzh=$("#toolbar #sjsfzh").val();
			tab1.datagrid("load",{name:name,ddztId:ddztId,cph:cph,yssMc:yssMc,wzMc:wzMc,
				fhdwMc:fhdwMc,shbmMc:shbmMc,sjxm:sjxm,sjsfzh:sjsfzh});
		}
	});
}

function initAddLB(){
	addLB=$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=projManaPath+"zhcx/new";
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
		title:"综合查询",
		url:projManaPath+"queryZHCXList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str;
           		if(row.id!="<div style=\"text-align:center;\">暂无信息<div>"){
	            	str="<a href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;"
	            	   +"<a href=\"detail?id="+value+"\">详情</a>&nbsp;&nbsp;";
	           		if(row.ddztMc==dshDdztMc){
	           			var rowJson = JSON.stringify(row).replace(/"/g, '&quot;');
	           			str+="<a class=\"check_a\" onclick=\"openCheckDDXXDialog(true,"+rowJson+")\">审核</a>";
	           		}
           		}
           		else
           			str=value;
            	return str;
            }},
			{field:"name",title:"项目名称",width:150},
			{field:"ddztMc",title:"订单状态",width:150},
			{field:"sjxm",title:"司机姓名",width:100},
			{field:"cph",title:"车牌号",width:150},
			{field:"wzlxMc",title:"物资类型",width:150},
			{field:"wzMc",title:"物资名称",width:150},
			{field:"yssMc",title:"运输商",width:150},
			{field:"fhdwMc",title:"发货单位",width:150},
			{field:"shbmMc",title:"收货部门",width:150},
            {field:"sjzl",title:"实际重量",width:100},
            {field:"ejbfh",title:"二检地磅",width:100,formatter:function(value,row){
            	var dbm;
            	switch (value) {
				case 1:
					dbm="托利多";
					break;
				case 2:
					dbm="耀华";
					break;
				}
            	return dbm;
            }},
            {field:"bjsj",title:"编辑时间",width:150}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{id:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"id",colspan:17});
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
				<span class="ddzt_span">订单状态：</span>
				<input id="ddzt_cbb"/>
				<span class="cph_span">车牌号：</span>
				<input type="text" class="cph_inp" id="cph" placeholder="请输入车牌号"/>
				<span class="yss_span">运输商：</span>
				<input type="text" class="yssMc_inp" id="yssMc" placeholder="请输入运输商"/>
				<span class="wzMc_span">物资名称：</span>
				<input type="text" class="wzMc_inp" id="wzMc" placeholder="请输入物资名称"/>
			</div>
			<div class="row_div">
				<span class="fhdw_span">发货单位：</span>
				<input type="text" class="fhdwMc_inp" id="fhdwMc" placeholder="请输入发货单位"/>
				<span class="shbm_span">收货部门：</span>
				<input type="text" class="shbmMc_inp" id="shbmMc" placeholder="请输入收货部门"/>
				<span class="sjxm_span">司机姓名：</span>
				<input type="text" class="sjxm_inp" id="sjxm" placeholder="请输入司机姓名"/>
				<span class="sjsfzh_span">司机身份证号：</span>
				<input type="text" class="sjsfzh_inp" id="sjsfzh" placeholder="请输入司机身份证号"/>
				<a class="search_but" id="search_but">查询</a>
				<a id="manual_but">人工</a>
				<a id="ddfw_but">订单复位</a>
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