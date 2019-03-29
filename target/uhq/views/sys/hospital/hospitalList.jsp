<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>医院基本信息管理</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">

	$(document).ready(function() {
		table = $('#datatable-form').raytable('form');
		setWinMoved();
		//查询
		$("#btnSearch").click(function(){
			table.ajax.reload();
		});
	});
	
	function fncAdd(){
		actSubmit($('#form'), ctx+"/hospital/add");
	}
	
	function fncUpdate(id){
		actSubmit($('#form'), ctx+"/hospital/update?orgId="+id);
	}

</script>	
</head>
<body>
<div id="content" class="col-xs-12 col-sm-12" >
<div id="ajax-content">
<!-- nav -->
<rt:navigation/>
<!-- nav end -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<%@include file="/core/include/boxHead.jsp" %>	
			<div class="box-content" class="col-xs-12 col-sm-12">
				<form class="form-horizontal" id="form" method="post" action="/hospital/queryHospitalList" >
					<div class="form-group">
						<label class="col-sm-1 control-label">医院名称</label>
						<div class="col-sm-3">
              			  	<input type="text" id="orgName" name="orgName" class="form-control" placeholder="医院名称" data-query="yes" data-placement="bottom">
              		    </div>
					</div>
					<div class="form-group">
						<div class="col-sm-12 text-center btn-raycom-search">
							<button type="button" class="btn btn-default btn-xs btn-raycom" id="btnSearch">
						 	查&nbsp;&nbsp;询 
						  	</button>
						  	<shiro:hasPermission name="hospital:create">
	 							<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncAdd()">
								新&nbsp;增
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
<div class="row">
	<div class="col-xs-12">
		<div class="box" class="col-xs-12 col-sm-12">
			<%@include file="/core/include/boxHead.jsp" %>	
			<div class="box-content no-padding">
				<table class="table table-striped table-bordered " id="datatable-form" width="100%">
					<thead>
						<tr>
							<th data-column="num">序号</th>
							<th data-column="orgName">医院名称</th>
							<th data-column="orgId">医院编码</th>
							<th data-column="tel">固定电话</th>
							<th data-column="contact">委托联系人</th>
							<th data-column="fax">传真</th>
							<th data-column="address">地址</th>
							<th data-column="postcode">邮政编码</th>
							<th data-column="email">邮箱</th>
							<th data-column="website">网址</th>
							<th data-column="op" data-method="[
										{targets:-1,title:'查看',fncName:'fncUpdate',params:'orgId'}
										]">操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!--End Container-->
</div>
</body>
</html>
