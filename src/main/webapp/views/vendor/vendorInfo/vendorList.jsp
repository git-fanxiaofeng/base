<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>供应商信息查询</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
	
	//进入详情
	function fncDetail(vendorId){
		actSubmit($('#form'), ctx+"/vendor/vendorDetail?vendorId="+vendorId);
	}
	
	$(function(){
		$(document).keyup(function(event){
			if(event.keyCode == 13){
				$("#btnSearch").click();
			};
		});
		table = $('#datatable-form').raytable('form',{rightColumns:-1});
		$("#btnSearch").click(function(){
			table.ajax.reload(null,true);
		});
	})

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
				<form class="form-horizontal" id="form" method="post" action="/vendor/queryVendorList">
					<div class="form-group">
						<label class="col-sm-1 control-label" style="padding-left:0px">供应商代码</label>
						<div class="col-sm-2">
							<input type="text" id="vendorCode" name="vendorCodes" value="${vendorCode}" class="form-control" placeholder="供应代码" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="供应商代码">
						</div>
						<label class="col-sm-1 control-label" style="padding-left:0px">供应商名称</label>
						<div class="col-sm-2">
							<input type="text" id="vendorName" name="vendorName" value="${vendorName}" class="form-control" placeholder="供应商名称" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="供应商名称">
						</div>
						<div class="form-group " >							
							<div class="col-sm-12 text-center btn-raycom-search">
								<button type="button" class="btn btn-default btn-xs btn-raycom" id="btnSearch">
							 			查&nbsp;询 
							  	</button>
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
		<div class="box">
			<%@include file="/core/include/boxHead.jsp" %>	
			<div class="box-content no-padding">
				<table class="table table-striped table-bordered " id="datatable-form" width="100%">
					<thead>
						<tr>
							<th data-column="num">序号</th>
							<th data-column="vendorId">供应商代码</th>
							<th data-column="vendorChName">供应商名称</th>
							<th data-column="vendorChShortName">供应商中文简称</th>
							<th data-column="vendorCategory">供应商分类</th>
							<!-- <th data-column="status">使用状态</th> -->
							<th data-column="op" data-method="[
										{targets:-1,title:'详情',fncName:'fncDetail',params:'vendorId'}
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
