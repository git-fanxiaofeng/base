<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>供应商注册</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="author" content="http://raycom.io/"/>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-store">
<meta name=”renderer” content=”webkit” />
<meta name="description" content="description">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<link href="${ctxStatic}/plugins/bootstrap/bootstrap.css" rel="stylesheet">
<link href="${ctxStatic}/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<link href="${ctxStatic}/plugins/font-Awesome-5.0.0/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctxStatic}/css/raycom.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
		<script src="http://getbootstrap.com/docs-assets/js/html5shiv.js"></script>
		<script src="http://getbootstrap.com/docs-assets/js/respond.min.js"></script>
<![endif]-->
<!--End Container-->
<!-- jQuery (necessary for Bootstrap's JavaScript ${ctxStatic}/plugins) -->
<!--<script src="http://code.jquery.com/jquery.js"></script>-->
<script src="${ctxStatic}/plugins/jquery/jquery.min.js"></script>
<script src="${ctxStatic}/plugins/bootstrap/bootstrap.min.js"></script>

<script type="text/javascript" src="${ctxStatic}/plugins/layer-v3.1.1/layer.js"></script>
<script src="${ctxStatic}/plugins/bootstrapvalidator/bootstrapValidator.min.js"></script> 
<script src="${ctxStatic}/js/common/raycom-layer.js"></script>
<script src="${ctxStatic}/js/raycom.js"></script>
<script type="text/javascript">var ctx = '${ctx}', ctxFront = '${ctxFront}', ctxStatic='${ctxStatic}', ctxCdn='${fns:getConfig("cdn.url")}';</script>

<style type="text/css">
	body{
		text-align: center;
	}
</style>
<script type="text/javascript">
	var validator;
	$(function(){
		validator = $('#form').bootstrapValidator();
	})
		
	function fncRegister(){//注册
		validator.bootstrapValidator('validate');//执行校验
		rayDialogConfirm("是否提交注册信息？",function(){
			if($(form).data('bootstrapValidator').isValid()){//校验通过
				$.ajax({
					type:"POST",
					url:  ctxFront+"/sys/register/createRegisterDo",
					data:$("#form").serialize(),
					async:true,
					success:function(msg){
						if(msg=="true"){
							rayDialogConfirm("注册成功,是否进入登录页面？",function(){
								window.location.href=ctx+"/login";
							});
						}else{
							rayDialog(msg);
						}
					}
				});
			}
		});
	}
	
	function fncCancel() {//返回
		rayDialogConfirm("是否要关闭",function(){
			try{
				parent.closeFrame();
			}catch(err){
				//科室库首页的注册关闭用，在UPS中体现不出来，主要是跨域操作。使用h5的消息机制实现跨域通知
				parent.window.postMessage('testChildPost','*');
			}
		});
	}
</script>	
</head>
<body>
<div id="content" class="col-xs-12 col-sm-12" style="height:465px" >
	<div id="ajax-content">
<div class="row">
<div class="col-xs-12 col-sm-12">
	<div class="box" style="margin-top: 15px;">
			<div class="box-content">
				<div style="height:40px"><h3>供应商注册</h3></div>
				<form class="form-horizontal" id="form" method="post"
					data-bv-message="数据有误"
					data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
					data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
					data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
					<div style="width:70%;margin:0 auto;">
						<div class="form-group">
							<label class="col-sm-3 control-label" style="font-size:16px;">供应商名称</label>
							<div class="col-sm-7" >
								<input type="text" id="vendorName" name="vendorName" class="form-control"  style=" height: 30px;font-size:18px;" placeholder="供应商名称" data-query="yes"  data-toggle="tooltip" data-placement="bottom" title="企业工商注册名称"
									data-bv-notempty="true"
									data-bv-notempty-message="该字段不能为空">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label " style="font-size:16px;">登录账号</label>
							<div class="col-sm-7">
								<input type="text" id="loginName" name="loginName" class="form-control "  style=" height: 30px;font-size:18px;" placeholder="登录账号"  data-query="yes" data-toggle="tooltip" data-placement="bottom" title="登录账号"
									data-bv-notempty="true"
									data-bv-notempty-message="登录账号必输！"
									data-bv-regexp="true"
								    data-bv-regexp-regexp="^\w+$"
								    data-bv-regexp-message="用户名只能以字母和数字组成"
								    data-bv-stringlength="true"
									data-bv-stringlength-max="20">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label " style="font-size:16px;">登陆密码</label>
							<div class="col-sm-7">
								<input type="password" id="password" name="password" class="form-control" placeholder="密码"  style=" height: 30px;font-size:18px;" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="密码"
									data-bv-stringlength="true"
									data-bv-stringlength-min="6"
									data-bv-stringlength-max="30"
									data-bv-stringlength-message="该字段输入长度在6和30之间"
									data-bv-notempty="true"
									data-bv-notempty-message="该字段不能为空">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label " style="font-size:16px;">确认密码</label>
							<div class="col-sm-7">
								<input type="password" id="repeatPsd" name="repeatPsd" class="form-control" placeholder="确认密码"  style=" height: 30px;font-size:18px;" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="确认密码"
									data-bv-identical="true"
									data-bv-identical-field="password"
									data-bv-identical-message="两次输入密码不一致"
									data-bv-notempty="true"
									data-bv-notempty-message="该字段不能为空">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" style="font-size:16px;">用户姓名</label>
							<div class="col-sm-7">
								<input type="text" id="userName" name="userName" class="form-control"  style=" height: 30px;font-size:18px;" placeholder="管理员姓名"
								data-bv-stringlength="true" data-bv-stringlength-max="10" data-bv-stringlength-message="字段长度不得超过5"
									data-bv-notempty="true"
									data-bv-notempty-message="该字段不能为空">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label " style="font-size:16px;">手机</label>
							<div class="col-sm-7">
								<input type="text" id="mobileNo" name="mobileNo" class="form-control" placeholder="手机"  style=" height: 30px;font-size:18px;"  data-query="yes" data-toggle="tooltip" data-placement="bottom" title="管理员联系电话"
									data-bv-regexp="true" 
									data-bv-regexp-regexp="^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\d{8}$" 
									data-bv-regexp-message="输入不是一个有效的手机格式" 
									data-bv-notempty="true"
									data-bv-notempty-message="该字段不能为空">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label " style="font-size:16px;">邮箱</label>
							<div class="col-sm-7">
								<input type="text" id="email" name="email" class="form-control" placeholder="邮箱"   style=" height: 30px;font-size:18px;" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="邮箱"
									data-bv-regexp="true" 
									data-bv-regexp-regexp="^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$" 
									data-bv-regexp-message="输入不是一个有效的邮箱格式" 
									data-bv-notempty-message="该字段不能为空"
									data-bv-notempty="true">
									<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label " style="font-size:16px;">邀请码</label>
							<div class="col-sm-7">
								<input type="text" id="authorizationCode" name="authorizationCode" class="form-control"  style=" height: 30px;font-size:18px;" placeholder="医院提供的邀请码，如无可不填"  data-query="yes" 
									data-toggle="tooltip" data-placement="bottom" title="供应商授权码">
							</div>
						</div>
						</div>
						<br/>
						<div class="form-group">
							<div class="col-sm-12 text-center">
									<button type="button"  id="submit" class="btn btn-default btn-xs  btn-raycom" style="height:40px;font-size:16px;"  onclick="fncRegister();">
										注&nbsp;册 
									</button>
								<button type="button" class="btn btn-default btn-xs btn-raycom" style="height:40px;font-size:16px;"  onclick="fncCancel();">
									关&nbsp;闭
								</button>
							</div>
						</div>
					</div>
				</form>
				<div style="height:10px"></div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>
