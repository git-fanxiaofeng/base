<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户添加界面</title>
<%@include file="/core/include/head.jsp" %>		
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/bootstrapStyle/bootstrapStyle.css" type="text/css">
<script type="text/javascript">
	$(document).ready(function() {
		
		validator = $('#form').bootstrapValidator();//ajax提交时使用
	});
	
	function fncAdd() {
		rayDialogConfirm("确认保存？",function(){
			/* var arrayRole = new Array();//获取所有选择的角色id
			$("input[name='roles']:checked").each(function(i , m){
				arrayRole[i]=$(this).val();
			}); */
			validator.bootstrapValidator('validate');//执行校验
		    if($(form).data('bootstrapValidator').isValid()){//校验通过 */
				$.ajax({
				     type: "post",
				     url: "${ctx}/user/createUserDo?arrayRole="+$('#roles').val(),
				     data: $('#form').serialize() ,
				     async:false,
				     success: function(msg){
				    	 if(msg=="true"){
							rayDialog("新增用户成功");
		    				actSubmit($('#form'), ctx + "/user");
				    	 }else {
				    		rayDialog(msg);
				    		$("#loginName").focus();
				    	 }
			    	}
				 });
			}
		});
	}
	
	function fncCancel() {//返回
		 actCancel($('#form'), ctx+"/user");
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
				<form class="form-horizontal" id="form" name="form" action="${ctx}/user/createRoleDo"  method="post" >
					<div class="form-group has-feedback"  >
						<label class="col-sm-2 control-label">登录名</label>
						<div class="col-sm-4">
							<input type="text"  class="form-control" id="loginName" name="loginName"  data-placement="bottom" placeholder="登录名" title="登录名"
								data-bv-notempty="true" 
								data-bv-regexp="true"
								data-bv-regexp-regexp="^[a-zA-z0-9][a-zA-Z0-9_]{2,9}$"
								data-bv-regexp-message="登录名应以英文字母|数字|下划线组成！！！"
								data-bv-notempty-message="该字段不能为空">
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-1 control-label">姓名</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="userName" name="userName"  data-placement="bottom" placeholder="姓名" title="姓名 "
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空"/>
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group  has-feedback" >
						<label class="col-sm-2 control-label">密码</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="password" name="password" placeholder="字母开头6~20位" data-placement="bottom" title="密码"
								data-bv-notempty="true" 
								data-bv-stringlength-min="6"	
								data-bv-stringlength-max="20" 
								data-bv-stringlength-message="该字段输入长度在6和20之间">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-1 control-label">电话</label>
						<div class="col-sm-4">
					    	<input type="text" class="form-control" id="phoneNo" name="phoneNo" placeholder="电话" title="电话"
								data-bv-regexp="true"
								data-bv-regexp-regexp="^[0-9]*$"
								data-bv-regexp-message="电话必须为数字">
						</div>
					</div>
					<div class="form-group" >
						<label class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-4">
							<input type="text"  class="form-control" id="email" name="email" placeholder="邮箱" title="邮箱"
								data-bv-emailaddress="true" 
								data-bv-emailaddress-message="输入不是一个有效的邮箱格式">
							
						</div>
						<label class="col-sm-1 control-label">手机</label>
						<div class="col-sm-4">
							<input type="text"  class="form-control" id="mobileNo" name="mobileNo"  data-placement="top" placeholder="手机" title="手机"
								data-bv-regexp="true" 
								data-bv-regexp-regexp="^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$" 
								data-bv-regexp-message="输入不是一个有效的手机格式" >
						</div>
					</div>
					<div class="form-group" >
						<label class="col-sm-2 control-label">用户编号</label>
						<div class="col-sm-4">
							<input  type="text"  class="form-control" id="userId"  name="userId" placeholder="用户编号" title="用户编号">
						</div>
						<label class="col-sm-1 control-label">状态</label>
						<div class="col-sm-4" style="padding-top: 4px;">
							<input name="loginFlag" type="radio" value="Y" checked="checked" />可以登陆
							<input name="loginFlag" type="radio" value="N" />禁止登录
						</div>
					</div>
					<div class="form-group " >
						<label class="col-sm-2 control-label text-right">角色</label>
						<div class="col-sm-4">
						 	<%-- <c:forEach items="${role}" var="role" >
								<input type="checkbox" name="roles" value="${role.roleId}"/>${role.roleName}
							</c:forEach>  --%>
							<rt:select2 id="roles" name="roles"  htmlAppend="multiple='multiple'" items="${role }" itemLabel="roleName" itemValue="roleId"  value="" dataQuery="yes" ></rt:select2>
						</div>
					</div>
					<div class="form-group" >
						<div class="col-sm-9"></div>
						<div class="col-sm-12 text-center">
							<shiro:hasPermission name="user:create">
							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncAdd();" > 
									保&nbsp;存
							</button>
							</shiro:hasPermission>
							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncCancel()" >
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
