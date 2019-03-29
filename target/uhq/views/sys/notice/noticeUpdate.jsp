<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告详情</title>
<%@include file="/core/include/head.jsp" %>	
<link rel="stylesheet" href="${ctxStatic}/css/default/default.css">
<link rel="stylesheet" href="${ctxStatic}/plugins/code/prettify.css">
<script src="${ctxStatic}/plugins/kindeditor/kindeditor-all.js"></script>
<script src="${ctxStatic}/plugins/kindeditor/lang/zh-CN.js"></script>
<script type="text/javascript">
	var editor;	
	
	$(function(){
		$("#startDate").rayDatePicker();
		$("#endDate").rayDatePicker();
		$('#form').bootstrapValidator();//表单提交时使用
	
		KindEditor.ready(function(K) {
			editor = K.create('textarea[name="noticeContent"]',{
		        uploadJson: '${ctxStatic}/plugins/kindeditor/jsp/upload_json.jsp',  
		        fileManagerJson: '${ctxStatic}/plugins/kindeditor/jsp/file_manager_json.jsp',  
		        allowFileManager: true,  
		        //上传文件后执行的回调函数,获取上传图片的路径  
		        afterUpload: function (url) {
		            var a = $("#uppics").val();
		            if (a.length > 0) {
		                $("#uppics").val(a + "," + url);
		            } else {
		                $("#uppics").val(url);
		            }
		        },
		        afterCreate: function () {  
		            this.sync();  
		        },
		        afterBlur: function () {   
		            this.sync();  
		        },
				items : ['source','fontname','fontsize','forecolor','preview','selectall','justifyleft','justifycenter','justifyright','emoticons','link','unlink','image'],
				afterChange : function() {
				this.sync(); 
				} 
				});
		});
	});	
	
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
				<form class="form-horizontal" id="form"  action="${ctx}/sys/notice/createNoticeDo"  method="post"
					data-bv-message="数据有误"
				    data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
				    data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
				    data-bv-feedbackicons-validating="glyphicon glyphicon-refresh" >
					<input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeId}">
					<div class="form-group has-feedback">
						<label class="col-sm-2 control-label">公告标题</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" value="${notice.noticeTitle}" id="noticeTitle" name="noticeTitle" readonly="readonly" placeholder="parentIds" data-toggle="tooltip" data-placement="bottom" title="公告标题"
								data-bv-notempty="true"
              					data-bv-notempty-message="公告标题不能为空">
              				<!--<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>-->
						</div>
					</div>
					<div class="form-group"  style="pointer-events: none">
						<label class="col-sm-2 control-label">开始日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="${notice.startDate}" id="startDate" name="startDate"  placeholder="开始日期" readonly="readonly"  data-toggle="tooltip" data-placement="bottom" title="开始日期">
						</div>
						<label class="col-sm-1 control-label">结束日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="${notice.endDate}" id="endDate" name="endDate" placeholder="结束日期"  readonly="readonly"  data-toggle="tooltip" data-placement="bottom" title="结束日期">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">类型</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="${notice.noticeType}" id="noticeType" name="noticeType"  placeholder="类型" readonly="readonly"  data-toggle="tooltip" data-placement="bottom" title="类型">
						</div>
						<label class="col-sm-1 control-label">公告分类</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="${notice.noticeClassify}" id="noticeClassify" name="noticeClassify" placeholder="公告分类"  readonly="readonly"  data-toggle="tooltip" data-placement="bottom" title="公告分类">
						</div>
					</div>
					<div class="form-group"  style="pointer-events: none">
						<label class="col-sm-2 control-label">公告内容</label>
						<div class="col-sm-9">
							<textarea id="noticeContent" name="noticeContent" cols="142" rows="8" disabled="disabled" >${notice.noticeContent}</textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">附件</label>
						<div class="col-sm-4">
							<a href="${fns:getConfig('cdn.url')}/file/download?fileId=${notice.noticePicture}" target="_blank">${fns:getFileOrigName(notice.noticePicture)}</a>
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
