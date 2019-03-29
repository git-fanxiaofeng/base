<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>医院添加界面</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
	//Ajax校验
	$(document).ready(function() {
		validator = $('#form').bootstrapValidator();
   	});
   
	//新增医院
	function fncAdd(){
		rayDialogConfirm("确认保存？",function(){
			validator.bootstrapValidator('validate');
			if($("#form").data('bootstrapValidator').isValid()){
				$.ajax({
					url:ctx+"/hospital/createHospitalDo",
					type: "POST",
					data:$('#form').serialize(), 
					success: function(){
						rayDialog("新增医院成功");
						actCancel($('#form'), ctx + "/hospital");
					},
					error:function(){
						rayDialog("新增医院失败");
					}
				});
			}
		});
	}
		
	function fncCancel(){
		rayDialogConfirm("是否放弃本次编辑并返回？",function(){
			actCancel($('#form'), ctx+"/hospital");
		});
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
				<form class="form-horizontal" id="form" name="form" action="${ctx}/hospital/createHospitalDo"  method="post" >
					<div class="form-group has-feedback" >
						<label class="col-sm-2 control-label">医院名称</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="orgName" name="orgName" data-placement="bottom" 
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空" >
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-2 control-label">地址</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="address" name="address" data-placement="bottom">
						</div>
					</div>
					<div class="form-group has-feedback" >
						<label class="col-sm-2 control-label">固定电话</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="tel" name="tel" maxLength="12"
								data-bv-regexp="true"
								data-bv-regexp-regexp="^\d{3}-\d{8}|\d{4}-\d{7}$" 
								data-bv-regexp-message="请按照xxx-xxxxxxxx  或xxxx-xxxxxxx格式输入电话号码">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-2 control-label">邮政编码</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="postcode" name="postcode"  data-placement="bottom" maxLength="6"
								data-bv-regexp="true"
								data-bv-regexp-regexp="^[0-9]\d{5}(?!\d)$" 
								data-bv-regexp-message="请输入6位有效数字邮政编码">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group has-feedback" >
						<label class="col-sm-2 control-label" style="padding-left: 0px">委托联系人</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="contact" name="contact" >
						</div>
						<label class="col-sm-2 control-label">传真</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="fax" name="fax" data-placement="bottom" maxLength="12"
								data-bv-regexp="true"
								data-bv-regexp-regexp="^\d{3}-\d{8}|\d{4}-\d{7}$" 
								data-bv-regexp-message="请按照xxx-xxxxxxxx  或xxxx-xxxxxxx格式输入传真号码">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group has-feedback" >
						
						<label class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="email" name="email"
								data-bv-emailaddress="true"
								data-bv-emailaddress-message="输入不是一个有效的邮箱格式">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-2 control-label">网址</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="website" name="website" placeholder=""
								data-bv-regexp="true"
								data-bv-regexp-regexp="^(((ht|f)tp(s?))\://)?(www.|[a-zA-Z].)[a-zA-Z0-9]+\.[a-zA-Z]+(\.[a-zA-Z]+)*"
								data-bv-regexp-message="请按照http://www.xxx.xxx...或www.xxx.xxx...格式输入网址"
								data-bv-stringlength="true"
								data-bv-stringlength-max="30"
								data-bv-stringlength-message="该字段输入不能超过30">
       						<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group has-feedback">
						
						<label class="col-sm-2 control-label">备注</label>
						<div class="col-sm-4">
							<textarea class="form-control" style="height: 50px;" rows="4" cols="120" id="remarks" name="remarks" maxlength="160"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12 text-center btn-raycom-search">
							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncCancel()">
								返&nbsp;&nbsp;回
  							</button>
							<shiro:hasPermission name="hospital:create">
   							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncAdd()">
								保&nbsp;&nbsp;存
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
