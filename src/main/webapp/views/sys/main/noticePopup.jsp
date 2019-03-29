<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告详情</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
	var editor;	
	
	$(function(){

	});	
	
	function fncClose(){
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
	}
	
	function queryNotice(){
		fncClose()
		parent.queryNotice($("#noticeId").val());
	}
	
	function queryNoticeList(){
		fncClose()
		parent.queryNoticeList();
	}
	
</script>
</head>
<body>
<div id="content" class="col-xs-12 col-sm-12" >
<div id="ajax-content">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<form class="form-horizontal" id="form"  action=""  method="post">
		<input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeId}"/>
		<div style="font-size: 2.5rem;text-align:center;bottom: 0px;margin-top: 10px;">
			${notice.noticeTitle}
		</div>
		<hr style="margin-top: 0px;margin-bottom: 10px;">
		<c:if test="${notice.displayFlag=='Y'}">
		<div style="font-size: 14px;width:850px;height:383px;overflow: auto">
			${notice.noticeContent}
		</div>
		<hr style="margin-bottom: 0px;margin-top: 10px;">
		<div class="col-sm-10 ">
			<a href="${fns:getConfig('cdn.url')}/file/download?fileId=${notice.noticePicture}" target="_blank">点击下载附件：${fns:getFileOrigName(notice.noticePicture)}</a>
		</div>
		<div class="col-sm-2 text-right">
				<a href="javascript:void(0)" onclick="queryNoticeList()">查看更多...</a>
		</div>
		</c:if>
		<c:if test="${notice.displayFlag=='N'}">
		<div style="width:800px;height:228px;">
			<a href="javascript:void(0)" onclick="queryNotice()">公告详情</a>
		</div>
			<hr style="margin-bottom: 0px;margin-top: 10px;">
		<div class="col-sm-10 ">
		</div>
		<div class="col-sm-2 text-right">
				<a href="javascript:void(0)" onclick="queryNoticeList()">查看更多...</a>
		</div>
		</c:if>
		
		<div class="form-group" style="margin-bottom: 0px;">
			<div class="col-sm-12 text-center btn-raycom-search">
			    <button type="button" class="btn btn-default btn-xs btn-raycom" style="margin-top: 2px;margin-bottom: 5px;;top: -10px;" onclick="fncClose()">
			            关&nbsp;闭
			    </button>
			    
			</div>
		</div>
	</form>
</div>
</div>
</div>
</div>
</body>
</html>
