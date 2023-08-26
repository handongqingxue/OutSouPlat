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
var ddNum=0;
$(function(){
	initDetailDialog();//0

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ddpw=$("body").find(".panel.window").eq(ddNum);
	var ddws=$("body").find(".window-shadow").eq(ddNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ddpw);
	ccDiv.append(ddws);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");
}

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"项目信息",
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
		$(this).css("height",(i==2?300:45)+"px");
	});

	$(".panel.window").eq(ddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ddNum).css("color","#000");
	$(".panel.window .panel-title").eq(ddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ddNum).css("border-color","#ddd");
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
		<div class="page_location_div">项目列表-项目详情</div>
		
		<div id="detail_div">
			<table>
			  <tr>
				<td class="td1" align="right">
					项目名称
				</td>
				<td class="td2">
					${requestScope.project.name }
				</td>
				<td class="td1" align="right">
					开发语言
				</td>
				<td class="td2">
					${requestScope.project.deveLang }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					数据库
				</td>
				<td class="td2">
					${requestScope.project.database }
				</td>
				<td class="td1" align="right">
					开发工具
				</td>
				<td class="td2">
					${requestScope.project.deveTool }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简介
				</td>
				<td class="td2">
					${requestScope.project.intro }
				</td>
				<td class="td1" align="right">
					插图
				</td>
				<td class="td2">
					<img class="illus_img" id="illus_img" alt="" src="${requestScope.project.illusUrl }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					外包人数
				</td>
				<td class="td2">
					${requestScope.project.outCount }
				</td>
				<td class="td1" align="right">
					任务包数量
				</td>
				<td class="td2">
					${requestScope.project.taskBagCount }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					发布时间
				</td>
				<td class="td2">
					${requestScope.project.createTime }
				</td>
				<td class="td1" align="right">
					状态
				</td>
				<td class="td2">
					<c:if test="${requestScope.project.state eq 1 }">待发布</c:if>
					<c:if test="${requestScope.project.state eq 2 }">待开发</c:if>
					<c:if test="${requestScope.project.state eq 3 }">开发中</c:if>
					<c:if test="${requestScope.project.state eq 4 }">已完成</c:if>
					<c:if test="${requestScope.project.state eq 5 }">已下架</c:if>
				</td>
			  </tr>
			</table>
		</div>

		<%@include file="../../inc/foot.jsp"%>
	</div>
</div>
</body>
</html>