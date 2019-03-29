<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>供应商信息查询详情</title>
<%@include file="/core/include/head.jsp" %>
<%@include file="/core/include/vue/vue.jsp" %> 
<style>
	.selected{background:#f0f0f0;}
	.evenLength{width:130px}
	.oddLength{width:226px}
</style>
</head>
<body>
<!-- 注册资质卡片组件(子组件) -->
<template id="certCard" >
	<div class="col-sm-6 circle ">
		<div class="col-sm-12 header " >
				<template v-if="certInfo.certParentCategory==='authorizeCert'">
					{{certInfo.issueDept}} &#8674 {{certInfo.authorizedName}}<span style="top: 2px;"  class="layui-badge layui-bg-orange">{{certInfo.agencyOrder}}</span>
				</template>
				<template v-else>{{certInfo.certificateName}}</template>
		</div>
		<div class="col-sm-2  text-center picturediv" v-on:click="$emit('img',true,certInfo)">
			<img src="${ctxStatic}/img/9036958611_fa1bb7f827_m.jpg" class="picture">
		</div>
		<div class="col-sm-10 cru ">
			<div class="col-sm-9 text-pl5" >																			
				<div class="col-sm-12 text-pl0" >
					证号：{{certInfo.certificateNo}}
				</div>
				<div class="col-sm-12 text-pl0" >
					效期：{{certInfo.startDate}} ~ {{certInfo.closeDate}}
				</div>																					
			</div>
			<div class="col-sm-12 text-pl5" >
				<p>{{certInfo.issueDept}}</p>
			</div>
			<div class="col-sm-12 text-pl5" style="margin-bottom: 1px;">																					
				<hr class="layui-bg-gray" style="margin-top: 2px;margin-bottom: 2px;">
			</div> 
		</div>
		</div> 
	</div>
</template>

<div id="content" class="col-xs-12 col-sm-12">
<div id="ajax-content">
<rt:navigation/>
<!-- 企业基础信息 -->
<div class="row box-content" style="padding-top: 0px;"> 
<template>
<el-tabs value="base" >
<el-tab-pane label="供应商信息" name="base">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-content"  >
				<form action="" id='form' ></form>
				<table class="table table-bordered" id="basicInfo" style="table-layout:fixed;word-break:break-all;">	
					<tr>
						<td class="selected">公司简称</td>
						<td>{{vh.vendorChName}}</td>
						<td class="selected">法人代表</td>
						<td> {{vh.corporation}}</td>
						<td class="selected">注册资本金</td>
						<td>{{vh.registeredFund}}</td>
					</tr>
					<tr>
						<td class="selected">国家/省份</td>
						<td> {{vh.area}}</td>
						<td class="selected">注册地址</td>
						<td colspan="3">{{vh.registeredAddress}}</td>
					</tr>
					<tr>
						<td class="selected">公司类型</td>
						<td>{{vh.companyType}}</td>
						<td class="selected">办公地址</td>
						<td colspan="3">{{vh.officeAddress}}</td>
					</tr>
					<tr>
						<td class="selected">经营许可范围</td>
						<td colspan="5">{{vh.toleranceRangeName}}</td>
					</tr>
					<tr>
						<td class="selected">公司简介</td>
						<td colspan="5">{{vh.introduction}}</td>
					</tr>
					<tr>
						<td class="selected" rowspan="2">联系人</td>
						<td>{{vh.contact1}}</td>
						<td class="selected">电话</td>
						<td > {{vh.tel1}}</td>
						<td class="selected">邮箱</td>
						<td>{{vh.email1}}</td>
					</tr>
					<tr>
						<td>{{vh.contact2}}</td>
						<td class="selected">电话</td>
						<td> {{vh.tel2}}</td>
						<td class="selected">邮箱</td>
						<td>{{vh.email2}}</td>
					</tr>
					<tr>
						<td class="selected">关联医院</td>
						<td colspan="5">{{vh.hosName}}</td>
					</tr>
				</table>
			</div>		
		</div>
		<div class="layui-tab-item layui-show text-center">
			<button class="btn btn-default btn-xs btn-raycom" 
				v-on:click="vendorRefuse()">拒收</button>
			<button class="btn btn-default btn-xs btn-raycom" v-on:click="handleApprove(vendorApplyId,'','02','',vh)">接收</button>
			<button class="btn btn-default btn-xs btn-raycom" onclick="fncReturn()">返回</button>
	    </div>
	</div>
</div>
</el-tab-pane>
<el-tab-pane label="资质证书" name="cert">
<div class="row" id="certUitList">
	<div class="col-xs-12 col-sm-12" >
		<div class="layui-tab-item layui-show">
			<div class="layui-tab layui-tab-card" lay-filter="tabCertCard">
				<ul class="layui-tab-title">
					<li v-for="company in companys" :class="{'layui-this':currentCertUnitId===company.certUnitId}" 
								:id="company.certUnitId"  @click="companySwitch(company.certUnitId)">
								{{company.certUnitName}}</li>
				</ul>
				<div class="box-content" style="padding-top: 0px;margin-top: 0px;" >
					<div class="layui-tab-content" style="padding-top: 0px;padding-left: 0px;padding-right: 0px;">
						<div class="layui-tab-item layui-show row" >
							<table class="table table-bordered" id="certificate2">
								<tr>
									<th>企业证书</th>
								</tr>
								<tr>
									<td>
										<!-- 父组件 -->
										<cert-card v-on:img="clickImg" v-for="post in certDetail.companyCert" 
										v-bind:key="post.certificateId" v-bind:cert-info="post"></cert-card>
									</td>
								</tr>
								<tr>
									<th>授权证书</th>
								</tr>
								<tr>
									<td>
										<!-- 父组件 -->
										<cert-card v-on:img="clickImg" v-for="post in certDetail.authorizeCert" 
										v-bind:key="post.certificateId" v-bind:cert-info="post"></cert-card>
										<div class="row col-sm-12">
											<div class="layui-tab layui-tab-brief" lay-filter="tabSuply">
												<ul class="layui-tab-title">
													<li v-for="agentCompany in certDetail.agentCompanyCert" :class="{'layui-this':currentAgentCertUnitId===agentCompany.certUnitId}" 
															:id="agentCompany.certUnitId"  @click="companyAgentSwitch(agentCompany.certUnitId)">{{agentCompany.certUnitName}}</li>
												</ul>
												<div class="layui-tab-content">
													<div class="layui-tab-item layui-show" >
														<cert-card v-on:img="clickImg"   v-for="post in certAgentDetail" 
																v-bind:key="post.certificateId" v-bind:cert-info="post"></cert-card>
													</div>
												</div>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>产品证书</th>
								</tr>
								<tr>
									<td>
										<!-- 父组件 -->
										<cert-card  v-on:img="clickImg"  v-for="post in certDetail.productCert" 
										v-bind:key="post.certificateId" v-bind:cert-info="post"></cert-card>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>		
		<el-dialog title="图片查看" :visible.sync="dialogVisibled"  width="80%"  :modal-append-to-body='false' top='10vh' >
		  	<template>
		  		<el-carousel indicator-position="outside" height="650px" :autoplay="false">
				     <el-carousel-item v-for="item in imgUrls" :key="item.pictureUrl" :label='item.pictureLabel'>
				      <img :src="item.pictureUrl" alt="" style="width: 100%;height:100%">
				    </el-carousel-item>
				  </el-carousel>
			</template>
		</el-dialog>					
	</div>
</div>	
</el-tab-pane>
</el-tabs>
</template>
</div>
</div>
</div>  	
</body>
<script type="text/javascript">
	$(document).ready(function(){
		//回车功能禁用
		$(document).keypress(function(event){
			if(event.keyCode == 13 || event.which==13){
			return false;
			}
		});
	});
	
	Vue.component('cert-card',{props: ['certInfo'],template: '#certCard'});
	
	var showCert = new Vue({
			el: '#content',
			data:{
				vh:'',
				companys:'',
				certDetail:{},
				certAgentDetail:{},
				currentCertUnitId:"",
				currentAgentCertUnitId:"",
				vendorId:"${data.vendorId}",
				dialogVisibled: false,
				imgUrls:[],
			},
			mounted:function(){
				var _this = this;
				var params = new URLSearchParams();
				params.append('vendorId', this.vendorId);
				axios.post(ctx + "/vendor/queryVH", params)
				  .then(function (response) {
					_this.vh =response.data;
					_this.companys = response.data.companys;
					 if(_this.companys)
					 	_this.currentCertUnitId = _this.companys[0].certUnitId;
				  })
				  .catch(function (error) {
				    console.log();
				  });
			},
          	watch:{
          		currentCertUnitId:{
   				 immediate:true,
   				 handler:function(){
   					 var _this = this;
   	        		 for(var i = 0;i<_this.companys.length;i++){
   						 if(_this.currentCertUnitId==_this.companys[i].certUnitId){
   							 _this.certDetail =_this.companys[i].certDetail; 
   							 
   							 if(_this.certDetail.agentCompanyCert&&_this.certDetail.agentCompanyCert.length>0)
   								 	_this.currentAgentCertUnitId =_this.certDetail.agentCompanyCert[0].certUnitId;
   							 return;
   						 }
   					 }
   				 }
   			 },
   			 currentAgentCertUnitId:{
   				 immediate:true,
   				 handler:function(){
   					 var _this = this;
   					 if(_this.certDetail&&_this.certDetail.agentCompanyCert){
   		        		 for(var i = 0;i<_this.certDetail.agentCompanyCert.length;i++){
   							 if(_this.currentAgentCertUnitId==this.certDetail.agentCompanyCert[i].certUnitId){
   								 _this.certAgentDetail =this.certDetail.agentCompanyCert[i].agentCompanyCert; 
   								 return;
   							 }
   						 }
   					 }
   				 }
   			 }
          },
          methods:{
            	clickImg:function(flag,certInfo){
    		    	this.dialogVisibled = flag;	
    		    	var attchIds = certInfo.attachId.split(',');
    		    	this.imgUrls = [];
    		    	for(var i=0;i<attchIds.length;i++){
    	          		var pictureUrl = '${fns:getConfig('cdn.url')}/file/showImg?fileId='+attchIds[i];
    	          		var pictureLabel="附件"+(i+1);
    	          		this.imgUrls.push({"pictureUrl":pictureUrl,"pictureLabel":pictureLabel});
    	          	}
    		    },
            	//切换资质管理单元
            	companySwitch:function(certUnitId){
            		this.currentCertUnitId = certUnitId;        		
            	},
            	companyAgentSwitch:function(certUnitId){
            		this.currentAgentCertUnitId = certUnitId;        		
            	},
			}
        });
	
	function fncReturn(){
		rayDialogConfirm("是否返回上一页面？",function(){
			actCancel($("#form"), ctx + "/vendor");
		});
	}
</script>
</html>

