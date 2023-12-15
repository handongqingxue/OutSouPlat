<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<%@include file="../../inc/js.jsp"%>
<style type="text/css">
.center_con_div{
	height: 90vh;
	margin-left:205px;
	position: absolute;
}
.page_location_div{
	height: 50px;
	line-height: 50px;
	margin-top: 60px;
	margin-left: 20px;
	font-size: 18px;
}
.edit_div .annex_file{
	margin-top: 10px;
}
.name_inp{
	width: 180px;
	height:30px;
}
.commission_inp,.makeTime_inp{
	width: 150px;
	height:30px;
}
.describe_inp{
	width: 250px;
	height:250px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var projManaPath=path+'projMana/';
var taskBagManaPath=path+'taskBagMana/';
var dialogTop=70;
var dialogLeft=20;
var edNum=0;
$(function(){
	initEditDialog();//0

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var edpw=$("body").find(".panel.window").eq(edNum);
	var edws=$("body").find(".window-shadow").eq(edNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(edpw);
	ccDiv.append(edws);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");
}

function initEditDialog(){
	dialogTop+=20;
	$("#edit_div").dialog({
		title:"任务信息",
		width:setFitWidthInParent("body","edit_div"),
		height:500,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"保存",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEdit();
           }}
        ]
	});

	$("#edit_div table").css("width",(setFitWidthInParent("body","edit_div_table"))+"px");
	$("#edit_div table").css("magin","-100px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("padding-right","20px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table .td1").css("width","15%");
	$("#edit_div table .td2").css("width","30%");
	$("#edit_div table tr").css("border-bottom","#CAD9EA solid 1px");
	$("#edit_div table tr").each(function(i){
		var height=0;
		if(i==3)
			height=80;
		else if(i==4)
			height=300;
		else
			height=45;
		$(this).css("height",height+"px");
	});

	$(".panel.window").eq(edNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(edNum).css("color","#000");
	$(".panel.window .panel-title").eq(edNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(edNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(edNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(edNum).css("border-color","#ddd");

	$("#edit_div #ok_but").css("left","45%");
	$("#edit_div #ok_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	
	initProjectCBB();
}

function initProjectCBB(){
	var data=[];
	data.push({"value":"","text":"请选择项目"});
	$.post(projManaPath+"queryCBBList",
		function(result){
			var rows=result.rows;
			for(var i=0;i<rows.length;i++){
				data.push({"value":rows[i].id,"text":rows[i].name});
			}
			projectCBB=$("#edit_div #project_cbb").combobox({
				valueField:"value",
				textField:"text",
				data:data,
				onLoadSuccess:function(){
					$(this).combobox("setValue",'${requestScope.taskBag.projectId }');
				}
			});
		}
	,"json");
}

function checkEdit(){
	if(checkName()){
		if(checkProjectId()){
			if(checkCommission()){
				if(checkMakeTime()){
					editTaskBag();
				}
			}
		}
	}
}

function editTaskBag(){
	var projectId=projectCBB.combobox("getValue");
	$("#edit_div #projectId").val(projectId);
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:taskBagManaPath+"editTaskBag",
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

function focusName(){
	var name = $("#name").val();
	if(name=="项目名称不能为空"){
		$("#name").val("");
		$("#name").css("color", "#555555");
	}
}

//验证项目名称
function checkName(){
	var name = $("#name").val();
	if(name==null||name==""||name=="项目名称不能为空"){
		$("#name").css("color","#E15748");
    	$("#name").val("项目名称不能为空");
    	return false;
	}
	else
		return true;
}

//验证项目
function checkProjectId(){
	var projectId=projectCBB.combobox("getValue");
	if(projectId==null||projectId==""){
	  	alert("请选择项目");
	  	return false;
	}
	else
		return true;
}

//验证佣金
function checkCommission(){
	var commission = $("#edit_div #commission").val();
	if(commission==null||commission==""){
	  	alert("请输入佣金");
	  	return false;
	}
	else
		return true;
}

function focusMakeTime(){
	var makeTime = $("#makeTime").val();
	if(makeTime=="开发时间不能为空"){
		$("#makeTime").val("");
		$("#makeTime").css("color", "#555555");
	}
}

//验证开发时间
function checkMakeTime(){
	var makeTime = $("#makeTime").val();
	if(makeTime==null||makeTime==""||makeTime=="开发时间不能为空"){
		$("#makeTime").css("color","#E15748");
    	$("#makeTime").val("开发时间不能为空");
    	return false;
	}
	else
		return true;
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "center_con_div":
		space=205;
		break;
	case "edit_div":
		space=340;
		break;
	case "edit_div_table":
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
	<div class="center_con_div" id="center_con_div">
		<div class="page_location_div">任务包列表-编辑任务包</div>
		
		<div class="edit_div" id="edit_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.taskBag.id }"/>
			<input type="hidden" id="uploadUserId" name="uploadUserId" value="${sessionScope.user.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					任务名称
				</td>
				<td class="td2">
					<input type="text" class="name_inp" id="name" name="name" value="${requestScope.taskBag.name }" placeholder="请输入任务名称" onfocus="focusName()" onblur="checkName()"/>
				</td>
				<td class="td1" align="right">
					项目
				</td>
				<td class="td2">
					<input id="project_cbb"/>
					<input type="hidden" id="projectId" name="projectId" value="${requestScope.taskBag.projectId }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					佣金
				</td>
				<td class="td2">
					<input type="text" class="commission_inp" id="commission" name="commission" value="${requestScope.taskBag.commission }" placeholder="请输入佣金"/>
				</td>
				<td class="td1" align="right">
					开发时间
				</td>
				<td class="td2">
					<input type="text" class="makeTime_inp" id="makeTime" name="makeTime" value="${requestScope.taskBag.makeTime }" placeholder="请输入开发时间" onfocus="focusMakeTime()" onblur="checkMakeTime()"/>
					(如:1周、1月)
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					发布时间
				</td>
				<td class="td2">
					${requestScope.taskBag.createTime }
				</td>
				<td class="td1" align="right">
					上传者
				</td>
				<td class="td2">
					${requestScope.taskBag.uploadUserName }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					下载次数
				</td>
				<td class="td2">
					${requestScope.taskBag.downloadCount }
				</td>
				<td class="td1" align="right">
					附件
				</td>
				<td class="td2">
					${requestScope.taskBag.annexFileUrl }
					<input type="file" class="annex_file" id="annex_file" name="annex_file"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简介
				</td>
				<td class="td2">
					<textarea rows="6" cols="10" class="describe_inp" id="describe" name="describe" placeholder="请输入简介">${requestScope.taskBag.describe }</textarea>
				</td>
				<td class="td1" align="right">
				</td>
				<td class="td2">
				</td>
			  </tr>
			</table>
			</form>
		</div>

		<%@include file="../../inc/foot.jsp"%>
	</div>
</div>
</body>
</html>