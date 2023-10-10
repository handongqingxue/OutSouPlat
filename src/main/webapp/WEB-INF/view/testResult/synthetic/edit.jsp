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
.phone_inp{
	width: 180px;
	height:30px;
}
.desc_inp{
	width: 250px;
	height:200px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var testResultPath=path+'testResult/';
var dialogTop=70;
var dialogLeft=20;
var edNum=0;

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
	initStateVar();
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

function initStateVar(){
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

function initEditDialog(){
	dialogTop+=20;
	$("#edit_div").dialog({
		title:"测试结果信息",
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
		$(this).css("height",(i==3?250:45)+"px");
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
	
	initStateCBB();
}

function initStateCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	data.push({"value":unTestState,"text":unTestStateName});
	data.push({"value":testingState,"text":testingStateName});
	data.push({"value":unPassState,"text":unPassStateName});
	data.push({"value":unPayState,"text":unPayStateName});
	data.push({"value":paidState,"text":paidStateName});
	
	stateCBB=$("#edit_div #state_cbb").combobox({
		valueField:"value",
		textField:"text",
		//multiple:true,
		data:data,
		onLoadSuccess:function(){
			$(this).combobox("setValue",'${requestScope.testResult.state }');
		}
	});
}

function checkEdit(){
	if(checkPhone()){
		if(checkState()){
			editTestResult();
		}
	}
}

function editTestResult(){
	var state=stateCBB.combobox("getValue");
	$("#edit_div #state").val(state);
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:testResultPath+"edit",
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

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="电话不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证电话
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="电话不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("电话不能为空");
    	return false;
	}
	else
		return true;
}

//验证状态
function checkState(){
	var state=stateCBB.combobox("getValue");
	if(state==null||state==""){
	  	alert("请选择状态");
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
		<div class="page_location_div">测试结果-综合查询</div>
		
		<div id="edit_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.testResult.id }"/>
			<input type="hidden" id="testUserId" name="testUserId" value="${sessionScope.user.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					任务单号
				</td>
				<td class="td2">
					${requestScope.testResult.orderNo }
				</td>
				<td class="td1" align="right">
					任务包
				</td>
				<td class="td2">
					${requestScope.testResult.taskBagName }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					测试人
				</td>
				<td class="td2">
					${requestScope.testResult.testUserName }
				</td>
				<td class="td1" align="right">
					测试时间
				</td>
				<td class="td2">
					${requestScope.testResult.createTime }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					手机号
				</td>
				<td class="td2">
					<input type="text" class="phone_inp" id="phone" name="phone" value="${requestScope.testResult.phone }" placeholder="请输入任务名称" onfocus="focusPhone()" onblur="checkPhone()"/>
				</td>
				<td class="td1" align="right">
					状态
				</td>
				<td class="td2">
					<input id="state_cbb"/>
					<input type="hidden" id="state" name="state" value="${requestScope.testResult.state }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简介
				</td>
				<td class="td2">
					<textarea rows="6" cols="10" class="desc_inp" id="desc" name="desc" placeholder="请输入简介">${requestScope.testResult.desc }</textarea>
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