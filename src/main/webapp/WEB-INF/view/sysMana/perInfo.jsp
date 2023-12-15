<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../inc/js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
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
.uploadBut_div{
	line-height:30px;
	text-align:center;
	color:#fff;
	background-color: #1777FF;
	border-radius:5px;
	cursor: pointer;
}
.updPwdBut_div{
	width: 90px;
	height: 30px;
	margin-top:-25px;
	margin-left: 100px;
}

.updPwd_bg_div,
.updPerInfo_bg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,.45);
	position: fixed;
	z-index: 9016;
	display:none;
}

.updPwd_div{
	width: 500px;
	height: 310px;
	margin: 250px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}

.updPerInfo_div{
	width: 800px;
	height: 610px;
	margin: 120px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}

.perInfo_div .proExp_div{
	width: 100%;
	height: 380px;
	overflow-y:scroll;
}
.proExp_ta{
	width: 500px;
	height: 200px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var mainPath=path+'main/';
var sysManaPath=path+'sysMana/';
var dialogTop=70;
var dialogLeft=20;
var perinfodNum=0;
var updpwddNum=1;
var updperinfodNum=2;
var phoneFlag,qqFlag,weixinFlag;
$(function(){
	initPerInfoDialog();//0
	
	initUpdPwdDialog();//1
	
	initUpdPerInfoDialog();//2
	
	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var perinfodpw=$("body").find(".panel.window").eq(perinfodNum);
	var perinfows=$("body").find(".window-shadow").eq(perinfodNum);
	
	var updpwddpw=$("body").find(".panel.window").eq(updpwddNum);
	var updpwddws=$("body").find(".window-shadow").eq(updpwddNum);
	
	var updperinfodpw=$("body").find(".panel.window").eq(updperinfodNum);
	var updperinfodws=$("body").find(".window-shadow").eq(updperinfodNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(perinfodpw);
	ccDiv.append(perinfows);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");

	var updpwddDiv=$("#updPwd_div");
	updpwddDiv.append(updpwddpw);
	updpwddDiv.append(updpwddws);

	var updperinfodDiv=$("#updPerInfo_div");
	updperinfodDiv.append(updperinfodpw);
	updperinfodDiv.append(updperinfodws);
}

function initPerInfoDialog(){
	dialogTop+=20;
	$("#perInfo_div").dialog({
		title:"用户信息",
		width:setFitWidthInParent("body","perInfo_div"),
		height:700,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"修改用户信息",id:"xgyhxx_but",iconCls:"icon-save",handler:function(){
        	   openUpdPerInfoDialog(true);
           }}
        ]
	});

	$("#perInfo_div table").css("width",(setFitWidthInParent("body","perInfo_div_table"))+"px");
	$("#perInfo_div table").css("magin","-100px");
	$("#perInfo_div table td").css("padding-left","20px");
	$("#perInfo_div table td").css("padding-right","20px");
	$("#perInfo_div table td").css("font-size","15px");
	$("#perInfo_div table .td1").css("width","10%");
	$("#perInfo_div table .td2").css("width","15%");
	$("#perInfo_div table .td3").css("width","60%");
	$("#perInfo_div table tr").css("border-bottom","#CAD9EA solid 1px");
	$("#perInfo_div table tr").each(function(i){
		$(this).css("height",(i==3?400:45)+"px");
	});

	$(".panel.window").eq(perinfodNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(perinfodNum).css("color","#000");
	$(".panel.window .panel-title").eq(perinfodNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(perinfodNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(perinfodNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(perinfodNum).css("border-color","#ddd");

	$("#perInfo_div #xgyhxx_but").css("left","45%");
	$("#perInfo_div #xgyhxx_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function openUpdPwdDialog(flag){
	if(flag){
		$("#updPwd_bg_div").css("display","block");
	}
	else{
		$("#updPwd_bg_div").css("display","none");
	}
}

function openUpdPerInfoDialog(flag){
	if(flag){
		$("#updPerInfo_bg_div").css("display","block");
	}
	else{
		$("#updPerInfo_bg_div").css("display","none");
	}
}

function initUpdPwdDialog(){
	$("#updPwd_dialog_div").dialog({
		title:"修改密码",
		width:setFitWidthInParent("#updPwd_div","updPwd_dialog_div"),
		height:250,
		top:5,
		left:dialogLeft,
		buttons:[
           {text:"确定",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEditPwd();
           }},
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openUpdPwdDialog(false);
           }}
        ]
	});

	$("#updPwd_dialog_div table").css("width",(setFitWidthInParent("#updPwd_div","xgmm_dialog_table"))+"px");
	$("#updPwd_dialog_div table").css("magin","-100px");
	$("#updPwd_dialog_div table td").css("padding-left","40px");
	$("#updPwd_dialog_div table td").css("padding-right","20px");
	$("#updPwd_dialog_div table td").css("font-size","15px");
	$("#updPwd_dialog_div table .td1").css("width","30%");
	$("#updPwd_dialog_div table .td2").css("width","60%");
	$("#updPwd_dialog_div table tr").css("height","45px");

	$(".panel.window").eq(updpwddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(updpwddNum).css("color","#000");
	$(".panel.window .panel-title").eq(updpwddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(updpwddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(updpwddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(updpwddNum).css("border-color","#ddd");

	$("#updPwd_dialog_div #ok_but").css("left","30%");
	$("#updPwd_dialog_div #ok_but").css("position","absolute");

	$("#updPwd_dialog_div #cancel_but").css("left","50%");
	$("#updPwd_dialog_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");

}

function initUpdPerInfoDialog(){
	$("#updPerInfo_dialog_div").dialog({
		title:"修改用户信息",
		width:setFitWidthInParent("#updPerInfo_div","updPerInfo_dialog_div"),
		height:560,
		top:5,
		left:dialogLeft,
		buttons:[
           {text:"确定",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEditYhxx();
           }},
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openUpdPerInfoDialog(false);
           }}
        ]
	});

	$("#updPerInfo_dialog_div table").css("width",(setFitWidthInParent("#updPerInfo_div","xgyhxx_dialog_table"))+"px");
	$("#updPerInfo_dialog_div table").css("magin","-100px");
	$("#updPerInfo_dialog_div table td").css("padding-left","20px");
	$("#updPerInfo_dialog_div table td").css("padding-right","20px");
	$("#updPerInfo_dialog_div table td").css("font-size","15px");
	$("#updPerInfo_dialog_div table .td1").css("width","35%");
	$("#updPerInfo_dialog_div table .td2").css("width","55%");
	$("#updPerInfo_dialog_div table tr").css("height","45px");

	$(".panel.window").eq(updperinfodNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(updperinfodNum).css("color","#000");
	$(".panel.window .panel-title").eq(updperinfodNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(updperinfodNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(updperinfodNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(updperinfodNum).css("border-color","#ddd");

	$("#updPerInfo_dialog_div #ok_but").css("left","30%");
	$("#updPerInfo_dialog_div #ok_but").css("position","absolute");

	$("#updPerInfo_dialog_div #cancel_but").css("left","50%");
	$("#updPerInfo_dialog_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");

}

function checkEditPwd(){
	if(checkPassword()){
		if(checkNewPassword()){
			if(checkNewPassword2()){
				var password = $("#newPassword").val().trim();
				$.post(sysManaPath+"updatePwdByUserId",
					{password:MD5(password).toUpperCase()},
					//{password:password},
					function(result){
						openUpdPwdDialog(false);
						var json=JSON.parse(result);
						if(json.status==1){
							$.messager.defaults.ok = "是";
						    $.messager.defaults.cancel = "否";
						    $.messager.defaults.width = 350;//更改消息框宽度
						    $.messager.confirm(
						    	"提示",
						    	"修改密码成功，重新登录生效！是否重新登录？"
						        ,function(r){    
						            if (r){    
						                location.href=mainPath+"exit";
						            }
						        }); 
						}
						else{
							$.messager.alert("提示","修改密码失败","warning");
						}
					}
				);
			}
		}
	}
}

//验证原密码
function checkPassword(){
	var flag=false;
	var username='${sessionScope.user.username}';
	var password = $("#password").val();
	if(password==null||password==""){
	  	alert("原密码不能为空");
	  	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(sysManaPath+"checkPassword",
			{password:MD5(password).toUpperCase(),username:username},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					alert(data.message);
					flag=false;
				}
			}
		,"json");
	}
	return flag;
}

//验证新密码
function checkNewPassword(){
	var password = $("#password").val();
	var newPassword = $("#newPassword").val();
	if(newPassword==null||newPassword==""){
  		alert("新密码不能为空");
  	return false;
	}
	if(newPassword==password){
		alert("新密码不能和原密码一致！");
  	return false;
	}
	else
		return true;
}

//验证确认密码
function checkNewPassword2(){
	var newPassword = $("#newPassword").val();
	var newPassword2 = $("#newPassword2").val();
	if(newPassword2==null||newPassword2==""){
  	alert("确认密码不能为空");
  	return false;
	}
	else if(newPassword!=newPassword2){
		alert("两次密码不一致！");
  	return false;
	}
	else
		return true;
}

function checkEditYhxx(){
	if(checkPhone()){
		if(checkQq()){
			if(checkWeixin()){
				if(checkEducation()){
					if(checkDeveLang()){
						if(checkProExp()){
					    	if(phoneFlag==false&qqFlag==false&weixinFlag==false){
					    		alert("电话、qq、微信号必须填写其中一个");
					    		return false
					    	}
							var id='${sessionScope.user.id}';
							var phone = $("#phone").val();
							var qq = $("#qq").val();
							var weixin = $("#weixin").val();
							var education = $("#education").val();
							var deveLang = $("#deveLang").val();
							var proExp = $("#proExp").val();
							var state='${requestScope.user.state }';
							var noCheckState='${requestScope.noCheckState }';
							var editingState='${requestScope.editingState }';
							if(state==editingState)
								state=noCheckState;
							$.post(sysManaPath+"editUser",
								{id:id,phone:phone,qq:qq,weixin:weixin,education:education,deveLang:deveLang,proExp:proExp,state:state},
								function(data){
									openUpdPerInfoDialog(false);
									if(data.message=="ok"){
										$.messager.defaults.ok = "是";
									    $.messager.defaults.cancel = "否";
									    $.messager.defaults.width = 350;//更改消息框宽度
									    $.messager.confirm(
									    	"提示",
									    	"编辑用户信息成功，重新登录生效！是否重新登录？"
									        ,function(r){    
									            if (r){    
									                location.href=mainPath+"exit";
									            }
									        }); 
									}
									else{
										$.messager.alert("提示","编辑用户信息失败","warning");
									}
								}
							);
						}
					}
				}
			}
		}
	}
}

//验证电话
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==""||phone==null)
		phoneFlag=false;
	else
		phoneFlag=true;
	return true;
}

//验证qq
function checkQq(){
	var qq = $("#qq").val();
	if(qq==""||qq==null)
		qqFlag=false;
	else
		qqFlag=true;
	return true;
}

//验证微信
function checkWeixin(){
	var weixin = $("#weixin").val();
	if(weixin==""||weixin==null)
		weixinFlag=false;
	else
		weixinFlag=true;
	return true;
}

function focusEducation(){
	var education = $("#education").val();
	if(education=="学历不能为空"){
		$("#education").val("");
		$("#education").css("color", "#555555");
	}
}

//验证学历
function checkEducation(){
	var education = $("#education").val();
	if(education==null||education==""||education=="学历不能为空"){
		$("#education").css("color","#E15748");
    	$("#education").val("学历不能为空");
    	return false;
	}
	else
		return true;
}

function focusDeveLang(){
	var deveLang = $("#deveLang").val();
	if(deveLang=="擅长的开发语言不能为空"){
		$("#deveLang").val("");
		$("#deveLang").css("color", "#555555");
	}
}

//验证擅长的开发语言
function checkDeveLang(){
	var deveLang = $("#deveLang").val();
	if(deveLang==null||deveLang==""||deveLang=="擅长的开发语言不能为空"){
		$("#deveLang").css("color","#E15748");
    	$("#deveLang").val("擅长的开发语言不能为空");
    	return false;
	}
	else
		return true;
}

function focusProExp(){
	var proExp = $("#proExp").val();
	if(proExp=="项目经历不能为空"){
		$("#proExp").val("");
		$("#proExp").css("color", "#555555");
	}
}

//验证项目经历
function checkProExp(){
	var proExp = $("#proExp").val();
	if(proExp==null||proExp==""||proExp=="项目经历不能为空"){
		$("#proExp").css("color","#E15748");
    	$("#proExp").val("项目经历不能为空");
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
	case "perInfo_div":
		space=340;
		break;
	case "perInfo_div_table":
	case "panel_window":
		space=355;
		break;
	case "updPwd_dialog_div":
	case "updPerInfo_dialog_div":
		space=50;
		break;
	case "xgmm_dialog_table":
	case "xgyhxx_dialog_table":
		space=68;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../inc/side.jsp"%>
	<div class="center_con_div" id="center_con_div">
		<div class="page_location_div">系统管理-用户信息</div>
		
		<div id="perInfo_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
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
					qq
				</td>
				<td class="td2">
					${requestScope.user.qq }
				</td>
				<td class="td1" align="right">
					密码
				</td>
				<td class="td3">
					已设置
					<div class="uploadBut_div updPwdBut_div" onclick="openUpdPwdDialog(true)">修改密码</div>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					微信
				</td>
				<td class="td2">
					${requestScope.user.weixin }
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
					项目经历
				</td>
				<td class="td3">
					<div class="proExp_div">${requestScope.user.proExp }</div>
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
					状态
				</td>
				<td class="td3">
					<c:choose>
						<c:when test="${requestScope.user.state eq requestScope.noCheckState }">${requestScope.noCheckStateName }</c:when>
						<c:when test="${requestScope.user.state eq requestScope.checkedState }">${requestScope.checkedStateName }</c:when>
						<c:when test="${requestScope.user.state eq requestScope.editingState }">${requestScope.editingStateName }</c:when>
					</c:choose>
				</td>
			  </tr>
			</table>
			</form>
		</div>

		<%@include file="../inc/foot.jsp"%>
	</div>
	
	<div class="updPwd_bg_div" id="updPwd_bg_div">
		<div class="updPwd_div" id="updPwd_div">
			<div class="updPwd_dialog_div" id="updPwd_dialog_div">
				<table>
				  <tr>
					<td class="td1" align="right">
						原密码
					</td>
					<td class="td2">
						<input type="password" id="password" placeholder="原密码"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						新密码
					</td>
					<td class="td2">
						<input type="password" id="newPassword" placeholder="新密码"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						确认密码
					</td>
					<td class="td2">
						<input type="password" id="newPassword2" placeholder="确认密码"/>
					</td>
				  </tr>
				</table>
			</div>
		</div>
	</div>
	
	<div class="updPerInfo_bg_div" id="updPerInfo_bg_div">
		<div class="updPerInfo_div" id="updPerInfo_div">
			<div class="updPerInfo_dialog_div" id="updPerInfo_dialog_div">
				<table>
				  <tr>
					<td class="td1" align="right">
						电话
					</td>
					<td class="td2">
						<input type="text" id="phone" value="${requestScope.user.phone }" placeholder="请输入电话" onblur="checkPhone()"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						qq
					</td>
					<td class="td2">
						<input type="text" id="qq" value="${requestScope.user.qq }" placeholder="请输入qq" onblur="checkQq()"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						微信
					</td>
					<td class="td2">
						<input type="text" id="weixin" value="${requestScope.user.weixin }" placeholder="请输入微信" onblur="checkWeixin()"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						学历
					</td>
					<td class="td2">
						<input type="text" id="education" value="${requestScope.user.education }" placeholder="请输入学历" onfocus="focusEducation()" onblur="checkEducation()"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						擅长的开发语言
					</td>
					<td class="td2">
						<input type="text" id="deveLang" value="${requestScope.user.deveLang }" placeholder="请输入擅长的开发语言" onfocus="focusDeveLang()" onblur="checkDeveLang()"/>
					</td>
				  </tr>
				  <tr>
					<td class="td1" align="right">
						项目经历
					</td>
					<td class="td2">
						<textarea type="text" class="proExp_ta" id="proExp" placeholder="请输入项目经历" onfocus="focusProExp()" onblur="checkProExp()">${requestScope.user.proExp }</textarea>
					</td>
				  </tr>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>