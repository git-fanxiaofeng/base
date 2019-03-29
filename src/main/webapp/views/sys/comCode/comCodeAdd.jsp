<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>共同代码添加界面</title>
<%@include file="/core/include/head.jsp" %>		
<script type="text/javascript">

	$(document).ready(function(){
		validator = $('#form').bootstrapValidator();//ajax提交
	}); 
	
	function fncAdd() {
		rayDialogConfirm("确认保存？",function(){
			validator.bootstrapValidator('validate');//执行校验
			if($('#form').data('bootstrapValidator').isValid()){//校验通过
				$.ajax({
				     type: "post",
				     url: "${ctx}/comCode/addComCodeDo",
				     data: $('#form').serialize() ,
				     async:false,
				     success: function(){
						rayDialog("新增共同代码成功",function(){
							actCancel($('#form'), ctx + "/comCode");
						});
					 },
					 error:function(){
				    	rayDialog("新增共同代码失败");
				    }
				 });
			}
		});		
	}
	
	function fncCancel() {
		actCancel($('#form'), ctx + "/comCode");
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
				<form class="form-horizontal" id="form" name="form">
					<div class="form-group has-feedback" >
						<label class="col-sm-2 control-label">分类</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="type" name="type" 
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<a class="col-sm-2"></a>
						<label class="col-sm-2 control-label">代码</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="code" name="code" 
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group  has-feedback">
						<label class="col-sm-2 control-label">代码名</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="label" name="label" 
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<a class="col-sm-2"></a>
						<label class="col-sm-2 control-label">代码描述</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="remark" name="remark">
						</div>
					</div>
					<div class="form-group  has-feedback">
						<label class="col-sm-2 control-label">代码排序</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="sort" name="sort" 
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空" 
								data-bv-regexp="true" 
								data-bv-regexp-regexp="^[0-9][0-9]*$" 
								data-bv-regexp-message="必须为数字">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<a class="col-sm-3"></a>
						<label class="col-sm-1 control-label" >代码状态</label>
						<div class="col-sm-2" id="del" style="padding-top: 3px">
							<input type="radio" id="delFlag1" checked="checked" name="delFlag"  value="N" >可用
							<input type="radio" id="delFlag2" name="delFlag"  value="Y" >禁用
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-9">
						</div>
						<div class="col-sm-12 text-center">
							<button type="button" class="btn btn-default btn-xs btn-raycom"  onclick="fncCancel()">
							
								返&nbsp;回
							</button>
							<shiro:hasPermission name="comCode:create">
							<button type="button" class="btn btn-default btn-xs btn-raycom"onclick="fncAdd()">
							
								保&nbsp;存
							</button>
							</shiro:hasPermission>
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
