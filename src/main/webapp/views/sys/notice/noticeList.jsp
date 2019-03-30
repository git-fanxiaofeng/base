<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/core/include/taglib.jsp" %>	
<!DOCTYPE html>
<html lang="en">
<head>
<title>公告管理</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">

	$(document).ready(function() {
		table = $('#datatable-form').raytable('form',{rightColumns:-1});
		table.column( 1 ).visible( false );
		table.column( 2 ).visible( false );
		setWinMoved();
		$("#startDate1").rayDatePicker();
		$("#startDate2").rayDatePicker();
		$("#endDate1").rayDatePicker();
		$("#endDate2").rayDatePicker();
		
		$("#startDate1").on("show", function() {
			 $(".datepicker.datepicker-dropdown.dropdown-menu").css("z-index", 1000);
			})
		
		//查询按钮
		$("#btnSearch").click(function(){
			if(new Date($('#endDate1').val()) < new Date($('#startDate1').val())){
				rayDialog('开始日期中开始时间不能大于结束时间！');
				return;
			}
			if(new Date($('#endDate2').val()) < new Date($('#startDate2').val())){
				rayDialog('结束日期中开始时间不能大于结束时间！');
				return;
			}
			table.ajax.reload();
		});
		$("#noticeTitle").keyup(function(event){
			if(event.keyCode == 13){
				$("#btnSearch").click();
			};
		});
	});
	
	//进入新增页面
	function fncAdd(){
		actSubmit($('#form'), ctx+"/notice/add");
	}
	
	//进入详情页面
	function fncDetail(noticeId){
		actSubmit($('#form'), ctx+"/notice/update?noticeId="+noticeId);
	}
	
	//删除
	function fncDelete(noticeId,publishSys){
		rayDialogConfirm("是否要删除？",function(){
			actSubmit($('#form'), ctx+"/notice/delete?noticeId="+noticeId+"&publishSys="+publishSys);
		});
	}
	
	$.extend( true, $.fn.dataTable.defaults, {
		createdRow:function ( row, data, index ) {
	        var noticeId = data["noticeId"];
	        var publishSys = data["publishSys"];
	        if(publishSys != '03'){
	        	$('td', row).eq(6).html("<a href='javascript:;' style='padding-left:7px;' onclick=\"fncDetail('"+noticeId+"')\" title='去查看'><i class='fa fa-file-text-o'></i></a>"+
	        								"<a href='javascript:;' style='padding-left:7px;' onclick=\"fncDelete('"+noticeId+"','"+publishSys+"')\" title='去删除'><i class='fa fa-trash-o'></i></a>");
	        }else{
	        	$('td', row).eq(6).html("<a href='javascript:;' style='padding-left:7px;' onclick=\"fncDetail('"+noticeId+"')\" title='去查看'><i class='fa fa-file-text-o'></i></a>");
	        }
		}
	});
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
			<div class="box-content">
				<form class="form-horizontal" id="form" method="post" action="/notice/queryNoticeList">
					<div class="form-group">
						<label class="col-sm-1 control-label">公告标题</label>
						<div class="col-sm-5" style="width:39.7%">
							<input type="text" id="noticeTitle" class="form-control" placeholder="公告标题" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="公告标题">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">开始日期</label>
						<div class="col-sm-5 ">
							<div class="form-inline">
								<div class="input-group" >
									<input type="text"  readonly id="startDate1"  class="form-control" placeholder="开始日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="开始日期">
									<span class="input-group-addon " ><i class="fa fa-calendar"></i></span>
								</div>
								<div class="input-group" >~</div>
								<div class="input-group " >
								<input type="text" readonly id="endDate1" class="form-control" placeholder="结束日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="结束日期">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								</div>
							</div>
						</div>
					    <label class="col-sm-1 control-label">结束日期</label>
					    <div class="col-sm-5">
							<div class="form-inline">
								<div class="input-group" >
									<input type="text"  readonly id="startDate2"  class="form-control" placeholder="开始日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="开始日期">
									<span class="input-group-addon " ><i class="fa fa-calendar"></i></span>
								</div>
								<div class="input-group" >~</div>
								<div class="input-group " >
								<input type="text" readonly id="endDate2" class="form-control" placeholder="结束日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="结束日期">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								</div>
							</div>
						</div>
					 </div>
					 <div class="form-group" >							
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
<div class="col-sm-3 text-left btn-raycom-nav">
	  	<shiro:hasPermission name="notice:create">
		 	<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncAdd()">
			新&nbsp;增
		    </button>
	  	</shiro:hasPermission>
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
							<th data-column="noticeId">公告Id(隐藏)</th>
							<th data-column="publishSys">发布系统(隐藏)</th>
							<th data-column="noticeTitle">公告标题</th>
							<th data-column="startDate">公告开始日期</th>
							<th data-column="endDate">公告结束日期</th>
							<th data-column="publishSysName">发布系统</th>
							<th data-column="createDate">创建日期</th>
							<th data-column="op">操作</th>
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