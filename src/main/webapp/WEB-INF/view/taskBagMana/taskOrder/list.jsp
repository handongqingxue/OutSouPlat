<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<c:set var="taskOrderDelPermStr" value=",${requestScope.taskOrderDelPerm},"></c:set>
<c:set var="downloadCodePermStr" value=",${requestScope.downloadCodePerm},"></c:set>
<c:set var="uploadCodePermStr" value=",${requestScope.uploadCodePerm},"></c:set>
<c:set var="testResultUplPermStr" value=",${requestScope.testResultUplPerm},"></c:set>
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
.tab1_div .toolbar .row_div .userName_span,
.tab1_div .toolbar .row_div .createTime_span,
.tab1_div .toolbar .row_div .finishTime_span,
.tab1_div .toolbar .row_div .search_but{
	margin-left: 13px;
}
.tab1_div .toolbar .row_div .no_inp,
.tab1_div .toolbar .row_div .taskBagName_inp,
.tab1_div .toolbar .row_div .userName_inp{
	width: 120px;
	height: 25px;
}

.upload_code_bg_div,
.upload_test_result_bg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,.45);
	position: fixed;
	z-index: 9016;
	display:none;
}

.upload_code_div{
	width: 500px;
	height: 210px;
	margin: 250px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}

.upload_test_result_div{
	width: 500px;
	height: 360px;
	margin: 150px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}
.upload_test_result_div .phone_inp{
	width: 180px;
	height:30px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var taskBagManaPath=path+'taskBagMana/';
var testResultPath=path+'testResult/';

var sessionUsernameStr='${sessionUsernameStr}';
var usernameStr='${usernameStr}';
var permissionIdsStr='${permissionIdsStr}';
var taskOrderDelPermStr='${taskOrderDelPermStr}';
var downloadCodePermStr='${downloadCodePermStr}';
var uploadCodePermStr='${uploadCodePermStr}';
var testResultUplPermStr='${testResultUplPermStr}';

var showDownloadCodeBut=false;
var showUploadCodeOptionBut=false;
var showTestResultUplOptionBut=false;

var dialogTop=10;
var dialogLeft=20;
var ucdNum=0;
var utrdNum=1;

var unFinishState;
var finishedState;
var discardedState;

var unFinishStateName;
var finishedStateName;
var discardedStateName;

var unTestState;
var testingState;
var unPassState;
var unPayState;
var paidState;

var unTestStateName;
var testingStateName;
var unPassStateName;
var unPayStateName;
var paidStateName;
$(function(){
	initTOStateVar();
	initUTRStateVar();
	showCompontByPermission();
	showOptionByPermission();
	
	initCreateTimeStartDTB();
	initCreateTimeEndDTB();
	initFinishTimeStartDTB();
	initFinishTimeEndDTB();
	initTOStateCBB();
	initSearchLB();
	initTab1();
	
	initUploadCodeDialog();//0
	initUploadTestResultDialog();//1
	
	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	var ucdpw=$("body").find(".panel.window").eq(ucdNum);
	var ucdws=$("body").find(".window-shadow").eq(ucdNum);
	
	var utrdpw=$("body").find(".panel.window").eq(utrdNum);
	var utrdws=$("body").find(".window-shadow").eq(utrdNum);

	var ucdDiv=$("#upload_code_div");
	ucdDiv.append(ucdpw);
	ucdDiv.append(ucdws);
	
	var utrdDiv=$("#upload_test_result_div");
	utrdDiv.append(utrdpw);
	utrdDiv.append(utrdws);
}

function showCompontByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(taskOrderDelPermStr)!=-1)
		initRemoveLB();
}

function showOptionByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(downloadCodePermStr)!=-1)
		showDownloadCodeBut=true;
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(uploadCodePermStr)!=-1)
		showUploadCodeOptionBut=true;
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(testResultUplPermStr)!=-1)
		showTestResultUplOptionBut=true;
}

function initTOStateVar(){
	unFinishState=parseInt('${requestScope.unFinishState}');
	finishedState=parseInt('${requestScope.finishedState}');
	discardedState=parseInt('${requestScope.discardedState}');

	unFinishStateName='${requestScope.unFinishStateName}';
	finishedStateName='${requestScope.finishedStateName}';
	discardedStateName='${requestScope.discardedStateName}';
}

function initUTRStateVar(){
	unTestState=parseInt('${requestScope.unTestState}');
	testingState=parseInt('${requestScope.testingState}');
	unPassState=parseInt('${requestScope.unPassState}');
	unPayState=parseInt('${requestScope.unPayState}');
	paidState=parseInt('${requestScope.paidState}');

	unTestStateName='${requestScope.unTestStateName}';
	testingStateName='${requestScope.testingStateName}';
	unPassStateName='${requestScope.unPassStateName}';
	unPayStateName='${requestScope.unPayStateName}';
	paidStateName='${requestScope.paidStateName}';
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

function initTOStateCBB(){
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

function initUploadCodeDialog(){
	$("#upload_code_dialog_div").dialog({
		title:"上传代码文件",
		width:setFitWidthInParent("#upload_code_div","upload_code_dialog_div"),
		height:150,
		top:5,
		left:dialogLeft,
		buttons:[
           {text:"确定",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   uploadCode();
           }},
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openUploadCodeDialog(false,"");
           }}
        ]
	});

	$("#upload_code_dialog_div table").css("width",(setFitWidthInParent("#upload_code_div","upload_code_dialog_table"))+"px");
	$("#upload_code_dialog_div table").css("magin","-100px");
	$("#upload_code_dialog_div table td").css("padding-left","0px");
	$("#upload_code_dialog_div table td").css("padding-right","20px");
	$("#upload_code_dialog_div table td").css("font-size","15px");
	$("#upload_code_dialog_div table .td1").css("width","50%");
	$("#upload_code_dialog_div table .td2").css("width","50%");
	$("#upload_code_dialog_div table tr").css("height","45px");

	$(".panel.window").eq(ucdNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ucdNum).css("color","#000");
	$(".panel.window .panel-title").eq(ucdNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ucdNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ucdNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ucdNum).css("border-color","#ddd");

	$("#upload_code_dialog_div #ok_but").css("left","30%");
	$("#upload_code_dialog_div #ok_but").css("position","absolute");

	$("#upload_code_dialog_div #cancel_but").css("left","50%");
	$("#upload_code_dialog_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function initUploadTestResultDialog(){
	$("#upload_test_result_dialog_div").dialog({
		title:"上传测试结果",
		width:setFitWidthInParent("#upload_test_result_div","upload_test_result_dialog_div"),
		height:300,
		top:5,
		left:dialogLeft,
		buttons:[
           {text:"确定",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkTestResult();
           }},
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openUploadTestResultDialog(false,"");
           }}
        ]
	});

	$("#upload_test_result_dialog_div table").css("width",(setFitWidthInParent("#upload_test_result_div","upload_test_result_dialog_table"))+"px");
	$("#upload_test_result_dialog_div table").css("magin","-100px");
	$("#upload_test_result_dialog_div table td").css("padding-left","0px");
	$("#upload_test_result_dialog_div table td").css("padding-right","30px");
	$("#upload_test_result_dialog_div table td").css("font-size","15px");
	$("#upload_test_result_dialog_div table .td1").css("width","30%");
	$("#upload_test_result_dialog_div table .td2").css("width","70%");
	$("#upload_test_result_dialog_div table tr").each(function(i){
		var height;
		if(i==1)
			height=100;
		else
			height=45;
		$(this).css("height",height+"px");
	});

	$(".panel.window").eq(utrdNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(utrdNum).css("color","#000");
	$(".panel.window .panel-title").eq(utrdNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(utrdNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(utrdNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(utrdNum).css("border-color","#ddd");

	$("#upload_test_result_dialog_div #ok_but").css("left","30%");
	$("#upload_test_result_dialog_div #ok_but").css("position","absolute");

	$("#upload_test_result_dialog_div #cancel_but").css("left","50%");
	$("#upload_test_result_dialog_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	
	initUtrStateCBB();
}

function initUtrStateCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":unTestState,"text":unTestStateName});
	data.push({"value":testingState,"text":testingStateName});
	data.push({"value":unPassState,"text":unPassStateName});
	data.push({"value":unPayState,"text":unPayStateName});
	data.push({"value":paidState,"text":paidStateName});
	
	utrStateCBB=$("#utr_state_cbb").combobox({
		valueField:"value",
		textField:"text",
		data:data
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"任务单查询",
		url:taskBagManaPath+"queryTaskOrderList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body","tab1_div"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"no",title:"任务单号",width:150},
			{field:"taskBagName",title:"任务包",width:150},
			{field:"userName",title:"接单人",width:150},
			{field:"createTime",title:"接单时间",width:150},
			{field:"finishTime",title:"完成时间",width:150},
            {field:"state",title:"状态",width:100,formatter:function(value,row){
            	return getStateNameById(value);
            }},
            {field:"id",title:"操作",width:250,formatter:function(value,row){
            	var str="";
            	str+="<a href=\"detail?id="+value+"\">详情</a>&nbsp;&nbsp;";
            	if(showUploadCodeOptionBut)
            		str+="<a onclick=\"openUploadCodeDialog(true,"+value+")\">上传代码</a>&nbsp;&nbsp;";
            	if(showTestResultUplOptionBut)
            		str+="<a onclick=\"openUploadTestResultDialog(true,"+value+")\">上传测试结果</a>&nbsp;&nbsp;";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{no:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"no",colspan:7});
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

function openUploadCodeDialog(flag,id){
	if(flag){
		$("#upload_code_bg_div").css("display","block");
	}
	else{
		$("#upload_code_bg_div").css("display","none");
	}
	$("#upload_code_div #id").val(id);
}

function openUploadTestResultDialog(flag,orderId){
	if(flag){
		$("#upload_test_result_bg_div").css("display","block");
	}
	else{
		$("#upload_test_result_bg_div").css("display","none");
	}
	$("#upload_test_result_div #orderId").val(orderId);
}

function checkTestResult(){
	if(checkUtrState()){
		if(checkUtrPhone()){
			uploadTestResult();
		}
	}
}

function uploadCode(){
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:taskBagManaPath+"uploadTaskOrderCodeFile",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.message=="ok"){
				alert(data.info);
				history.go(-1);
			}
			else{
				alert(data.info);
			}
		}
	});
}

function uploadTestResult(){
	var orderId=$("#upload_test_result_div #orderId").val();
	var state=utrStateCBB.combobox("getValue");
	$("#upload_test_result_div #state").val(state);
	
	var formData = new FormData($("#form2")[0]);
	$.ajax({
		type:"post",
		url:testResultPath+"add",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.message=="ok"){
				alert(data.info);
				openUploadTestResultDialog(false,"");
			}
			else{
				alert(data.info);
			}
		}
	});
}

//验证测试结果状态
function checkUtrState(){
	var state=utrStateCBB.combobox("getValue");
	if(state==null||state==""){
	  	alert("请选择状态");
	  	return false;
	}
	else
		return true;
}

function focusUtrPhone(){
	var phone = $("#upload_test_result_div #phone").val();
	if(phone=="电话不能为空"){
		$("#upload_test_result_div #phone").val("");
		$("#upload_test_result_div #phone").css("color", "#555555");
	}
}

//验证电话
function checkUtrPhone(){
	var phone = $("#upload_test_result_div #phone").val();
	if(phone==null||phone==""||phone=="电话不能为空"){
		$("#upload_test_result_div #phone").css("color","#E15748");
    	$("#upload_test_result_div #phone").val("电话不能为空");
    	return false;
	}
	else
		return true;
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "tab1_div":
		space=250;
		break;
	case "upload_code_dialog_div":
	case "upload_test_result_dialog_div":
		space=50;
		break;
	case "upload_code_dialog_table":
	case "upload_test_result_dialog_table":
		space=68;
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
				<span class="userName_span">接单人：</span>
				<input type="text" class="userName_inp" id="userName" placeholder="请输入接单人"/>
				<span class="createTime_span">接单时间：</span>
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
				<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,taskOrderDelPermStr)}">
				<a id="remove_but">删除</a>
				</c:if>
			</div>
		</div>
		<table id="tab1">
		</table>
	</div>
	
	<div class="upload_code_bg_div" id="upload_code_bg_div">
		<div class="upload_code_div" id="upload_code_div">
			<div class="upload_code_dialog_div" id="upload_code_dialog_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
				<input type="hidden" id="id" name="id"/>
				<table>
				  <tr>
					<td class="td1" align="right">
						选择代码文件
					</td>
					<td class="td2">
						<input type="file" id="code_file" name="code_file"/>
					</td>
				  </tr>
				</table>
			</form>
			</div>
		</div>
	</div>
	
	<div class="upload_test_result_bg_div" id="upload_test_result_bg_div">
		<div class="upload_test_result_div" id="upload_test_result_div">
			<div class="upload_test_result_dialog_div" id="upload_test_result_dialog_div">
			<form id="form2" name="form2" method="post" action="" enctype="multipart/form-data">
				<input type="hidden" id="orderId" name="orderId"/>
				<input type="hidden" id="testUserId" name="testUserId" value="${sessionScope.user.id}"/>
				<table>
				  <tr>
					<td class="td1" align="right">
						状态
					</td>
					<td class="td2">
						<input id="utr_state_cbb"/>
						<input type="hidden" id="state" name="state"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						描述
					</td>
					<td class="td2">
						<textarea rows="5" cols="30" id="desc" name="desc"></textarea>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						电话
					</td>
					<td class="td2">
						<input type="text" class="phone_inp" id="phone" name="phone" placeholder="请输入电话" onfocus="focusUtrPhone()" onblur="checkUtrPhone()"/>
					</td>
				  </tr>
				</table>
			</form>
			</div>
		</div>
	</div>
	
	<%@include file="../../inc/foot.jsp"%>
</div>
</body>
</html>