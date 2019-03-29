<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>共同代码管理</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
	$(document).ready(function() {
		table = $('#datatable-form').raytable('form');
		//查询按钮
		$("#btnSearch").click(function(){ 
			table.ajax.reload();
		});
		setWinMoved();
		
	});

	function fncAdd(){
		actSubmit($('#form'), ctx+"/comCode/add");
	}

	function fncupdate(dictId){
		actSubmit($('#form'), ctx+"/comCode/update?dictId="+dictId);
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
			<div class="box-content" >
				<form class="form-horizontal" id="form" method="post" action="/comCode/querycomCodeList">
					<div class="form-group" >
						<label class="col-sm-1 control-label" >分类</label>
						<div class="col-sm-2" >
							<rt:select2 id="type" dataQuery="yes" headerKey="-1" headerValue="全部" items="${types}" itemValue="type" itemLabel="type">
							</rt:select2>
						</div>
						<label class="col-sm-1 control-label" >代码名</label>
						<div class="col-sm-2" >
							<input type="text" id="label" class="form-control" placeholder="代码名" data-query="yes">
						</div>
						<label class="col-sm-1 control-label" >类型名称</label>
						<div class="col-sm-2" >
							<input type="text" id="remark" class="form-control" placeholder="类型名称" data-query="yes">
						</div>
					</div>
					<div class="form-group" >
						<div class="col-sm-12 text-center ">
							<button type="button" class="btn btn-default  btn-xs  btn-raycom" id="btnSearch" >
								查 &nbsp;询 
							</button>
							
						</div>
					</div>
				</form>
			</div>
			</div>
		</div>
	</div>
</div>
<div class="col-sm-3 text-left btn-raycom-nav" >
					<button type="button" class="btn btn-default  btn-xs  btn-raycom" onclick="fncAdd()" >
								新&nbsp;增
							</button>
</div>


<div class="row">
	<div class="col-xs-12">
		<div class="box">
		<%@include file="/core/include/boxHead.jsp" %>	
		<div class="box-content no-padding">
			<table class="table table-striped table-bordered " id="datatable-form" width="100%">
				<thead>
					<tr>
						<th data-column="dictId" >编号</th>
						<th data-column="type" >分类</th>
						<th data-column="code" >代码</th>
						<th data-column="label" >代码名</th>
						<th data-column="remark" >类型名称</th>
						<th data-column="sort" >代码排序</th>
						<th data-column="delFlag" >状态</th>
						<th data-column="op"  data-method="[{targets:-1,title:'查看',fncName:'fncupdate',params:'dictId'}]">操作</th>
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