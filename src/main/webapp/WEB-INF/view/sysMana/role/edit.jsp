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
.name_inp,.px_inp{
	width: 150px;
	height:30px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var sysManaPath=path+'sysMana/';
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
		title:"角色信息",
		width:setFitWidthInParent("body","edit_div"),
		height:240,
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
		$(this).css("height",(i==1?90:45)+"px");
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

	initPermissionCBB();
}

function initPermissionCBB(){
	var data=[];
	data.push({"value":"","text":"请选择"});
	$.post(sysManaPath+"queryPermissionCBBList",
		function(result){
			var rows=result.rows;
			for(var i=0;i<rows.length;i++){
				data.push({"value":rows[i].id,"text":rows[i].name});
			}
			permissionCBB=$("#edit_div #permission_cbb").combobox({
				valueField:"value",
				textField:"text",
				data:data,
				multiple:true,
				onLoadSuccess:function(){
					$(this).combobox("setValues",'${requestScope.role.permissionIds }'.split(","));
				}
			});
		}
	,"json");
}

function checkEdit(){
	if(checkName()){
		if(checkPermissionIds()){
			editRole();
		}
	}
}

function editRole(){
	var permissionIdsArr=permissionCBB.combobox("getValues");
	var permissionIds=permissionIdsArr.sort().toString();
	if(permissionIds.substring(0,1)==",")
		permissionIds=permissionIds.substring(1);
	$("#edit_div #permissionIds").val(String(permissionIds));
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:sysManaPath+"editRole",
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
	if(name=="名称不能为空"){
		$("#name").val("");
		$("#name").css("color", "#555555");
	}
}

//验证名称
function checkName(){
	var name = $("#name").val();
	if(name==null||name==""||name=="名称不能为空"){
		$("#name").css("color","#E15748");
    	$("#name").val("名称不能为空");
    	return false;
	}
	else
		return true;
}

//验证权限
function checkPermissionIds(){
	var permissionIdArr=permissionCBB.combobox("getValues");
	var permissionIds=String(permissionIdArr);
	if(permissionIds==null||permissionIds==""){
	  	alert("请选择权限");
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
		<div class="page_location_div">系统管理-角色-编辑</div>
		
		<div id="edit_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.role.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					名称
				</td>
				<td class="td2">
					<input type="text" class="name_inp" id="name" name="name" value="${requestScope.role.name }" placeholder="请输入名称" onfocus="focusName()" onblur="checkName()"/>
				</td>
				<td class="td1" align="right">
					权限
				</td>
				<td class="td2">
					<input id="permission_cbb"/>
					<input type="hidden" id="permissionIds" name="permissionIds" value="${requestScope.role.permissionIds }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					描述
				</td>
				<td class="td2">
					<textarea id="describe" name="describe" rows="3" cols="30" placeholder="请输入描述">${requestScope.role.describe }</textarea>
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