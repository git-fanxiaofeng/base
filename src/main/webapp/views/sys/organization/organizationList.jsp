<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>组织管理</TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%@include file="/core/include/head.jsp"%>
<title>组织管理</title>
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/bootstrapStyle/bootstrapStyle.css" type="text/css">
<script type="text/javascript">
	var setting = {
		view: {
			addHoverDom: addHoverDom,//鼠标移动到节点上
			removeHoverDom: removeHoverDom,//鼠标移出节点上
			dblClickExpand: dblClickExpand,//鼠标点击事件
			selectedMulti: false//禁止复选
		},
		edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback : {
			onClick : fncTreeNodeClick
		}
	};
	var newCount = 1;
	
	$(function() {
		validator = $('#form').bootstrapValidator();
		fncInitOrg();
	});
	
	//初始化
	function fncInitOrg() {
		$.ajax({
			async : false,
			cache : false,
			type : "post",
			url : ctx + "/organization/organizationTree",
			success : function(data) {
				zTree = $.fn.zTree.init($("#tree"), setting, data);
				zTree.expandAll(true);
				fncInitForm() 
			},
			error : function() {
				rayDialog("请求失败")
			}
		});
	}
	
	//定义一个节点的子节点
	var nodes;
	//鼠标单击执行的事件
	function fncTreeNodeClick(event, treeId, treeNode) {
		fncInitForm();
		if(treeNode.level<2) { //医院对应为一级，分院为二级
			$("#branchOrgId").val('');
		}else{
			var treeNode1=treeNode;
			for(var i=treeNode1.level;i>=2;i--) {
				treeNode1 = zTree.getNodeByTId(treeNode1.parentTId);
			}
			$("#branchOrgId").val(treeNode1.id);
		}
		nodes = treeNode.children;
		var params;
		params = {"orgId" : treeNode.id};
		$.get(ctx + "/organization/queryByOrgId",params,
			function(data,status){
			if(treeNode.id.charAt(0)=='n'){//新增节点
					$("#orgCode").val(data.orgCode);
					$("#parentOrgId").val(treeNode.pId);
					$("#orgId").val(data.orgId);
				}else{//修改节点
					$("#orgName").val(data.orgName);
					$("#orgCode").val(data.orgCode);
					$("#linkman").val(data.linkman);
					$("#linkmanPhone").val(data.linkmanPhone);
					$("#address").val(data.address);
					$("#phone").val(data.phone);
					$("#orgId").val(data.orgId);
				}
				
			}
		);
	};
	
	//初始化表单数据
	function fncInitForm() {//清空编辑区
		$("#orgName").val('');
		$("#orgCode").val('');
		$("#linkman").val('');
		$("#linkmanPhone").val('');
		$("#phone").val('');
		$("#address").val('');
		$("#orgId").val('');
		$("#parentOrgId").val('');
		$("#branchOrgId").val('');
	};
	
	function dblClickExpand(treeId, treeNode) {
		return treeNode.level > 0;//主节点不可变更
	}
	
	//鼠标移动到节点上
	function addHoverDom(treeId, treeNode) {
		if(treeNode.id.charAt(0)=='n') return;
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		
		var sObj = $("#" + treeNode.tId + "_span");
		sObj.after("<span class='fa fa-plus-square' id='addBtn_" + treeNode.tId+ "' title='add node' onfocus='this.blur();'  style='position: relative; margin-right: -1px; vertical-align:top;font-size:15px;padding-left: 8px;color: rgb(10, 82, 167);top: 0px;font-family: FontAwesome;'></span>");
		
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) {
			btn.bind("click", function(){
				zTree.addNodes(treeNode, {id:('n' + newCount), pId:treeNode.id, name:"新建组织" + (newCount++)}); //新建节点
				fncInitForm();
				return false;
			});
		}
	};
	
	//鼠标移出节点
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	//新增和更新
	function fncAdd() {
		fncSubmit(ctx + "/organization/addOrganization"); 
	}
	
	//删除
	function fncDel() {
		rayDialogConfirm("确认删除？",function(){
			if($("#orgId").val()=="") {
				rayDialog("请选择删除项！") ;
				return ;
			}
			if(nodes != undefined){ //表示当前节点还有子节点
				rayDialog("请先删除其子节点！") ;
				return;
			}
			$.ajax({
				type : "POST",
				url : ctx + "/organization/delete",
				data : $('#form').serialize(),
				success : function(data) {
					rayDialog("删除成功！") ;
					fncInitOrg();
				}
			});
		});
	}
	
	//提交修改或者保存的菜单
	function fncSubmit(url) {
		rayDialogConfirm("确认保存？",function(){
			var params = $('#form').serialize();
			if($("#orgName").val()=="") {
				return ;
			}
			validator.bootstrapValidator('validate');//执行校验
			   if($(form).data('bootstrapValidator').isValid()){//校验通过
				//ajax操作
				$.ajax({
					type : "POST",
					url : url,
					data : params,
					success : function(data) {
						rayDialog("保存成功！") ;
						fncInitOrg();
					}
				});
			}
		});
	}
	
</script>
</head>
<body>
<div id="content" class="col-xs-12 col-sm-12">
	<rt:navigation/>
	<div class="row">
	<div class="box">
	<%@include file="/core/include/boxHead.jsp" %>
	<div id="box-content" class="col-xs-12 col-sm-12">
	<div class="form-group">
		<div class="box-content col-xs-4 col-sm-4">
		<div class="well" style="position:absolute; height:400px; width:350px; overflow:auto">
			<div class="ztreeBackground left">
				<ul id="tree" class="ztree"></ul>
			</div>
		</div>
		</div>
		<div class="box-content col-xs-8 col-sm-8">
		<div class="well">
		<form class="form-horizontal" id="form"	method="post">
		<input type="hidden" class="form-control" id="orgId" name="orgId">
		<input type="hidden" class="form-control" id="parentOrgId" name="parentOrgId">
		<input type="hidden" class="form-control" id="hospitalOrgId" name="hospitalOrgId">
		<input type="hidden" class="form-control" id="branchOrgId" name="branchOrgId">
		<div class="form-group has-feedback" id="d1">
			<label class="col-sm-2 control-label">组织名称</label>
			<div class="col-sm-4">
				<input type="text" class="form-control"  id="orgName" name="orgName" data-toggle="tooltip" placeholder="组织名称"	data-placement="bottom" title="组织名称" maxLength="200"
					data-bv-notempty="true"	
					data-bv-notempty-message="该字段不能为空">
				<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
			</div>
			<label class="col-sm-2 control-label">组织编码</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="orgCode" name="orgCode"  data-toggle="tooltip" placeholder=组织编码 data-placement="bottom" title="组织编码" maxLength="50">
			</div>
			<label class="col-sm-2 control-label">联系人</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="linkman" name="linkman" placeholder="联系人"	maxLength="50">
			</div>
			<label class="col-sm-2 control-label">联系人电话</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="linkmanPhone" name="linkmanPhone" placeholder="联系人电话" maxLength="11"
					data-bv-regexp="true"
					data-bv-regexp-regexp="^\d{11}$" 
					data-bv-regexp-message="请输入11位数字" >
			</div> 
			<label class="col-sm-2 control-label">电话</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="phone" name="phone"	placeholder="电话" maxLength="12"
					data-bv-regexp="true"
					data-bv-regexp-regexp="^\d{3}-\d{8}|\d{4}-\d{7}$" 
					data-bv-regexp-message="请输入如010-79658425或0311-5468224格式" >
			</div>
			<label class="col-sm-2 control-label">地址</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="address" name="address" placeholder="地址" maxLength="500">
			</div> 
			
		</div>
		<div class="form-group">
			<div class="col-sm-12 text-center">
				<shiro:hasPermission name="organization:delete">  
			    <button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncDel()" >
			    	删&nbsp;除
			    </button>
			    </shiro:hasPermission>
				<shiro:hasPermission name="organization:create">  
			 	<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncAdd()" >
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
</div>
<script type="text/javascript" src="${ctxStatic}/plugins/zTree/js/jquery.ztree.all.js"></script>
</body>
</html>