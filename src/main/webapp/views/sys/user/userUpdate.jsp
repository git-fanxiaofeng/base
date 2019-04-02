<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户修改界面</title>
<%@include file="/core/include/head.jsp" %>		
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/bootstrapStyle/bootstrapStyle.css" type="text/css">
<script type="text/javascript">

	function fncUpdate() {
		rayDialogConfirm("确认保存？",function(){
			/* var arrayRole = new Array();//获取所有选择的角色id
			$("input[name='roles']:checked").each(function(i , m){
				arrayRole[i]=$(this).val();
			}); */
			validator.bootstrapValidator('validate');//执行校验
			if($(form).data('bootstrapValidator').isValid()){
				$.ajax({
				     type: "post",
				     url: "${ctx}/user/updateUserDo?arrayRole="+$('#roles').val(),
				     data: $('#form').serialize() ,
				     async:false,
				     success: function(data){
			    	 	rayDialog("修改成功");
						actSubmit($('#form'), ctx + "/user");
				    	},
				 });
			}
		});
	}
	
	function fncCancel() {
		actCancel($('#form'), ctx+"/user");
	}
	
	$(document).ready(function(){
		validator = $('#form').bootstrapValidator();
		$("input[value='"+$("#a1").val()+"']").attr("checked",true); //使用登录
		$("#userType").val($("#a2").val());//用户类型
		
		$('#officeName').orgRadioTree({id:'officeId',values:'${user.officeId}'});
	}); 
	
	//重置密码
	function  resetPass() {
		rayDialogConfirm("确认重置密码吗？",function(){
			$.ajax({
			     type: "post",
			     url: "${ctx}/user/resetPass",
			     data: $('#form').serialize() ,
			     async:false,
			     success: function(data){
			    	 if(data=='ok'){
			    	 	rayDialog("重置成功！",function(){
			    	 		actCancel($('#form'), ctx+"/user");
			    	 	});
			    	 }else{
			    		 rayDialog("重置失败！");
			    	 }
			    },
			 });
		})
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
						<input type="hidden" id="a1" value="${user.loginFlag}"/>
						<input type="hidden" id="a2" value="${user.userType}"/>
						<input type="hidden" id="userId" name="userId" value="${user.userId}">
					<div class="form-group has-feedback">
						<label class="col-sm-2 control-label">登录名</label>
						<div class="col-sm-4">
							<input  value="${user.loginName}" type="text"  class="form-control" placeholder="admin" id="loginName" name="loginName" data-toggle="tooltip" data-placement="bottom" readOnly>
						</div>
						<label class="col-sm-1 control-label">姓名</label>
						<div class="col-sm-4">
							<input value="${user.userName}" type="text" class="form-control" id="userName" name="userName" placeholder="姓名" data-toggle="tooltip" data-placement="bottom"
								data-bv-notempty="true" 
								data-bv-notempty-message="该字段不能为空" >
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group has-feedback">
						<label class="col-sm-2 control-label">密码</label>
						<div class="col-sm-4">
							<input value="${user.password}"  type="password" class="form-control" id="password" name="password" placeholder="字母开头6~20位" 
								data-bv-notempty="true" 
								data-bv-stringlength-min="6"
								data-bv-stringlength-max="20"
								data-bv-stringlength-message="该字段输入长度在6和20之间">
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-1 control-label">电话</label>
						<div class="col-sm-4">
							<input value="${user.phoneNo}" type="text" class="form-control" id="phoneNo" name="phoneNo"  data-toggle="tooltip" data-placement="bottom"
								data-bv-regexp="true"
								data-bv-regexp-regexp="^[0-9]*$"
								data-bv-regexp-message="电话必须为数字">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-4">
							<input value="${user.email}" type="text" class="form-control" id="email" name="email" 
								data-bv-emailaddress="true" 
								data-bv-emailaddress-message="输入不是一个有效的邮箱格式">
						</div>
						<label class="col-sm-1 control-label">手机</label>
						<div class="col-sm-4">
							<input type="text" value="${user.mobileNo}" id="mobileNo" name="mobileNo" class="form-control"  data-placement="top" 
								data-bv-regexp="true" 
								data-bv-regexp-regexp="^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$" 
								data-bv-regexp-message="输入不是一个有效的手机格式" >
						</div>
					</div>
					<%-- <div class="form-group">
						<label class="col-sm-2 control-label">角色</label>
						<div class="col-sm-10" style="padding-top: 4px;">
						 	<c:forEach items="${userRole}" var="role" >
								<input type="radio" name="roles" checked="checked" value="${role.roleId}" />${role.roleName}
							</c:forEach> 
						 	<c:forEach items="${exceptRole}" var="role" >
								<input type="radio" name="roles"  value="${role.roleId}" />${role.roleName}
							</c:forEach> 
						</div>
					</div> --%>
					<div class="form-group">
						<label class="col-sm-2 control-label">角色</label>
						<div class="col-sm-2" >
							<rt:select2 id="roles" name="roles"  htmlAppend="multiple='multiple'" items="${exceptRole }" itemLabel="roleName" itemValue="roleId"  value="${userRole}" dataQuery="yes" ></rt:select2>
						</div>
					</div>	
					<div class="form-group">
						<div class="col-sm-9">
						</div>
						<div class="col-sm-12 text-center">
							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncCancel()">
								返&nbsp;回
							</button>
						<shiro:hasPermission name="user:create">
							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="resetPass();">
								重置密码
							</button>
							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncUpdate();">
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

