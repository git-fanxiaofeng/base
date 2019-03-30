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
<link rel="stylesheet" href="${ctxStatic}/plugins/kindeditor/plugins/code/prettify.css">
<script src="${ctxStatic}/plugins/kindeditor/kindeditor-all.js"></script>
<script src="${ctxStatic}/plugins/kindeditor/lang/zh-CN.js"></script>
<script type="text/javascript">
	var editor;	
	
	$(function(){
		$("#startDate").rayDatePicker();
		$("#endDate").rayDatePicker();
		$(".js-example-basic-single").select2();
		$('#form').bootstrapValidator();//表单提交时使用
		$('#noticeUpload').rayfileupload('notice');  
		$('#noticeUpload').rayfileupload('noticePicture','','Y');
	
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
	
	function fncAdd(){
		if(new Date($('#endDate').val()) < new Date($('#startDate').val())){
			rayDialog('开始时间不能大于结束时间！');
			return;
		}
		rayDialogConfirm("确认保存？",function(){
			editor.sync();
			//actSubmit($('#form'), ctx+"/notice/updateNoticeDo"); 
			$.post(
					ctx+"/notice/updateNoticeDo",
					$('#form').serialize(),
					function(data){
						if(data == 'ok'){
							return rayDialog("修改成功！",function(){
								actCancel($('#form'), ctx+"/notice/list");
							});						
						}
						actCancel($('#form'), ctx+"/notice/list");
					}
				);
		});
	}
	
	function fncCancel(){
		rayDialogConfirm("是否放弃本次编辑？",function(){
			actCancel($('#form'), ctx+"/notice/list");//方法提交不需要校验
		});
	}
	
	//更改发布公告系统控制类型和分类单选
	function changeSys(){
		var sys = $('#publishSys option:checked').val();
		if(sys == '01'){
			$('#type').hide();
			$('#classify').hide();
		}
		if(sys == '02'){
			$('#type').show();
			$('#classify').show();
		}
	}
	
	//更改类型控制分类显隐
	function changeType(){
		var type = $('#noticeType option:checked').val();
		if(type == '01'){//公告
			$('#classify').show();
			$('#picture').show();
		}
		if(type == '02'){
			$('#classify').hide();
			$('#picture').hide();
			$('#noticeUpload').val('');
			$('#noticePicture').val('');
			$('#uploadContent').remove();
			
		}
		if(type == '03'){
			$('#classify').hide();
			$('#picture').show();
		}
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
				<form class="form-horizontal" id="form"  action="${ctx}/notice/createNoticeDo"  method="post"
					data-bv-message="数据有误"
				    data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
				    data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
				    data-bv-feedbackicons-validating="glyphicon glyphicon-refresh" >
					<input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeId}">
					<div class="form-group has-feedback">
						<label class="col-sm-2 control-label">公告标题</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" value="${notice.noticeTitle}" id="noticeTitle" name="noticeTitle" placeholder="parentIds" data-toggle="tooltip" data-placement="bottom" title="公告标题"
								data-bv-notempty="true"
              					data-bv-notempty-message="公告标题不能为空">
              				<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">开始日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" readonly value="${notice.startDate}" id="startDate" name="startDate"  placeholder="开始日期"   data-toggle="tooltip" data-placement="bottom" title="开始日期"
							data-bv-regexp="true"
							data-bv-regexp-regexp="^[0-9]{4}-[0-1]?[0-9]{1}-[0-3]?[0-9]{1}$"
							data-bv-regexp-message="日期格式为:XXXX-XX-XX"/>
						</div>
						<label class="col-sm-1 control-label">结束日期</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" readonly value="${notice.endDate}" id="endDate" name="endDate" placeholder="结束日期"    data-toggle="tooltip" data-placement="bottom" title="结束日期"
							data-bv-regexp="true"
							data-bv-regexp-regexp="^[0-9]{4}-[0-1]?[0-9]{1}-[0-3]?[0-9]{1}$"
							data-bv-regexp-message="日期格式为:XXXX-XX-XX"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">公告内容</label>
						<div class="col-sm-9">
							<textarea id="noticeContent" name="noticeContent" cols="128.9" rows="8" >${notice.noticeContent}</textarea>
						</div>
					</div>
					<div class="form-group" id="picture" <c:if test="${notice.publishSys == '02' && notice.noticeType == '02'}">style="display:none"</c:if>>
						<label class="col-sm-2 control-label">上传附件</label>
						<div class="col-sm-4">
							<input id="noticeUpload" name="file"  type="file" >
							<input type="hidden" class="form-control" id="noticePicture" name="noticePicture" value="${notice.noticePicture}">
							<c:if test="${notice.noticePicture!=null && notice.noticePicture!=''}">
								<a href="${fns:getConfig('cdn.url')}/file/download?fileId=${notice.noticePicture}" target="_blank">${fns:getFileOrigName(notice.noticePicture)}</a>
							</c:if>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12 text-center btn-raycom-search">
						        <button type="button" class="btn btn-default btn-xs btn-raycom"  onclick="fncCancel()">
									返&nbsp;回
								</button>	
								<c:if test="${notice.extNoticeId == '' || notice.extNoticeId == null}">
								    <shiro:hasPermission name="notice:create">
									    <button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncAdd();">
										       保&nbsp;存
									    </button>
								    </shiro:hasPermission>
							    </c:if>					
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
