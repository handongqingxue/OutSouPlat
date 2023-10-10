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
		title:"测试结果信息",
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
		$(this).css("height",(i==3?250:45)+"px");
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
		<div class="page_location_div">测试结果-综合查询-详情</div>
		
		<div id="detail_div">
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
					${requestScope.testResult.phone }
				</td>
				<td class="td1" align="right">
					状态
				</td>
				<td class="td2">
					<!-- https://blog.csdn.net/u012730333/article/details/42081827 -->
					<c:choose>
						<c:when test="${requestScope.testResult.state eq requestScope.unTestState }">${requestScope.unTestStateName}</c:when>
						<c:when test="${requestScope.testResult.state eq requestScope.testingState }">${requestScope.testingStateName}</c:when>
						<c:when test="${requestScope.testResult.state eq requestScope.unPassState }">${requestScope.unPassStateName}</c:when>
						<c:when test="${requestScope.testResult.state eq requestScope.unPayState }">${requestScope.unPayStateName}</c:when>
						<c:when test="${requestScope.testResult.state eq requestScope.paidState }">${requestScope.paidStateName}</c:when>
					</c:choose>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					简介
				</td>
				<td class="td2">
					${requestScope.testResult.desc }
				</td>
				<td class="td1" align="right">
				</td>
				<td class="td2">
				</td>
			  </tr>
			</table>
		</div>

		<%@include file="../../inc/foot.jsp"%>
	</div>
</div>
</body>
</html>