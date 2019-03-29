"use strict";

function isJson(obj){
	var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length; 
	return isjson;
}

var raylayer ={
	dialog:function(url,option){
		if(!isJson(option))
			option={};
		var defalut={
				  type: 2,
				  title: "   ",
				  closeBtn: 1, 
				  maxmin: true, 
				  shade: false,
				  shadeClose: true,
				  area: ['900px', '450px'],
				  anim: 2,
				  content:url
				};
		option = $.extend(defalut,option)
		var index = layer.open(option);
		 var body = layer.getChildFrame('body', index);
		 body.find('#content').css("min-height",$(window).height());
		return index;
	},
	
	reSize:function(index){
		if(index){
			 var body = layer.getChildFrame('body', index);
			 body.find('#content').css("min-height",$(window).height());
		}else{
			$("#content").css("min-height",$(window).height());
		}
	},
	alert:function(content,yes){
		var type = typeof yes === 'function';
		if(type)
			layer.alert(content,yes);  
		else
			layer.alert(content);  
	},
	
	confirm:function(content,yes,no){
		layer.confirm(content, {
			  btn: ['同意','取消'] //按钮
			}, function(index){
				layer.close(index);
				if(yes&&typeof yes == "function"){
					yes.call();
				}
			}, function(index){
				layer.close(index);
				if(no&&typeof no == "function"){
		    		no.call();
		    	}
			});
	},
	  //formType: 1, //输入框类型，支持0（文本）默认1（密码）2（多行文本）
	prompt:function(content,formType,fnc){
		if(typeof formType === 'function') {
			fnc = formType;;
			formType=1;
		}
		layer.prompt({title: content, formType: formType}, function(text, index){
			  layer.close(index);
			  fnc(text);
			})
	}
};


function rayDialog(content,yes){
	raylayer.alert(content,yes);  
};

function rayAlert(content){
	raylayer.alert(content);  
};


function rayDialogConfirm(content,yes,no){
	raylayer.confirm(content,yes,no);  
};