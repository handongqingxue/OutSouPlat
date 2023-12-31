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

.detail_div .proExp_div{
	width: 100%;
	height: 380px;
	overflow-y:scroll;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var sysManaPath=path+'sysMana/';
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
		title:"用户信息",
		width:setFitWidthInParent("body","detail_div"),
		height:700,
		top:dialogTop,
		left:dialogLeft
	});

	$("#detail_div table").css("width",(setFitWidthInParent("body","detail_div_table"))+"px");
	$("#detail_div table").css("magin","-100px");
	$("#detail_div table td").css("padding-left","20px");
	$("#detail_div table td").css("padding-right","20px");
	$("#detail_div table td").css("font-size","15px");
	$("#detail_div table .td1").css("width","10%");
	$("#detail_div table .td2").css("width","15%");
	$("#detail_div table .td3").css("width","60%");
	$("#detail_div table .td4").css("width","85%");
	$("#detail_div table tr").css("border-bottom","#CAD9EA solid 1px");
	$("#detail_div table tr").each(function(i){
		$(this).css("height",(i==5?400:45)+"px");
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
		<div class="page_location_div">系统管理-用户-详情</div>
		<div id="detail_div">
			<table>
			  <tr>
				<td class="td1" align="right">
					用户名
				</td>
				<td class="td2">
					${requestScope.user.username }
				</td>
				<td class="td1" align="right">
					手机号
				</td>
				<td class="td3">
					${requestScope.user.phone }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					qq号
				</td>
				<td class="td2">
					${requestScope.user.qq }
				</td>
				<td class="td1" align="right">
					微信号
				</td>
				<td class="td3">
					${requestScope.user.weixin }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					创建时间
				</td>
				<td class="td2">
					${requestScope.user.createTime }
				</td>
				<td class="td1" align="right">
					审核状态
				</td>
				<td class="td3">
					<c:choose>
						<c:when test="${requestScope.user.state eq requestScope.noCheckState }">${requestScope.noCheckStateName}</c:when>
						<c:when test="${requestScope.user.state eq requestScope.checkedState }">${requestScope.checkedStateName}</c:when>
						<c:when test="${requestScope.user.state eq requestScope.editingState }">${requestScope.editingStateName}</c:when>
					</c:choose>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					角色
				</td>
				<td class="td2">
					${requestScope.user.roleNames }
				</td>
				<td class="td1" align="right">
					学历
				</td>
				<td class="td3">
					${requestScope.user.education }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					擅长的开发语言
				</td>
				<td class="td2">
					${requestScope.user.deveLang }
				</td>
				<td class="td1" align="right">
				</td>
				<td class="td3">
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					项目经历
				</td>
				<td class="td4" colspan="3">
					<div class="proExp_div">${requestScope.user.proExp }</div>
				</td>
			  </tr>
			</table>
		</div>

		<%@include file="../../inc/foot.jsp"%>
	</div>
</div>
</body>
</html>