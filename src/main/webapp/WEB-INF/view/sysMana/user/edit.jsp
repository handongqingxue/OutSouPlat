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
.zsxm_inp{
	width: 150px;
	height:30px;
}
.js_inp{
	width: 180px;
	height:30px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var xtglPath=path+'xtgl/';
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
		title:"用户信息",
		width:setFitWidthInParent("body","edit_div"),
		height:250,
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
	$("#edit_div table tr").css("height","45px");

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

	initJSIdsCBB();
}

function initJSIdsCBB(){
	var data=[];
	data.push({"value":"","text":"请选择角色"});
	$.post(xtglPath+"queryJueSeCBBList",
		function(result){
			var rows=result.rows;
			for(var i=0;i<rows.length;i++){
				data.push({"value":rows[i].id,"text":rows[i].mc});
			}
			jsIdsCBB=$("#edit_div #jsIds_cbb").combobox({
				valueField:"value",
				textField:"text",
				data:data,
				multiple:true,
				onLoadSuccess:function(){
					$(this).combobox("setValues",'${requestScope.yh.jsIds }'.split(","));
				}
			});
		}
	,"json");
}

function checkEdit(){
	editYongHu();
}

function editYongHu(){
	var jsIdsArr=jsIdsCBB.combobox("getValues");
	var jsIds=jsIdsArr.sort().toString();
	if(jsIds.substring(0,1)==",")
		jsIds=jsIds.substring(1);
	jsIdsCBB.combobox("setValues",jsIds.split(","));
	$("#edit_div #jsIds").val(jsIds);
	
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:xtglPath+"editYongHu",
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
				alert(data.msg);
			}
		}
	});
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
		<div class="page_location_div">系统管理-用户-编辑</div>
		
		<div id="edit_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.yh.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					用户名
				</td>
				<td class="td2">
					${requestScope.yh.yhm }
				</td>
				<td class="td1" align="right">
					真实姓名
				</td>
				<td class="td2">
					<input type="text" class="zsxm_inp" id="zsxm" name="zsxm" value="${requestScope.yh.xm }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					创建时间
				</td>
				<td class="td2">
					${requestScope.yh.cjsj }
				</td>
				<td class="td1" align="right">
					审核状态
				</td>
				<td class="td2">
					<c:if test="${requestScope.yh.shzt eq requestScope.dshShzt }">${requestScope.dshShztMc }</c:if>
					<c:if test="${requestScope.yh.shzt eq requestScope.shtgShzt }">${requestScope.shtgShztMc}</c:if>
					<c:if test="${requestScope.yh.shzt eq requestScope.bjzShzt }">${requestScope.bjzShztMc}</c:if>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简述
				</td>
				<td class="td2">
					<input type="text" class="js_inp" id="js" name="js" value="${requestScope.yh.js }"/>
				</td>
				<td class="td1" align="right">
					角色
				</td>
				<td class="td2">
					<input id="jsIds_cbb"/>
					<input type="hidden" id="jsIds" name="jsIds" value="${requestScope.yh.jsIds }"/>
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