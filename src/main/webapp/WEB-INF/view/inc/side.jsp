<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- el表达式拼接字符串:https://zhidao.baidu.com/question/1996959905346141947.html -->
<c:set var="projSearPermStr" value=",${requestScope.projSearPerm},"></c:set>
<c:set var="taskBagSearPermStr" value=",${requestScope.taskBagSearPerm},"></c:set>
<c:set var="taskOrderSearPermStr" value=",${requestScope.taskOrderSearPerm},"></c:set>
<c:set var="testResultSearPermStr" value=",${requestScope.testResultSearPerm},"></c:set>
<c:set var="userSearPermStr" value=",${requestScope.userSearPerm},"></c:set>
<c:set var="unCheckUserSearPermStr" value=",${requestScope.unCheckUserSearPerm},"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>边框导航栏</title>
<style type="text/css">
.layui-layout-admin{
	padding: 1px;
}
.header_div{
	position: fixed;
}
.side {
	position: fixed;
	top: 50px;
	bottom: 0;
	height: 100%;
	justify-content: center;
	display: flex;
}

.head {
	align-items: center;
	position: relative;
	height: 50px;
	background-color: #20A0FF !important;
}

.headTitle, .headTitle>h1 {
	padding-left: 15px;
	margin: 0px auto;
}
.layui-nav .layui-nav-item a{
	color:#000;
}
.layui-nav .layui-nav-item .pointer-img{
	margin-top: 18px;
	margin-left: 18px;
	position: absolute;
}
.layui-nav .level-ul{
	height: 800px;
	margin-right: 10px;
	overflow-y:scroll;
}
.layui-nav .first-level-div{
	width: 92%; 
	margin: 20px auto 0; 
	border: #CAD9EA solid 1px;
	background-color: #F5FAFE;
}
.layui-nav .first-level{
    font-size: 15px;
	font-weight: bold;
	background-color: #E7F4FD;
}
.layui-nav,.layui-side{
	background-color: #FAFDFE;
}
.layui-side{
	border-right:#86B9D6 solid 1px;
}
.layui-layout-admin .layui-header{
	width:100%;
	background-color:  #E7F4FD;
}
.line_div{
	width:100%;
	height: 1px;
	background-color: #CAD9EA;
}
</style>
<script type="text/javascript">
var username='${sessionScope.user.username}';
var permissionIds='${sessionScope.user.permissionIds}';
$(function(){
	//showLeftMenuByPermission();
});

function showLeftMenuByPermission(){
	/*
	$(".projMana_first_div").css("display","none");
	$(".projList_item_li").css("display","none");

	$(".taskBagMana_first_div").css("display","none");
	$(".taskBagList_item_li").css("display","none");
	$(".taskOrder_item_li").css("display","none");
	
	$(".testResult_first_div").css("display","none");
	$(".testResult_first_div .synthetic_item_li").css("display","none");
	
	$(".sysMana_first_div").css("display","none");
	$(".perInfo_item_li").css("display","none");
	$(".user_item_li").css("display","none");
	$(".unCheckUser_item_li").css("display","none");
	$(".role_item_li").css("display","none");
	$(".permission_item_li").css("display","none");
	*/
	
	if(username=="admin"){
		$(".projMana_first_div").css("display","block");
		$(".projList_item_li").css("display","block");

		$(".taskBagMana_first_div").css("display","block");
		$(".taskBagList_item_li").css("display","block");
		$(".taskOrder_item_li").css("display","block");

		$(".testResult_first_div").css("display","block");
		$(".testResult_first_div .synthetic_item_li").css("display","block");
		
		$(".sysMana_first_div").css("display","block");
		$(".perInfo_item_li").css("display","block");
		$(".user_item_li").css("display","block");
		$(".unCheckUser_item_li").css("display","block");
		$(".role_item_li").css("display","block");
		$(".permission_item_li").css("display","block");
	}
	else{
		var permIdsArr=permissionIds.split(",");
		for(var i=0;i<permIdsArr.length;i++){
			/*
			if(qxIdsArr[i]==1){
				$(".projMana_first_div").css("display","block");
				$(".synthetic_item_li").css("display","block");
			}
			if(qxIdsArr[i]==2){
				$(".projMana_first_div").css("display","block");
				$(".shjl_item_li").css("display","block");
				
				$(".testResult_first_div").css("display","block");
				$(".testResult_first_div .synthetic_item_li").css("display","block");

				$(".lsrw_first_div").css("display","block");
				$(".taskOrder_item_li").css("display","block");
			}
			if(qxIdsArr[i]==3){
				$(".taskBagMana_first_div").css("display","block");
				$(".taskBagList_item_li").css("display","block");
			}
			if(qxIdsArr[i]==6){
				$(".projMana_first_div").css("display","block");
			}
			*/
		}
	}
}
</script>
</head>
<body>
<div class="layui-header header_div">
		<div class="layui-logo">
			<a>外包平台</a>
		</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a href="javascript:;"> 
					${sessionUsernameStr }
				</a>
			</li>
			<li class="layui-nav-item"><a href="<%=basePath%>main/exit">退出</a>
			</li>
		</ul>
	</div>

	<div class="layui-side ">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree layui-inline level-ul" lay-filter="demo">
				<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,projSearPermStr)}">
				<div class="first-level-div projMana_first_div">
					<li class="layui-nav-item first-level">
						<a>
							项目管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item projList_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>projMana/projList/list">
							&nbsp;&nbsp;&nbsp;项目列表
						</a>
					</li>
				</div>
				</c:if>
				<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,taskBagSearPermStr)||fn:contains(permissionIdsStr,taskOrderSearPermStr)}">
				<div class="first-level-div taskBagMana_first_div">
					<li class="layui-nav-item first-level">
						<a>
							任务包管理
						</a>
					</li>
					<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,taskBagSearPermStr)}">
					<div class="line_div"></div>
					<li class="layui-nav-item taskBagList_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>taskBagMana/taskBagList/list">
							&nbsp;&nbsp;&nbsp;任务包列表
						</a>
					</li>
					</c:if>
					<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,taskOrderSearPermStr)}">
					<div class="line_div"></div>
					<li class="layui-nav-item taskOrder_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>taskBagMana/taskOrder/list">
							&nbsp;&nbsp;&nbsp;任务单查询
						</a>
					</li>
					</c:if>
				</div>
				</c:if>
				<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,testResultSearPermStr)}">
				<div class="first-level-div testResult_first_div">
					<li class="layui-nav-item first-level">
						<a>
							测试结果
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item synthetic_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>testResult/synthetic/list">
							&nbsp;&nbsp;&nbsp;综合查询
						</a>
					</li>
				</div>
				</c:if>
				<div class="first-level-div sysMana_first_div">
					<li class="layui-nav-item first-level">
						<a>
							系统管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item perInfo_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>sysMana/perInfo">
							&nbsp;&nbsp;&nbsp;个人信息
						</a>
					</li>
					<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,userSearPermStr)}">
					<div class="line_div"></div>
					<li class="layui-nav-item user_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>sysMana/user/list">
							&nbsp;&nbsp;&nbsp;用户查询
						</a>
					</li>
					</c:if>
					<c:if test="${sessionUsernameStr eq usernameStr||fn:contains(permissionIdsStr,unCheckUserSearPermStr)}">
					<div class="line_div"></div>
					<li class="layui-nav-item unCheckUser_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>sysMana/unCheckUser/list">
							&nbsp;&nbsp;&nbsp;待审核用户
						</a>
					</li>
					</c:if>
					<c:if test="${sessionUsernameStr eq usernameStr}">
					<div class="line_div"></div>
					<li class="layui-nav-item role_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>sysMana/role/list">
							&nbsp;&nbsp;&nbsp;角色查询
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item permission_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>sysMana/permission/list">
							&nbsp;&nbsp;&nbsp;权限查询
						</a>
					</li>
					</c:if>
				</div>
			</ul>
		</div>
	</div>
</body>
</html>