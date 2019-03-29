<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>菜单管理</TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%@include file="/core/include/head.jsp"%>
<title>菜单管理</title>
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/bootstrapStyle/bootstrapStyle.css" type="text/css">
<script type="text/javascript">
	$(document).ready(function() {
		 validator = $('#form').bootstrapValidator();//ajax提交时使用
		 $(':input') .attr({"readonly":true});
	});
	
	var rows = 0 ;
	var index=0;
	//新建菜单内置需要,用于js控制使用,实际存入数据库时由数据库单独处理
	var newCount = 1;
	
	var setting = {
		view: {
			addHoverDom: addHoverDom,//鼠标移动到节点上
			removeHoverDom: removeHoverDom,//鼠标移出节点上
			dblClickExpand: dblClickExpand//鼠标点击事件
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
	
	$(function() {
		fncInitMenu();
	});
	
	//点击添加表格
	function Addline(){
		if(parseInt($("tbody tr:last-child").attr("id"))>0){
			index=parseInt($("tbody tr:last-child").attr("id"))+1;
		}else{
			index=index+1;
		}
		
		var trHTML ="<tr id="+index+"><td>"+index+"</td><td><input type='text' style='width:88%;' name='permissionCode' placeholder='权限编码'  value=''/></td><td> <input type='text' style='width:88%;' placeholder='权限名称' name='permissionName'  value=''/></td><td><a href='javascript:;' style='padding-left:7px;padding-right:5px;font-size:18px;' title='删除' onclick='fncDelButton("+index+")'><i class='fa fa-trash-o'></i></a></td></tr>";
		$("#tab").append(trHTML); 
	}
	
	//删除按钮
	function fncDelButton(index){
		rayDialogConfirm("确认删除？",function(){
			$.ajax({
				type : "POST",
				url : ctx+"/menu/delButton",
				data : {
					menuId:$("#menuId").val(),
					permissionCode:$("#"+index+" td:nth-child(2)>input").val()
				},
				success : function(data) {
					rayDialog("删除成功！");
				}
			});
			$("#"+index+"").remove();
		});
	}
	
	//新增和更新
	function fncAdd() {
		var rows= document.getElementById("tab").rows.length;
		for(var i=1;i<rows;i++){
			var name1 = $("#tab tr").eq(i).children("td:eq(1)").find("input").val() ;
			if(name1==""){
				rayDialog("权限编码不能为空！");
				return;
			}
		}
		for(var i=1;i<rows;i++){
			var name1 = $("#tab tr").eq(i).children("td:eq(1)").find("input").val() ;
			for(var j=i+1;j<rows;j++){
				var name2 = $("#tab tr").eq(j).children("td:eq(1)").find("input").val() ;
					if(name1==name2){
						rayDialog("有重复的权限编码");
						return;
					}
			}
		}
		if(rows>1){
			if($("#permission").val()==""){
				rayDialog("权限标识不能为空！");
				return;
			}
		}
		fncSubmit(ctx + "/menu/update");
	}
	
	//删除
	function fncDel() {
		if ($("#menuId").val() != ""){
			rayDialogConfirm("确认要删除当前菜单？",function(){
				$("tbody").remove();
				fncSubmit(ctx + "/menu/del");
			});
		}
	}
	
	//提交修改或者保存的菜单
	function fncSubmit(url) {
		validator.bootstrapValidator('validate');//执行校验
		if($(form).data('bootstrapValidator').isValid()){//校验通过
			$.ajax({
				type : "POST",
				url : url,
				data : $('#form').serialize(),
				success : function(data) {
					if(data == "saveOk"){
						rayDialog("保存成功！");
					}
					$("tbody").remove();
					actCancel($('#form'), ctx + "/menu");
				}
			});
		}
	}
	
	//鼠标单击执行的事件
	function fncTreeNodeClick(event, treeId, treeNode) {
		if(treeNode.id=='1000000'){
			 $(':input') .attr({"readonly":true});
			fncInitForm();
			return;
		}
		
		//如果节点的id以"n"开头,则是新增节点,查询其父节点数据
		//如果其父节点的以"n"开头,代表父节点也是新增节点,直接返回(该种情况不应该出现,不进行处理)
		$(':input') .attr({"readonly":false});
		$("input[name=parentName]").attr({"readonly":true});
		var params;
		if(treeNode.id.charAt(0)!='n'){
			params = {"menuId" : treeNode.id};
		}else if(treeNode.pId.charAt(0)!='n'){
			params = {"menuId" : treeNode.pId};
		}else{
			return;
		}
		$.get(ctx + "/menu/searchById",params,
			function(data,status){
			$("#isShow1").removeAttr("checked");
			$("#isShow2").removeAttr("checked");
			if(treeNode.id.charAt(0)=='n'){//新增节点
					fncInitForm();
					$("input[name=isShow]").get(0).checked=true;
					$("#parentId").val(data.menuId);
					$("#parentName").val(data.name);
				}else{//修改节点
					$("#menuId").val(data.menuId);
					$("#name").val(data.name);
					$("#parentId").val(data.parentId);
					$("#parentName").val(data.parentName);
					$("#remarks").val(data.remarks);
					$("#href").val(data.href);
					$("#icon").val(data.icon);
					$("#target").val(data.target);
					$("#sort").val(data.sort);
					$("#permission").val(data.permission);
					if (data.isShow == "Y") {
						$("input[name=isShow]").get(0).checked=true;
					} else {
						$("input[name=isShow]").get(1).checked=true;
					}
				}
				
			}
		);
		//获取该菜单下所有按钮
		index=0;
		$("tbody").remove();
	 	$.ajax({
			url: ctx+"/menu/selectButton",
			data: { menuId: treeNode.id},
			type: "POST",
			success: function(data){
				for (var i=0 ; i<data.length ; i++){
					var index=i+1;
					var trHTML ="<tr id="+index+"><td>"+index+"</td><td><input type='text' style='width:88%;' name='permissionCode'   value='"+data[i].permissionCode+"'/></td><td> <input type='text' style='width:88%;' name='permissionName'  value='"+data[i].permissionName+"'/></td><td><a href='javascript:;' style='padding-left:7px;padding-right:5px;font-size:18px;' title='删除' onclick='fncDelButton("+index+")'><i class='fa fa-trash-o'></i></a></td></tr>";
					$("#tab").append(trHTML);
				} 
			 },
			 error:function(){
				 rayDialog("请求失败！");
			 }
		});  
	 	var rows= document.getElementById("tab").rows.length;
	};
	
	//初始化
	function fncInitMenu() {
		$.ajax({
			async : false,
			cache : false,
			type : "post",
			url : ctx + "/menu/getAllNode",
			success : function(data) {
				zTree = $.fn.zTree.init($("#tree"), setting, data);
				zTree.expandNode(zTree.getNodes()[0],true,false,true);
				fncInitForm() 
			},
			error : function() {
				rayDialog("请求失败")
			}
		});
	}
	
	//初始化门户
	function fncInitForm() {//清空编辑区
		 $(':input','#form')  
		 .not(':button, :submit, :reset, :hidden, :radio')  
		 .val('') ;  
		$("#menuId").val('');
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
				zTree.addNodes(treeNode, {id:('n' + newCount), pId:treeNode.id, name:"新建菜单" + (newCount++)});
				fncInitForm();
				$("#parentId").val(treeNode.id);
				$("#parentName").val(treeNode.name);
				return false;
			});
		}
	};
	
	//鼠标移出节点
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
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
						<form class="form-horizontal" id="form"	 method="post">
							<div class="form-group has-feedback">
								<label class="col-sm-2 control-label">菜单名称</label>
								<div class="col-sm-4">
									<input type="hidden" class="form-control" readonly="readonly" id="menuId" name="menuId">
									<input type="text" class="form-control" placeholder="菜单名称" id="name" name="name" data-toggle="tooltip"	data-placement="bottom" title="菜单名称" 
										data-bv-notempty="true" 
										data-bv-notempty-message="该字段不能为空" 
										data-bv-stringlength="true" 
										data-bv-stringlength-max="80" 
										data-bv-stringlength-message="该字段输入长度在不能超过80">									
									<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
								</div>
								<label class="col-sm-2 control-label">父级菜单</label>
								<div class="col-sm-4">
									<input type="hidden" class="form-control" placeholder="父级菜单" id="parentId" name="parentId"  >
									<input type="text" class="form-control" readonly="readonly"	id="parentName" name="parentName"  data-toggle="tooltip" data-placement="bottom" title="父级编码">
								</div>
							</div>
							<div class="form-group has-feedback">
								<label class="col-sm-2 control-label">菜单url</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" placeholder="菜单url" id="href" name="href" 
										data-bv-stringlength="true" 
										data-bv-stringlength-max="600" 
										data-bv-stringlength-message="该字段输入长度在不能超过600"
										data-bv-regexp="true"
										data-bv-regexp-regexp="(^/([a-zA-z]+))+"
										data-bv-regexp-message="请输入/xxx或/../xxx/xxx格式">
								</div>
							</div>
							<div class="form-group has-feedback">
								<label class="col-sm-2 control-label">菜单描述</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="remarks" placeholder="菜单描述" name="remarks" 
										data-bv-stringlength="true" 
										data-bv-stringlength-max="150" 
										data-bv-stringlength-message="该字段输入长度在不能超过150" >
								</div>
							</div>
							<div class="form-group has-feedback">
								<label class="col-sm-2 control-label">菜单序号</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" placeholder="菜单序号" id="sort" name="sort"
									data-bv-notempty="true"
									data-bv-notempty-message="该字段不能为空"
									data-bv-regexp="true"
									data-bv-regexp-regexp="^[0-9]+$"
									data-bv-regexp-message="请输入数字！">
									<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
								</div>
								<label class="col-sm-2 control-label" >权限标识</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" placeholder="权限标识" id="permission" name="permission" 
										data-bv-stringlength="true" 
										data-bv-stringlength-max="60" 
										data-bv-stringlength-message="该字段输入长度在不能超过60">
								</div> 
							</div>
							<div class="form-group has-feedback">
								<label class="col-sm-2 control-label">图标</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" placeholder="图标" id="icon" name="icon" 
										data-bv-stringlength="true" 
										data-bv-stringlength-max="150" 
										data-bv-stringlength-message="该字段输入长度在不能超过150">
								</div> 
								<label class="col-sm-2 control-label">是否可用</label>
								<div class="col-sm-4" style="padding-top:3px;">
									<input type="radio" name="isShow" id="isShow1" value="Y"checked />在用
									<input type="radio" name="isShow" id="isShow2" value="N"  />禁用
								</div>
							</div>
							<div class="form-group text-left" style="padding-bottom:4px;margin-top:4px; border-top: 1px solid #ccc;">
								<label class="col-sm-2 control-label" style="margin-top:8px;">按钮权限</label>
								<div class="col-sm-4">
									<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="Addline()">添加权限</button>
								</div>
							</div>
							<div class="form-group has-feedback">
									<table class="table table m-table table-bordered table-hover table-heading" id="tab">
										<thead>
											<tr>
												<th>序号</th>
												<th>权限编码</th>
												<th>权限名称</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody></tbody>
									</table>
							</div>
							<div class="form-group">
								<div class="col-sm-12 text-center btn-raycom-search">
									<shiro:hasPermission name="menu:create">
					   					<button type="button" class="btn btn-default btn-xs btn-raycom" id="button" onclick="fncAdd()">
											保&nbsp;存
					   					</button>
					   				 </shiro:hasPermission> 
									<shiro:hasPermission name="menu:delete">
										<button type="button" class="btn btn-default btn-xs btn-raycom" onclick="fncDel()">
											删&nbsp;除
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