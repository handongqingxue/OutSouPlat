<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
.name_inp{
	width: 180px;
	height:30px;
}
.deveLang_inp,.database_inp,.deveTool_inp{
	width: 150px;
	height:30px;
}
.intro_inp{
	width: 250px;
	height:250px;
}
.uploadBut_div{
	line-height:30px;
	text-align:center;
	color:#fff;
	background-color: #1777FF;
	border-radius:5px;
	cursor: pointer;
}
.upIllusBut_div{
	width: 90px;
	height: 30px;
}
.illus_file{
	display: none;
}
.illus_img{
	width: 220px;
	height:220px;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var projManaPath=path+'projMana/';
var dialogTop=70;
var dialogLeft=20;
var edNum=0;

var unContractState;
var contractedState;
var developingState;
var finishState;

var unContractStateName;
var contractedStateName;
var developingStateName;
var finishStateName;
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
	unContractState=parseInt('${requestScope.unContractState}');
	contractedState=parseInt('${requestScope.contractedState}');
	developingState=parseInt('${requestScope.developingState}');
	finishState=parseInt('${requestScope.finishState}');

	unContractStateName='${requestScope.unContractStateName}';
	contractedStateName='${requestScope.contractedStateName}';
	developingStateName='${requestScope.developingStateName}';
	finishStateName='${requestScope.finishStateName}';
}

function initEditDialog(){
	dialogTop+=20;
	$("#edit_div").dialog({
		title:"项目信息",
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
		$(this).css("height",(i==2?300:45)+"px");
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
	data.push({"value":unContractState,"text":unContractStateName});
	data.push({"value":contractedState,"text":contractedStateName});
	data.push({"value":developingState,"text":developingStateName});
	data.push({"value":finishState,"text":finishStateName});
	
	stateCBB=$("#state_cbb").combobox({
		valueField:"value",
		textField:"text",
		//multiple:true,
		data:data,
		onLoadSuccess:function(){
			$(this).combobox("setValue",'${requestScope.project.state }');
		}
	});
}

function checkEdit(){
	if(checkName()){
		if(checkDeveLang()){
			if(checkDatabase()){
				if(checkDeveTool()){
					if(checkState()){
						editProject();
					}
				}
			}
		}
	}
}

function editProject(){
	var state=stateCBB.combobox("getValue");
	$("#edit_div #state").val(state);
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:projManaPath+"editProject",
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

//验证品牌型号
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

function focusDeveLang(){
	var deveLang = $("#deveLang").val();
	if(deveLang=="开发语言不能为空"){
		$("#deveLang").val("");
		$("#deveLang").css("color", "#555555");
	}
}

//验证开发语言
function checkDeveLang(){
	var deveLang = $("#deveLang").val();
	if(deveLang==null||deveLang==""||deveLang=="开发语言不能为空"){
		$("#deveLang").css("color","#E15748");
    	$("#deveLang").val("开发语言不能为空");
    	return false;
	}
	else
		return true;
}

function focusDatabase(){
	var database = $("#database").val();
	if(database=="数据库不能为空"){
		$("#database").val("");
		$("#database").css("color", "#555555");
	}
}

//验证数据库
function checkDatabase(){
	var database = $("#database").val();
	if(database==null||database==""||database=="数据库不能为空"){
		$("#database").css("color","#E15748");
    	$("#database").val("数据库不能为空");
    	return false;
	}
	else
		return true;
}

function focusDeveTool(){
	var deveTool = $("#deveTool").val();
	if(deveTool=="开发工具不能为空"){
		$("#deveTool").val("");
		$("#deveTool").css("color", "#555555");
	}
}

//验证开发工具
function checkDeveTool(){
	var deveTool = $("#deveTool").val();
	if(deveTool==null||deveTool==""||deveTool=="开发工具不能为空"){
		$("#deveTool").css("color","#E15748");
    	$("#deveTool").val("开发工具不能为空");
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

function uploadIllus(){
	document.getElementById("illus_file").click();
}

function showIllus(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#illus_img");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
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
		<div class="page_location_div">项目列表-编辑项目</div>
		
		<div id="edit_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.project.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					项目名称
				</td>
				<td class="td2">
					<input type="text" class="name_inp" id="name" name="name" value="${requestScope.project.name }" placeholder="请输入项目名称"/>
				</td>
				<td class="td1" align="right">
					开发语言
				</td>
				<td class="td2">
					<input type="text" class="deveLang_inp" id="deveLang" name="deveLang" value="${requestScope.project.deveLang }" placeholder="请输入开发语言"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					数据库
				</td>
				<td class="td2">
					<input type="text" class="database_inp" id="database" name="database" value="${requestScope.project.database }" placeholder="请输入数据库"/>
				</td>
				<td class="td1" align="right">
					开发工具
				</td>
				<td class="td2">
					<input type="text" class="deveTool_inp" id="deveTool" name="deveTool" value="${requestScope.project.deveTool }" placeholder="请输入开发工具"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简介
				</td>
				<td class="td2">
					<textarea rows="6" cols="10" class="intro_inp" id="intro" name="intro" placeholder="请输入简介">${requestScope.project.intro }</textarea>
				</td>
				<td class="td1" align="right">
					插图
				</td>
				<td class="td2">
					<div class="uploadBut_div upIllusBut_div" onclick="uploadIllus()">选择插图</div>
					<input type="file" class="illus_file" id="illus_file" name="illus_file" onchange="showIllus(this)"/>
					<img class="illus_img" id="illus_img" alt="" src="${requestScope.project.illusUrl }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					状态
				</td>
				<td class="td2">
					<input id="state_cbb"/>
					<input type="hidden" id="state" name="state" value="${requestScope.project.state }"/>
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