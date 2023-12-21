<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<c:set var="taskBagAddPermStr" value=",${requestScope.taskBagAddPerm},"></c:set>
<c:set var="taskBagDelPermStr" value=",${requestScope.taskBagDelPerm},"></c:set>
<c:set var="taskBagEditPermStr" value=",${requestScope.taskBagEditPerm},"></c:set>
<c:set var="taskBagSubmitPermStr" value=",${requestScope.taskBagSubmitPerm},"></c:set>
<c:set var="taskBagOrderPermStr" value=",${requestScope.taskBagOrderPerm},"></c:set>
<c:set var="agreeOrderPermStr" value=",${requestScope.agreeOrderPerm},"></c:set>
<c:set var="refuseOrderPermStr" value=",${requestScope.refuseOrderPerm},"></c:set>
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
<script type="text/javascript">
var path='<%=basePath %>';
var taskBagManaPath=path+'taskBagMana/';

var sessionUsernameStr='${sessionUsernameStr}';
var usernameStr='${usernameStr}';
var permissionIdsStr='${permissionIdsStr}';
var taskBagAddPermStr='${taskBagAddPermStr}';
var taskBagDelPermStr='${taskBagDelPermStr}';
var taskBagEditPermStr='${taskBagEditPermStr}';
var taskBagSubmitPermStr='${taskBagSubmitPermStr}';
var taskBagOrderPermStr='${taskBagOrderPermStr}';
var agreeOrderPermStr='${agreeOrderPermStr}';
var refuseOrderPermStr='${refuseOrderPermStr}';

var showEditOptionBut=false;
var showSubmitOptionBut=false;
var showOrderOptionBut=false;
var showAgreeOrderOptionBut=false;
var showRefuseOrderOptionBut=false;

var unSubmitState;
var unOrderState;
var orderCheckingState;
var developingState;
var testingState;
var finishState;

var unSubmitStateName;
var unOrderStateName;
var orderCheckingStateName;
var developingStateName;
var testingStateName;
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
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(taskBagAddPermStr)!=-1)
		initAddLB();
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(taskBagDelPermStr)!=-1)
		initRemoveLB();
}

function showOptionByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(taskBagEditPermStr)!=-1)
		showEditOptionBut=true;
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(taskBagSubmitPermStr)!=-1)
		showSubmitOptionBut=true;
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(taskBagOrderPermStr)!=-1)
		showOrderOptionBut=true;
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(agreeOrderPermStr)!=-1)
		showAgreeOrderOptionBut=true;
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(refuseOrderPermStr)!=-1)
		showRefuseOrderOptionBut=true;
}

function initStateVar(){
	unSubmitState=parseInt('${requestScope.unSubmitState}');
	unOrderState=parseInt('${requestScope.unOrderState}');
	orderCheckingState=parseInt('${requestScope.orderCheckingState}');
	developingState=parseInt('${requestScope.developingState}');
	testingState=parseInt('${requestScope.testingState}');
	finishState=parseInt('${requestScope.finishState}');

	unSubmitStateName='${requestScope.unSubmitStateName}';
	unOrderStateName='${requestScope.unOrderStateName}';
	orderCheckingStateName='${requestScope.orderCheckingStateName}';
	developingStateName='${requestScope.developingStateName}';
	testingStateName='${requestScope.testingStateName}';
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
	data.push({"value":unSubmitState,"text":unSubmitStateName});
	data.push({"value":unOrderState,"text":unOrderStateName});
	data.push({"value":orderCheckingState,"text":orderCheckingStateName});
	data.push({"value":developingState,"text":developingStateName});
	data.push({"value":testingState,"text":testingStateName});
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
			var projectName=$("#toolbar #projectName").val();
			var uploadUserName=$("#toolbar #uploadUserName").val();
			var createTimeStart=createTimeStartDTB.datetimebox("getValue");
			var createTimeEnd=createTimeEndDTB.datetimebox("getValue");
			var state=stateCBB.combobox("getValue");
			
			tab1.datagrid("load",{name:name,projectName:projectName,uploadUserName:uploadUserName,
				createTimeStart:createTimeStart,createTimeEnd:createTimeEnd,state:state});
		}
	});
}

function initAddLB(){
	addLB=$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=taskBagManaPath+"taskBagList/new";
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

function deleteByIds() {
	var rows=tab1.datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("提示","请选择要删除的信息！","warning");
		return false;
	}

	var confirmStr="";
	var orderedNames="";
	var unOrderIds="";
	var unOrderAnnexFileUrls="";
	var unOrderProjectIds="";
	for (var i = 0; i < rows.length; i++) {
		if(rows[i].state==developingState||rows[i].state==testingState)
			orderedNames += "、" + rows[i].name;
		else{
			unOrderIds += "," + rows[i].id;
			unOrderAnnexFileUrls += "," + rows[i].annexFileUrl;
			unOrderProjectIds += "," + rows[i].projectId;
		}
	}
	if(orderedNames!="")
		orderedNames=orderedNames.substring(1);
	if(unOrderIds!=""){
		unOrderIds=unOrderIds.substring(1);
		unOrderAnnexFileUrls=unOrderAnnexFileUrls.substring(1);
		unOrderProjectIds=unOrderProjectIds.substring(1);
	}
	
	if(orderedNames!=""&unOrderIds==""){
		confirmStr="任务包"+orderedNames+"已接单，无法删除";
		alert(confirmStr);
		return false;
	}
	else if(orderedNames!=""&unOrderIds!="")
		confirmStr="任务包"+orderedNames+"已接单，无法删除,要删除其他任务包吗？";
	else
		confirmStr="确实要删除选中的任务包吗？";
	
	if(confirm(confirmStr)){
		$.post(taskBagManaPath + "deleteTaskBagByIds",
			{ids:unOrderIds,annexFileUrls:unOrderAnnexFileUrls,projectIds:unOrderProjectIds},
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

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"任务包列表",
		url:taskBagManaPath+"queryList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"name",title:"任务名称",width:150},
			{field:"projectName",title:"项目",width:150},
			{field:"commission",title:"佣金",width:150},
			{field:"uploadUserName",title:"上传者",width:150},
			{field:"createTime",title:"发布时间",width:150},
            {field:"state",title:"状态",width:100,formatter:function(value,row){
            	return getStateNameById(value);
            }},
            {field:"id",title:"操作",width:220,formatter:function(value,row){
            	var str="";
	            	if(showEditOptionBut){
	            		if(row.state==unSubmitState||row.state==unOrderState)
	            			str+="<a href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;";
	            	}
	            	str+="<a href=\"detail?id="+value+"\">详情</a>&nbsp;&nbsp;";
	            	if(showSubmitOptionBut){
		   	            if(row.state==unSubmitState)
			            	str+="<a onclick=\"submitById("+value+")\">发布</a>&nbsp;&nbsp;";
	            	}
	            	if(showOrderOptionBut){
			            if(row.state==unOrderState)
			            	str+="<a onclick=\"updateOrderUserId("+value+",'"+row.name+"',"+row.uploadUserId+",'update')\">接单</a>&nbsp;&nbsp;";
	            	}
	            	if(showAgreeOrderOptionBut){
			            if(row.state==orderCheckingState)
			            	str+="<a onclick=\"receiveOrder("+value+",'"+row.name+"',"+row.projectId+","+row.orderUserId+")\">同意接单</a>&nbsp;&nbsp;";
	            	}
	            	if(showRefuseOrderOptionBut){
			            if(row.state==orderCheckingState)
			            	str+="<a onclick=\"updateOrderUserId("+value+",'"+row.name+"',"+row.uploadUserId+",'clear')\">拒绝接单</a>&nbsp;&nbsp;";
	            	}
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

function getStateNameById(stateId){
	var str;
	switch (stateId) {
	case unSubmitState:
		str=unSubmitStateName;//未发布
		break;
	case unOrderState:
		str=unOrderStateName;//未接单
		break;
	case orderCheckingState:
		str=orderCheckingStateName;//接单审核中
		break;
	case developingState:
		str=developingStateName;//开发中
		break;
	case testingState:
		str=testingStateName;//测试中
		break;
	case finishState:
		str=finishStateName;//已完成
		break;
	}
	return str;
}

function submitById(id){
	$.post(taskBagManaPath+"submitTaskBag",
		{id:id},
		function(data){
			if(data.status==1){
				alert(data.msg);
				tab1.datagrid("load");
			}
			else{
				alert(data.msg);
			}
		}
	,"json");
}

function updateOrderUserId(id,name,uploadUserId,flag){
	var orderUserId='${sessionScope.user.id}';
	var orderUserName='${sessionScope.user.username}';
	$.post(taskBagManaPath+"updateOrderUserId",
		{id:id,name:name,uploadUserId:uploadUserId,orderUserId:orderUserId,orderUserName:orderUserName,flag:flag},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				tab1.datagrid("load");
			}
			else{
				alert(data.info);
			}
		}
	,"json");
}

function receiveOrder(taskBagId,taskBagName,projectId,orderUserId){
	var agreeUserId='${sessionScope.user.id}';
	var agreeUserName='${sessionScope.user.username}';
	$.post(taskBagManaPath+"newTaskOrder",
		{taskBagId:taskBagId,taskBagName:taskBagName,projectId:projectId,agreeUserId:agreeUserId,agreeUserName:agreeUserName,orderUserId:orderUserId},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				tab1.datagrid("load");
			}
			else{
				alert(data.info);
			}
		}
	,"json");
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
				<span class="name_span">任务名称：</span>
				<input type="text" class="name_inp" id="name" placeholder="请输入任务名称"/>
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
				<c:if test="${sessionScope.user.username eq usernameStr||fn:contains(permissionIdsStr,taskBagAddPermStr)}">
				<a id="add_but">添加</a>
				</c:if>
				<c:if test="${sessionScope.user.username eq usernameStr||fn:contains(permissionIdsStr,taskBagDelPermStr)}">
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