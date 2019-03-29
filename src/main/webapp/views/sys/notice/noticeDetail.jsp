<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<%@page import="io.raycom.core.collection.RData"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告详情</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
	
	function fncCancel(){
		actCancel($('#form'), ctx+"/sys/notice/list");//方法提交不需要校验
	}
	
</script>
</head>
<body>
<div id="content" class="col-xs-12 col-sm-12" >
<div id="ajax-content">
<rt:navigation/>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
				<%@include file="/core/include/boxHead.jsp" %>	
			<div class="box-content">
				<form class="form-horizontal" id="form"  action=""  method="post">
					<input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeId}">
					<legend class="text-center ">${notice.noticeTitle}</legend>
					<div class="form-group">
						<div class="col-sm-12">
							${notice.noticeContent}
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-12 text-center btn-raycom-search">
						    <button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncCancel()">
						             返&nbsp;回
						    </button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>
