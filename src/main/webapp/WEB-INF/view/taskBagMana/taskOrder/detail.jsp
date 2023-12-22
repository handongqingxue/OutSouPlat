<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../../inc/js.jsp"%>
<c:set var="uploadCodePermStr" value=",${requestScope.uploadCodePerm},"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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
.downloadBut_div{
	line-height:30px;
	text-align:center;
	color:#fff;
	background-color: #1777FF;
	border-radius:5px;
	cursor: pointer;
}
.dlCodeBut_div,.dlAnnexBut_div{
	width: 80px;
	height: 30px;
	margin-top: 10px;
}

.upload_code_bg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,.45);
	position: fixed;
	z-index: 9016;
	display:none;
}

.upload_code_div{
	width: 500px;
	height: 210px;
	margin: 250px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}
</style>
<script type="text/javascript">
var scheme='<%=scheme %>';
var serverName='<%=serverName %>';
var serverPort='<%=serverPort %>';
var path='<%=basePath %>';
var projManaPath=path+'projMana/';
var taskBagManaPath=path+'taskBagMana/';

var sessionUsernameStr='${sessionUsernameStr}';
var usernameStr='${usernameStr}';
var permissionIdsStr='${permissionIdsStr}';
var uploadCodePermStr='${uploadCodePermStr}';

var showUploadCodeOptionBut=false;

var localPlace;
var remotePlace;

var codeType;
var annexType;

var dialogTop=70;
var dialogLeft=20;
var ddNum=0;
var ucdNum=1;

var okBut;
$(function(){
	initFilePlaceVar();
	initFileTypeVar();
	showCompontByPermission();
	
	initDetailDialog();//0
	initUploadCodeDialog();//1

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ddpw=$("body").find(".panel.window").eq(ddNum);
	var ddws=$("body").find(".window-shadow").eq(ddNum);
	
	var ucdpw=$("body").find(".panel.window").eq(ucdNum);
	var ucdws=$("body").find(".window-shadow").eq(ucdNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ddpw);
	ccDiv.append(ddws);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");

	var ucdDiv=$("#upload_code_div");
	ucdDiv.append(ucdpw);
	ucdDiv.append(ucdws);
}

function showCompontByPermission(){
	if(sessionUsernameStr==usernameStr||permissionIdsStr.indexOf(uploadCodePermStr)!=-1)
		showUploadCodeOptionBut=true;
}

function initFilePlaceVar(){
	localPlace=parseInt('${requestScope.localPlace}');
	remotePlace=parseInt('${requestScope.remotePlace}');
}

function initFileTypeVar(){
	codeType=parseInt('${requestScope.codeType}');
	annexType=parseInt('${requestScope.annexType}');
}

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"任务单信息",
		width:setFitWidthInParent("body","detail_div"),
		height:500,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"上传代码",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   var id=$("#detail_div #id").val();
        	   openUploadCodeDialog(true,id);
           }}
        ]
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
		var height;
		if(i==3||i==4)
			height=100;
		else
			height=45;
		$(this).css("height",height+"px");
	});

	$(".panel.window").eq(ddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ddNum).css("color","#000");
	$(".panel.window .panel-title").eq(ddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ddNum).css("border-color","#ddd");

	okBut=$("#detail_div #ok_but");
	okBut.css("left","45%");
	okBut.css("position","absolute");
	if(showUploadCodeOptionBut){
		okBut.show();
	}
	else{
		okBut.hide();
	}
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function initUploadCodeDialog(){
	$("#upload_code_dialog_div").dialog({
		title:"上传代码文件",
		width:setFitWidthInParent("#upload_code_div","upload_code_dialog_div"),
		height:150,
		top:5,
		left:dialogLeft,
		buttons:[
           {text:"确定",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   uploadCode();
           }},
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openUploadCodeDialog(false,"");
           }}
        ]
	});

	$("#upload_code_dialog_div table").css("width",(setFitWidthInParent("#upload_code_div","upload_code_dialog_table"))+"px");
	$("#upload_code_dialog_div table").css("magin","-100px");
	$("#upload_code_dialog_div table td").css("padding-left","0px");
	$("#upload_code_dialog_div table td").css("padding-right","20px");
	$("#upload_code_dialog_div table td").css("font-size","15px");
	$("#upload_code_dialog_div table .td1").css("width","50%");
	$("#upload_code_dialog_div table .td2").css("width","50%");
	$("#upload_code_dialog_div table tr").css("height","45px");

	$(".panel.window").eq(ucdNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ucdNum).css("color","#000");
	$(".panel.window .panel-title").eq(ucdNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ucdNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ucdNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ucdNum).css("border-color","#ddd");

	$("#upload_code_dialog_div #ok_but").css("left","30%");
	$("#upload_code_dialog_div #ok_but").css("position","absolute");

	$("#upload_code_dialog_div #cancel_but").css("left","50%");
	$("#upload_code_dialog_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function openUploadCodeDialog(flag,id){
	if(flag){
		$("#upload_code_bg_div").css("display","block");
	}
	else{
		$("#upload_code_bg_div").css("display","none");
	}
	$("#upload_code_div #id").val(id);
}

function changeLBOptionStyle(lb,flag){
	if(flag){
		if(lb==okBut){
			lb.linkbutton({text:"上传中",iconCls:"icon-save",disabled:true});
		}
	}
	else{
		if(lb==okBut){
			lb.linkbutton({text:"确定",iconCls:"icon-ok",disabled:false});
		}
	}
}

function uploadCode(){
	changeLBOptionStyle(okBut,true);
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:taskBagManaPath+"uploadTaskOrderCodeFile",
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

function download(filePlace,fileType){
	var realPath=scheme+":/"+serverName+":"+serverPort;
	if(fileType==codeType)
		realPath+='${requestScope.taskOrder.codeFileUrl }';
	else if(fileType==annexType)
		realPath+='${requestScope.taskOrder.annexFileUrl }';
	//location.href=taskBagManaPath+"download?place=2&realPath=http://192.168.1.102:8080//OutSouPlat//upload//TaskBag//annex//3H3fcrenzheshengui3wudiban.rar"
	location.href=taskBagManaPath+"download?place="+filePlace+"&realPath="+realPath;
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
	case "upload_code_dialog_div":
		space=50;
		break;
	case "upload_code_dialog_table":
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
	<%@include file="../../inc/side.jsp"%>
	<div class="center_con_div" id="center_con_div">
		<div class="page_location_div">任务单查询-任务单详情</div>
		
		<div id="detail_div">
			<input type="hidden" id="id" name="id" value="${requestScope.taskOrder.id }"/>
			<input type="hidden" id="uploadUserId" name="uploadUserId" value="${sessionScope.user.id }"/>
			<table>
			  <tr>
				<td class="td1" align="right">
					任务单号
				</td>
				<td class="td2">
					${requestScope.taskOrder.no }
				</td>
				<td class="td1" align="right">
					任务包
				</td>
				<td class="td2">
					${requestScope.taskOrder.taskBagName }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					接单人
				</td>
				<td class="td2">
					${requestScope.taskOrder.orderUserName }
				</td>
				<td class="td1" align="right">
					接单时间
				</td>
				<td class="td2">
					${requestScope.taskOrder.createTime }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					审核人
				</td>
				<td class="td2">
					${requestScope.taskOrder.agreeUserName }
				</td>
				<td class="td1" align="right">
					完成时间
				</td>
				<td class="td2">
					${requestScope.taskOrder.finishTime }
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					代码文件大小
				</td>
				<td class="td2">
					${requestScope.taskOrder.codeFileSize }
				</td>
				<td class="td1" align="right">
					代码文件路径
				</td>
				<td class="td2">
					<c:choose>
						<c:when test="${requestScope.taskOrder.codeFileUrl eq null }">未上传</c:when>
						<c:otherwise>
							${requestScope.taskOrder.codeFileUrl }
							<div class="downloadBut_div dlCodeBut_div" onclick="download(${requestScope.remotePlace},${requestScope.codeType})">下载</div>
						</c:otherwise>
					</c:choose>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					附件文件大小
				</td>
				<td class="td2">
					${requestScope.taskOrder.annexFileSize }
				</td>
				<td class="td1" align="right">
					附件文件路径
				</td>
				<td class="td2">
					<c:choose>
						<c:when test="${requestScope.taskOrder.annexFileUrl eq null }">未上传</c:when>
						<c:otherwise>
							${requestScope.taskOrder.annexFileUrl }
							<div class="downloadBut_div dlAnnexBut_div" onclick="download(${requestScope.remotePlace},${requestScope.annexType})">下载</div>
						</c:otherwise>
					</c:choose>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					状态
				</td>
				<td class="td2">
					<!-- https://blog.csdn.net/u012730333/article/details/42081827 -->
					<c:choose>
						<c:when test="${requestScope.taskOrder.state eq requestScope.developingState }">${requestScope.developingStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.unTestState }">${requestScope.unTestStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.testingState }">${requestScope.testingStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.reworkingState }">${requestScope.reworkingStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.unPayState }">${requestScope.unPayStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.paidState }">${requestScope.paidStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.finishedState }">${requestScope.finishedStateName}</c:when>
						<c:when test="${requestScope.taskOrder.state eq requestScope.discardedState }">${requestScope.discardedStateName}</c:when>
					</c:choose>
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
	
	<div class="upload_code_bg_div" id="upload_code_bg_div">
		<div class="upload_code_div" id="upload_code_div">
			<div class="upload_code_dialog_div" id="upload_code_dialog_div">
			<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
				<input type="hidden" id="id" name="id"/>
				<table>
				  <tr>
					<td class="td1" align="right">
						选择代码文件
					</td>
					<td class="td2">
						<input type="file" id="code_file" name="code_file"/>
					</td>
				  </tr>
				</table>
			</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>