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
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var projManaPath=path+'projMana/';
var taskBagManaPath=path+'taskBagMana/';
var dialogTop=70;
var dialogLeft=20;
var ddNum=0;
$(function(){
	initDetailDialog();//0

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var edpw=$("body").find(".panel.window").eq(ddNum);
	var edws=$("body").find(".window-shadow").eq(ddNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(edpw);
	ccDiv.append(edws);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");
}

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"任务信息",
		width:setFitWidthInParent("body","detail_div"),
		height:500,
		top:dialogTop,
		left:dialogLeft
	});

	$("#detail_div table").css("width",(setFitWidthInParent("body","detail_div_table"))+"px");
	$("#detail_div table").css("magin","-100px");
	$("#detail_div table td").css("padding-left","50px");
	$("#detail_div table td").css("padding-right","20px");
	$("#detail_div table td").css("font-size","15px");
	$("#detail_div table .td1").css("width","15%");
	$("#detail_div table .td2").css("width","30%");
	$("#detail_div table tr").css("border-bottom","#CAD9EA solid 1px");
	$("#detail_div table tr").each(function(i){
		$(this).css("height",(i==4?250:45)+"px");
	});

	$(".panel.window").eq(ddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ddNum).css("color","#000");
	$(".panel.window .panel-title").eq(ddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ddNum).css("border-color","#ddd");

	$("#detail_div #ok_but").css("left","45%");
	$("#detail_div #ok_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "center_con_div":
		space=205;
		break;
	case "detail_div":
		space=340;
		break;
	case "detail_div_table":
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
		<div class="page_location_div">任务包列表-任务包详情</div>
		
		<div id="detail_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.taskBag.id }"/>
			<input type="hidden" id="uploadUserId" name="uploadUserId" value="${sessionScope.user.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					任务名称
				</td>
				<td class="td2">
					${requestScope.taskBag.name }
				</td>
				<td class="td1" align="right">
					项目
				</td>
				<td class="td2">
					${requestScope.taskBag.projectName }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					佣金
				</td>
				<td class="td2">
					${requestScope.taskBag.commission }
				</td>
				<td class="td1" align="right">
					开发时间
				</td>
				<td class="td2">
					${requestScope.taskBag.makeTime }
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
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简介
				</td>
				<td class="td2">
					${requestScope.taskBag.describe }
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