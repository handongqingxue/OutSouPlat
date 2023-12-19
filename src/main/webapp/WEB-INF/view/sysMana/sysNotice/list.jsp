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
.tab1_div .toolbar .title_span,
.tab1_div .toolbar .sendUserName_span,
.tab1_div .toolbar .receiveUserName_span,
.tab1_div .toolbar .createTime_span,
.tab1_div .toolbar .read_span{
	margin-left: 13px;
}
.tab1_div .toolbar .title_inp,
.tab1_div .toolbar .sendUserName_inp,
.tab1_div .toolbar .receiveUserName_inp{
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

var unRead;
var read;

var unReadName;
var readName;

var userId;
$(function(){
	initQSNUserId();
	initReadVar();
	
	initCreateTimeStartDTB();
	initCreateTimeEndDTB();
	initReadCBB();
	initSignReadLB();
	initSearchLB();
	initTab1();
});

function initQSNUserId(){
	if('${sessionUsernameStr}'=='${usernameStr}'){
		userId="";
	}
	else{
		var roleNames='${sessionScope.user.roleNames}';
		if(roleNames.includes("技术人员")){
			userId="";
		}
		else{
			userId='${sessionUserIdStr}';
		}
	}
}

function initReadVar(){
	unRead='${requestScope.unRead}';
	read='${requestScope.read}';

	unReadName='${requestScope.unReadName}';
	readName='${requestScope.readName}';
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

function initReadCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":read,"text":readName});
	data.push({"value":unRead,"text":unReadName});
	
	readCBB=$("#read_cbb").combobox({
		valueField:"value",
		textField:"text",
		//multiple:true,
		data:data
	});
}

function initSignReadLB(){
	signReadLB=$("#signRead_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			signReadByIds();
		}
	});
}

function signReadByIds() {
	var rows=tab1.datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("提示","请选择要标注的信息！","warning");
		return false;
	}
	
	var ids="";
	for (var i = 0; i < rows.length; i++) {
		if(!rows[i].read){
			ids += "," + rows[i].id;
		}
	}
	if(ids==""){
		$.messager.alert("提示","所选信息状态都是已读！","warning");
		return false;
	}
	else{
		ids=ids.substring(1);
		$.post(sysManaPath + "signNoticeRead",
			{ids:ids},
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
}

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var title=$("#toolbar #title").val();
			var sendUserName=$("#toolbar #sendUserName").val();
			var receiveUserName=$("#toolbar #receiveUserName").val();
			var createTimeStart=createTimeStartDTB.datetimebox("getValue");
			var createTimeEnd=createTimeEndDTB.datetimebox("getValue");
			var read=readCBB.combobox("getValue");
			tab1.datagrid("load",{title:title,sendUserName:sendUserName,receiveUserName:receiveUserName,createTimeStart:createTimeStart,createTimeEnd:createTimeEnd,read:read,userId:userId});
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"系统管理-通知查询-列表",
		url:sysManaPath+"querySysNoticeList",
		queryParams:{userId:userId},
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"title",title:"标题",width:150},
			{field:"contentSubStr",title:"内容",width:300},
			{field:"sendUserName",title:"发送人",width:150},
			{field:"receiveUserName",title:"接收人",width:150},
			{field:"createTime",title:"发送时间",width:150},
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
			<span class="sendUserName_span">发送人：</span>
			<input type="text" class="sendUserName_inp" id="sendUserName" placeholder="请输入发送人"/>
			<span class="receiveUserName_span">接收人：</span>
			<input type="text" class="receiveUserName_inp" id="receiveUserName" placeholder="请输入接收人"/>
			<span class="createTime_span">发送时间：</span>
			<input id="createTimeStart_dtb"/>-
			<input id="createTimeEnd_dtb"/>
			<span class="read_span">是否已读：</span>
			<input id="read_cbb"/>
			<a id="signRead_but">标记为已读</a>
			<a class="search_but" id="search_but">查询</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>