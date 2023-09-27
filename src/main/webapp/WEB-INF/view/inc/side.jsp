<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
var qxIds='${sessionScope.yongHu.qxIds}';
$(function(){
	showLeftMenuByQx();
});

function showLeftMenuByQx(){
	$(".xmgl_first_div").css("display","none");
	$(".xmlb_item_li").css("display","none");

	$(".rwbgl_first_div").css("display","none");
	$(".rwblb_item_li").css("display","none");
	
	$(".csjg_first_div").css("display","none");
	$(".csjg_first_div .zhcx_item_li").css("display","none");
	
	$(".lsrw_first_div").css("display","none");
	$(".rwdlb_item_li").css("display","none");

	$(".xtgl_first_div").css("display","none");
	$(".yhcx_item_li").css("display","none");
	$(".dshyh_item_li").css("display","none");
	$(".qxcx_item_li").css("display","none");
	
	if(username=="admin"){
		$(".xmgl_first_div").css("display","block");
		$(".xmlb_item_li").css("display","block");

		$(".rwbgl_first_div").css("display","block");
		$(".rwblb_item_li").css("display","block");

		$(".csjg_first_div").css("display","block");
		$(".csjg_first_div .zhcx_item_li").css("display","block");
		
		$(".lsrw_first_div").css("display","block");
		$(".rwdlb_item_li").css("display","block");
		
		$(".xtgl_first_div").css("display","block");
		$(".yhcx_item_li").css("display","block");
		$(".dshyh_item_li").css("display","block");
		$(".qxcx_item_li").css("display","block");
	}
	else{
		var qxIdsArr=qxIds.split(",");
		for(var i=0;i<qxIdsArr.length;i++){
			if(qxIdsArr[i]==1){
				$(".xmgl_first_div").css("display","block");
				$(".zhcx_item_li").css("display","block");
			}
			if(qxIdsArr[i]==2){
				$(".xmgl_first_div").css("display","block");
				$(".shjl_item_li").css("display","block");
				
				$(".csjg_first_div").css("display","block");
				$(".csjg_first_div .zhcx_item_li").css("display","block");

				$(".lsrw_first_div").css("display","block");
				$(".rwdlb_item_li").css("display","block");
			}
			if(qxIdsArr[i]==3){
				$(".rwbgl_first_div").css("display","block");
				$(".rwblb_item_li").css("display","block");
			}
			if(qxIdsArr[i]==6){
				$(".xmgl_first_div").css("display","block");
			}
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
					${sessionScope.user.username }
				</a>
			</li>
			<li class="layui-nav-item"><a href="<%=basePath%>main/exit">退出</a>
			</li>
		</ul>
	</div>

	<div class="layui-side ">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree layui-inline level-ul" lay-filter="demo">
				<div class="first-level-div xmgl_first_div">
					<li class="layui-nav-item first-level">
						<a>
							项目管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item xmlb_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>projMana/projList/list">
							&nbsp;&nbsp;&nbsp;项目列表
						</a>
					</li>
				</div>
				<div class="first-level-div rwbgl_first_div">
					<li class="layui-nav-item first-level">
						<a>
							任务包管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item rwblb_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>taskBagMana/taskBagList/list">
							&nbsp;&nbsp;&nbsp;任务包列表
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item rwdlb_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>taskBagMana/taskOrder/list">
							&nbsp;&nbsp;&nbsp;任务单查询
						</a>
					</li>
				</div>
				<div class="first-level-div csjg_first_div">
					<li class="layui-nav-item first-level">
						<a>
							测试结果
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item zhcx_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>wzgl/wzlx/list">
							&nbsp;&nbsp;&nbsp;综合查询
						</a>
					</li>
				</div>
				<div class="first-level-div xtgl_first_div">
					<li class="layui-nav-item first-level">
						<a>
							系统管理
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item yhcx_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>xtgl/yhcx/list">
							&nbsp;&nbsp;&nbsp;用户查询
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item dshyh_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>xtgl/dshyh/list">
							&nbsp;&nbsp;&nbsp;待审核用户
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item jscx_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>xtgl/jscx/list">
							&nbsp;&nbsp;&nbsp;角色查询
						</a>
					</li>
					<div class="line_div"></div>
					<li class="layui-nav-item qxcx_item_li">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/image/ico_3.gif" />
						<a href="<%=basePath%>xtgl/qxcx/list">
							&nbsp;&nbsp;&nbsp;权限查询
						</a>
					</li>
				</div>
			</ul>
		</div>
	</div>
</body>
</html>