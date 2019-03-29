<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/core/include/head.jsp" %>	
 <script src="${ctxStatic}/plugins/echarts/3.2.2/echarts.js"></script>
<title>图表化展示</title>
</head>
<body >
<div id="content" class="col-xs-12 col-sm-12" >
<div id="ajax-content">
<div class="row">
	<form id="form" method="post" action=""></form>
	<div class="col-xs-12 col-sm-12" style="height: 20px;"></div>
	<div class="col-xs-12 col-sm-6">
		<div class="box">
			<%@include file="/core/include/boxHead.jsp" %>	
			<div class="box-content" style="height: 323px;">
				<div  class="ct-chart tab-pane fade in active" style="height: 250%; width: 100%;">
					<font>订单未处理数量：<a href="javascript:void(0)" onclick="jumpPage();" class="tab-link" data-toggle="tab" >${number}</a></font><br>
      	 			<font>最新公告：</font><br>
      	 			<c:forEach items="${noticeTitle}" var ="title">
      	 				<font><a href="javascript:void(0)" onclick="fncNoticeDetail(${title.noticeId})" class="tab-link" data-toggle="tab" >${title.noticeTitle}</a></font><br>
      	 			</c:forEach>	
      	 		</div>
      	 	</div>		
		</div>
	</div>
	<div class="col-xs-12 col-sm-6">
		<div class="box">
		<%@include file="/core/include/boxHead.jsp" %>	
			<div class="box-content">
				<ul class="nav nav-tabs">
					<li ><a href="javascript:void(0)" onclick="fncSwitchChart2('1')" class="tab-link" data-toggle="tab" >线形图</a></li>
					<li class="active"><a href="javascript:void(0)" onclick="fncSwitchChart2('2')" class="tab-link" data-toggle="tab" >饼图</a></li>
				</ul>	
				<div id="container2" class="ct-chart tab-pane fade in active" style="height: 250%; width: 100%;"></div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12">
		<div class="box ui-draggable ui-droppable">
			<div class="box-header">
				 <div class="box-name ui-draggable-handle">
					<span>资质信息</span>
				</div>
				<div class="box-icons pull-right">
					<a class="collapse-link">
						<i class="fa fa-chevron-up"></i>
					</a>
					<a class="expand-link">
						<i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>	
			<div class="box-content">
				<table class="table table-striped table-bordered " id="certificate" width="100%">
				    		<tr>
				    			<th>资质证类型</th>
				    			<th>资质证名称</th>
				    			<th>证书编号</th>
				    			<th>生效日期</th>
				    			<th>失效日期</th>
				    			<th>备注</th>
				    			<th>发证机关</th>
				    			<th>附件</th>
				    		</tr>
				    	<c:forEach items="${certificateList}" var="certificate">
			    			<tr class="tr" data-type='data' data-name="${certificate.certificateType}">
			    				<td>${certificate.certificateTypeName}
			    					<input type="hidden"  value="${certificate.certificateId}"/>
			    				</td>
			    				<td>${certificate.certificateName}
			    					<input type="hidden" name="type" value="${certificate.certificateType}"/>
			    				</td>
			    				<td>${certificate.certificateNo}
			    					<input type="hidden" name="certificateName" value="${certificate.certificateName}"/>
			    				</td>
			    				<td>${certificate.startDate}</td>
			    				<td>${certificate.closeDate}</td>
			    				<td>${certificate.remarks}</td>
			    				<td>${certificate.issueDept}</td>
			    				<td>
			    					<a href="${fns:getConfig("cdn.url")}/file/download?fileId=${certificate.attachId}"
													target=“_blank”>${certificate.fileNameOrig}
									</a>
			    				</td>
			    			</tr>
				    	</c:forEach>
				    	</table>
			</div>
				<br>
				<br>
		</div>
	</div>
</div>
</div>
<!--End Container-->
</div>
</body>
 <script type="text/javascript"">
 
	function jumpPage(){
		actSubmit($('#form'), ctx+"/purchase");
	}
	function fncToNotice(){
		actSubmit($('#form'), ctx+"/sys/notice");
	}
	function fncNoticeDetail(noticeId){
		
		actSubmit($('#form'), ctx+"/sys/notice/detail?noticeId="+noticeId);
	}

	function fncSwitchChart2(charType){
		if(charType == "1"){
			var dom = document.getElementById("container2");
			var myChart = echarts.init(dom);
			myChart.setOption(getLineOption2());
			// 处理点击事件并且跳转到相应的资质效期页面
		    myChart.on('click', function (params) {
				actSubmit($('#form'), ctx+"/vendorQualification");
		    });
		}else if(charType == "2"){
			var dom = document.getElementById("container2");
			var myChart = echarts.init(dom);
			myChart.setOption(getPieOption2());
			myChart.on('click', function (params) {
				actSubmit($('#form'), ctx+"/vendorQualification");
		    });
		}
	}
	
	var dom2 = document.getElementById("container2");
	var myChart2 = echarts.init(dom2);
	var app = {};
	option = null;
	myChart2.showLoading();
	myChart2.hideLoading();
	
 //myChart.setOption(getLineOption());
 myChart2.setOption(getPieOption2());
 
// 处理点击事件并且跳转到相应的资质效期页面
 myChart2.on('click', function (params) {
 	actSubmit($('#form'), ctx+"/vendorQualification");
 });
 
 var xData2;
	var yData2; 
	var pieData2;
	var pie21;
	var pie22;
	var pie23;
	var pie24;
 function getLineOption2(){
 	
 	var option = {  
 	        title : {  
 	            text: '资质到期预警',  
 	            x: 'left'
 	        },  
 	        tooltip : {  
 	            trigger: 'axis'//item  axis  
 	        },  
 	        legend: {  
 	            data:['资质到期']  
 	        },  
 	        toolbox: {  
 	            show : true,  
 	            feature : {  
 	                mark : {show: true},  
 	                dataView : {show: true, readOnly: false},  
 	                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},  
 	                restore : {show: true},  
 	                saveAsImage : {show: true}  
 	            }  
 	        },  
 	        calculable : false,  
 	        grid: {
 	            top: '30%',
 	            left: '11%',
 	            right: '10%',
 	            containLabel: true
 	        },
 	        xAxis : [  
 	            {  
 	                type : 'category',  
 	                boundaryGap : false,  
 	                data : xData2 
 	            }  
 	        ],  
 	        yAxis : [  
 	            {  
 	                type : 'value',  
 	                axisLabel : {  
 	                    formatter: '{value} 天'  
 	                },  
 	                splitNumber:6  
 	            }  
 	        ],  
 	      /*  dataZoom: [
 	                   {
 	                       show: true,
 	                       start: 0,
 	                       end: 100
 	                   },
 	                   {
 	                       type: 'inside',
 	                       start: 94,
 	                       end: 100
 	                   },
 	                   {
 	                       show: true,
 	                       yAxisIndex: 0,
 	                       filterMode: 'empty',
 	                       width: 30,
 	                       height: '80%',
 	                       showDataShadow: false,
 	                       left: '93%'
 	                   }
 	               ],*/
 	        series : [  
 	            {  
 	                name:'资质到期',  
 	                type:'line',  
 	                data:yData2,  
 	                markPoint : {  
 	                    data : [  
 	                        {type : 'max', name: '最大值'},  
 	                        {type : 'min', name: '最小值'}  
 	                    ]  
 	                },   
 	                markLine : {  
 	                    data : [  
 	                        {type : 'average', name : '平均值'}  
 	                    ]  
 	                }  
 	            }  
 	        ]  
 	    }; 
 	return option;
 }
 
 function getPieOption2(){
 	$.ajax({
			async : false,
			cache : false,
			type : "post",
			url : ctx + "/chart/certValidLine",
			success : function(data) {
				xData2=data.xData;
				yData2=data.yData;
				pieData2=data.pie;
				pie21=pieData2[0].NUM;
				pie22=pieData2[1].NUM;
				pie23=pieData2[2].NUM;
				pie24=pieData2[3].NUM;
			},
			error : function() {
				alert("请求失败")
			}
		});
 	var option = {
 		    title : {
 		        text: '资质到期预警',
 		        x:'center'
 		    },
 		    tooltip : {
 		        trigger: 'item',
 		        formatter: "{a} <br/>{b} : {c} ({d}%)"
 		    },
 		    legend: {
 		        orient: 'vertical',
 		        left: 'left',
 		        data: ['30天以内(含30)','30-90天(含90)','90-180天(含180)','180天以上']
 		    },
 		    series : [
 		        {
 		            name: '资质效期到期预警',
 		            type: 'pie',
 		            radius : '55%',
 		            center: ['50%', '60%'],
 		            data:[
 		                {value:pie21, name:'30天以内(含30)'},
   		                {value:pie22, name:'30-90天(含90)'},
   		                {value:pie23, name:'90-180天(含180)'},
   		                {value:pie24, name:'180天以上'}
 		            ],
 		            itemStyle: {
 		                emphasis: {
 		                    shadowBlur: 10,
 		                    shadowOffsetX: 0,
 		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
 		                }
 		            }
 		        }
 		    ]
 		}; 
 	return option;
 }

 </script>
</html>
