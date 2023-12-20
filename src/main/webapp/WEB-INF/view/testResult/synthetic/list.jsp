<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<c:set var="testResultDelPermStr" value=",${requestScope.testResultDelPerm},"></c:set>
<c:set var="testResultEditPermStr" value=",${requestScope.testResultEditPerm},"></c:set>
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
.tab1_div .toolbar .row_div .taskOrderNo_span,
.tab1_div .toolbar .row_div .result_span,
.tab1_div .toolbar .row_div .taskBagName_span,
.tab1_div .toolbar .row_div .uploadUserName_span,
.tab1_div .toolbar .row_div .orderUserName_span,
.tab1_div .toolbar .row_div .agreeUserName_span,
.tab1_div .toolbar .row_div .testUserName_span,
.tab1_div .toolbar .row_div .phone_span,
.tab1_div .toolbar .row_div .createTime_span,
.tab1_div .toolbar .row_div .search_but{
	margin-left: 13px;
}
.tab1_div .toolbar .row_div .taskOrderNo_inp,
.tab1_div .toolbar .row_div .taskBagName_inp,
.tab1_div .toolbar .row_div .uploadUserName_inp,
.tab1_div .toolbar .row_div .orderUserName_inp,
.tab1_div .toolbar .row_div .agreeUserName_inp,
.tab1_div .toolbar .row_div .testUserName_inp,
.tab1_div .toolbar .row_div .phone_inp{
	width: 120px;
	height: 25px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var testResultPath=path+'testResult/';

var sessionUsernameStr='${sessionUsernameStr}';
var usernameStr='${usernameStr}';
var permissionIdsStr='${permissionIdsStr}';
var testResultDelPermStr='${testResultDelPermStr}';
var testResultEditPermStr='${testResultEditPermStr}';

var showEditOptionBut=false;

var adminFlag;
var interFlag;
var exterFlag;

var unPass;
var pass;

var unPassName;
var passName;

var roleFlag;
$(function(){
	initRoleFlagVar();
	initResultVar();
	showCompontByPermission();
	showOptionByPermission();
	
	initCreateTimeStartDTB();
	initCreateTimeEndDTB();
	initResultCBB();
	initSearchLB();
	initQTRRoleFlag();
	initTab1();
});

function showCompontByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(testResultDelPermStr)!=-1)
		initRemoveLB();
}

function showOptionByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(testResultEditPermStr)!=-1)
		showEditOptionBut=true;
}

function initRoleFlagVar(){
	adminFlag=parseInt('${requestScope.adminFlag}');
	interFlag=parseInt('${requestScope.interFlag}');
	exterFlag=parseInt('${requestScope.exterFlag}');
}

function initResultVar(){
	unPass='${requestScope.unPass}';
	pass='${requestScope.pass}';

	unPassName='${requestScope.unPassName}';
	passName='${requestScope.passName}';
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

function initResultCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":unPass,"text":unPassName});
	data.push({"value":pass,"text":passName});
	
	resultCBB=$("#result_cbb").combobox({
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
			var taskOrderNo=$("#toolbar #taskOrderNo").val();
			var taskBagName=$("#toolbar #taskBagName").val();
			var uploadUserName=$("#toolbar #uploadUserName").val();
			var orderUserName=$("#toolbar #orderUserName").val();
			var agreeUserName=$("#toolbar #agreeUserName").val();
			var testUserName=$("#toolbar #testUserName").val();
			var phone=$("#toolbar #phone").val();
			var createTimeStart=createTimeStartDTB.datetimebox("getValue");
			var createTimeEnd=createTimeEndDTB.datetimebox("getValue");
			var result=resultCBB.combobox("getValue");
			
			tab1.datagrid("load",{taskOrderNo:taskOrderNo,taskBagName:taskBagName,uploadUserName:uploadUserName,orderUserName:orderUserName,agreeUserName:agreeUserName,
				testUserName:testUserName,phone:phone,createTimeStart:createTimeStart,createTimeEnd:createTimeEnd,result:result,userId:'${sessionUserIdStr}',roleFlag:roleFlag});
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

function initQTRRoleFlag(){
	if(sessionUsernameStr==usernameStr){
		roleFlag=adminFlag;
	}
	else{
		var roleNames='${sessionScope.user.roleNames}';
		if(roleNames.includes("技术人员")){
			roleFlag=interFlag;
		}
		else{
			roleFlag=exterFlag;
		}
	}
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"测试结果查询",
		url:testResultPath+"querySyntheticList",
		queryParams:{userId:'${sessionUserIdStr}',roleFlag:roleFlag},
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"taskOrderNo",title:"任务单号",width:150},
			{field:"taskBagName",title:"任务包",width:150},
			{field:"uploadUserName",title:"上传人",width:150},
			{field:"orderUserName",title:"接单人",width:150},
			{field:"agreeUserName",title:"审核人",width:150},
			{field:"testUserName",title:"测试人",width:150},
			{field:"phone",title:"测试人电话",width:150},
			{field:"createTime",title:"测试时间",width:150},
            {field:"result",title:"结果",width:100,formatter:function(value,row){
            	return getResultNameById(value);
            }},
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str="";
	            	if(showEditOptionBut)
	            		str+="<a href=\"edit?id="+value+"\">编辑</a>&nbsp;&nbsp;";
            		str+="<a href=\"detail?id="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{taskOrderNo:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"taskOrderNo",colspan:10});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
}

function getResultNameById(result){
	return result?passName:unPassName;
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
				<span class="taskOrderNo_span">任务单号：</span>
				<input type="text" class="taskOrderNo_inp" id="taskOrderNo" placeholder="请输入任务单号"/>
				<span class="taskBagName_span">任务包：</span>
				<input type="text" class="taskBagName_inp" id="taskBagName" placeholder="请输入任务包名"/>
				<span class="uploadUserName_span">上传人：</span>
				<input type="text" class="uploadUserName_inp" id="uploadUserName" placeholder="请输入上传人"/>
				<span class="orderUserName_span">接单人：</span>
				<input type="text" class="orderUserName_inp" id="orderUserName" placeholder="请输入接单人"/>
				<span class="agreeUserName_span">审核人：</span>
				<input type="text" class="agreeUserName_inp" id="agreeUserName" placeholder="请输入审核人"/>
			</div>
			<div class="row_div">
				<span class="testUserName_span">测试人：</span>
				<input type="text" class="testUserName_inp" id="testUserName" placeholder="请输入测试人"/>
				<span class="phone_span">测试人电话：</span>
				<input type="text" class="phone_inp" id="phone" placeholder="请输入测试人电话"/>
				<span class="createTime_span">测试时间：</span>
				<input id="createTimeStart_dtb"/>-
				<input id="createTimeEnd_dtb"/>
				<span class="result_span">结果：</span>
				<input id="result_cbb"/>
				<a class="search_but" id="search_but">查询</a>
				<c:if test="${sessionUsername eq usernameStr||fn:contains(permissionIdsStr,testResultDelPermStr)}">
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