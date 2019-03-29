<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/core/include/taglib.jsp" %>	
<!DOCTYPE html>
<html lang="en">
<head>
<title>公告管理</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">

	$(document).ready(function() {
		table = $('#datatable-form').raytable('form');
		$('#datatable-form').on( 'draw.dt', function () {
			var arr = table.rows().data();
			$('#datatable-form').attr("class","table  table-bordered  dataTable no-footer");
			for(var i = 0; i <arr.length;i++){
				var date = arr[i].endDate;//获取公告结束日期
				var val = Date.parse(date)+1 * 24 * 60 * 60 * 1000;//转换为date
				var date=new Date();//获取当前时间
				var result=date.getTime();
				var time = result-val;//获取时间差
				if(time<=0){
					$('#datatable-form').find('tr').eq(i+1).find('td').eq(2).attr("style","color :red; font-weight:600");
				}
			}
			
		} );
		
		setWinMoved();
		//键盘回车事件
		$(document).keyup(function(event){
			if(event.keyCode == 13 ){
				$("#btnSearch").click();
			};	
		});
		$("#startDate1").rayDatePicker();
		$("#startDate2").rayDatePicker();
		$("#endDate1").rayDatePicker();
		$("#endDate2").rayDatePicker();
		//用来存放当前正在操作的日期文本框的引用。  
		var datepicker_CurrentInput;     
		// 设置DatePicker 的默认设置  
		$.datepicker.setDefaults({ showButtonPanel: true,  isShowToday : false, currentText : 'Today',closeText: '清除', beforeShow: function (input, inst) { datepicker_CurrentInput = input; } });  
		// 绑定“Done”按钮的click事件，触发的时候，清空文本框的值  
		$("#ui-datepicker-div").on("click",".ui-datepicker-close", function ()  
		{  
		    datepicker_CurrentInput.value = "";
		});
		$('#form').bootstrapValidator();//表单提交时使用
		//返回按钮
		$("#btnSearch").click(function(){
			if(new Date($('#endDate1').val()) < new Date($('#startDate1').val())||new Date($('#endDate2').val()) < new Date($('#startDate2').val())){
				rayDialog('开始时间不能大于结束时间！');
				return;
			}
			table.ajax.reload();
		});
	});
	
	//进入详情页面
	function fncDetail(noticeId){
		actSubmit($('#form'), ctx+"/sys/notice/detail?noticeId="+noticeId);
	}
	
	//进入更新页面
	function fncUpdate(noticeId){
		actSubmit($('#form'), ctx+"/sys/notice/update?noticeId="+noticeId);
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
			<div class="box-content">
				<!-- <h4 class="page-header">Registration form</h4> -->
				<form class="form-horizontal" id="form" method="post" action="/sys/notice/queryNoticeList"
				 onkeypress="if(event.keyCode==13||event.which==13){return false;}">
					<div class="form-group">
					<label class="col-sm-1 control-label">公告标题</label>
						<div class="col-sm-5">
							<input type="text" id="noticeTitle" class="form-control" placeholder="公告标题" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="公告标题">
						</div>
						
						<!-- 
						<div class="col-sm-2">
							<input type="text" id="startDate1" readonly="readonly" class="form-control" placeholder="开始日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="开始日期">
						</div>
						<div class="col-sm-2">
							<input type="text" id="endDate1" readonly="readonly" class="form-control" placeholder="结束日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="结束日期">
						</div>
						 -->
						
					</div>
					<div class="form-group">
					<label class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">开始日期</label>
						<div class="col-sm-5">
							<div class="form-inline">
								<div class="input-group" >
									<input type="text" id="startDate1" readonly="readonly" class="form-control" placeholder="开始日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="开始日期">
									<span class="input-group-addon " ><i class="fa fa-calendar"></i></span>
								</div>
								<div class="input-group" style="margin-left:13px;margin-right:12px;">~</div>
								<div class="input-group" >
									<input type="text" id="endDate1" readonly="readonly" class="form-control" placeholder="结束日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="结束日期">
									<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								</div>
							</div>
						</div>
						
						<label class="col-sm-1 control-label" style="padding-left:0px;padding-right:0px;">结束日期</label>
						<div class="col-sm-5">
							<div class="form-inline">
								<div class="input-group" >
									<input type="text" id="startDate2" readonly="readonly" class="form-control"  placeholder="开始日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="开始日期">
									<span class="input-group-addon " ><i class="fa fa-calendar"></i></span>
								</div>
								<div class="input-group" style="margin-left:13px;margin-right:12px;">~</div>
								<div class="input-group" >
									<input type="text" id="endDate2" readonly="readonly" class="form-control" placeholder="结束日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="结束日期">
									<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								</div>
							</div>
						</div>
						<!-- 
						<div class="col-sm-2">
							<input type="text" id="startDate2" readonly="readonly" class="form-control"  placeholder="开始日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="开始日期">
						</div>
						<div class="col-sm-2">
							<input type="text" id="endDate2" readonly="readonly" class="form-control" placeholder="结束日期" data-query="yes" data-toggle="tooltip" data-placement="bottom" title="结束日期">
						</div>
						 -->
					 </div>
					 <div class="form-group">
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
							<th data-column="noticeId">公告ID</th>
							<th data-column="noticeTitle">公告标题</th>
							<th data-column="startDate">公告开始日期</th>
							<th data-column="endDate">公告结束日期</th>
							<th data-column="op" data-method="[
										{targets:-1,title:'查看',fncName:'fncDetail',params:'noticeId'},
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