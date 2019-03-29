"use strict";
//DataTable js

var rayUpload = layui.upload;
$.fn.rayImgUpload=function(attchId,defaultImgId,callback,eventFired){
	var imgId = this[0].id;
	this.addClass("img-uplaod");
	this.text("");// 清空数据
	this.append("<div class=\"upload-thumb\">"+
                "<img id=\""+imgId+"_img"+"\" src=\""+ctxStatic+"/img/default_upload_image.gif\" height='160' width='160'>"+
                "</div>"+
                "<div class=\"mt-10 img-upload-btn\">"+
                "<a type=\"button\" class=\"btn btn-primary radius\" id=\""+imgId+"_btn"+"\">"+
                "	<i class=\"Hui-iconfont\">&#xe642;</i>上传图片 "+
                "</a>"+
                "</div>"); 
	
    if(defaultImgId){
    	$('#'+imgId+"_img").attr('src',ctxCdn+'/file/showImg?fileId='+defaultImgId);    
    	$('#'+imgId+"_img").click(function(){
    		fncShowImg(ctxCdn+'/file/showImg?fileId='+defaultImgId);
    	});
    }     
	rayUpload.render({
        elem:"#"+imgId+"_btn", //绑定元素
         url: ctxCdn+"/file/upload",
      accept:'images',
        data:{eventFired:eventFired},
        done: function (data) {
        	if(data.error==""){
	   	 		$('#'+attchId).val(data.fileId);
	   	 		$('#'+imgId+"_img").attr('src',ctxCdn+'/file/showImg?fileId='+data.fileId);    
	   	 		$('#'+imgId+"_img").unbind("click");
		   	 	$('#'+imgId+"_img").click(function(){
		   	 		fncShowImg(ctxCdn+'/file/showImg?fileId='+data.fileId);
		    	});
	   	 		if(typeof callback == "function")  callback();
	   	 	}
        },
       error: function () {
            //请求异常回调
        }
    }); 
}; 

function fncShowImg( url) {
	$("#imgShowDiv").remove();
	$(document.body).append("<div id='imgShowDiv' class='hide'><img src='"+url+"' height='516px' width='450px'></div>");
	
    layer.open({
        type: 1,
        title:false,
        closeBtn:0,
        shadeClose:true,
        area:['450px','516px'],
        shade:0.8,
        content: $("#imgShowDiv")
    });;
}

var raycom ={
		notifyMsg: function (body,url,menuClickId) {
	        if (!("Notification" in window)) {
	            return false;
	        }

	        var initNogification = function (url,body,menuClickId) {
	            var notification = new Notification("消息通知", {
	                body:body
	            });
	            notification.onclick = notification.onerror = function () {
	            	if($("#initNogificationHref"))
	            		$("#initNogificationHref").remove();
	            	if(url){
	            		$('<a href="'+url+'" class="modal-link" id="initNogificationHref" target="mainFrame"><span id="initNogificationTitle">跳转</span>').appendTo('body');
		                if(menuClickId)
		                	$.get(ctx + "/main/menuId/record", {menuClickId:menuClickId},function(){},"json");
		            	$("#initNogificationTitle").click();
	            	}
	                
	            };
	        };

	        if (Notification.permission === "granted") {
	            initNogification(url,body,menuClickId);
	        }

	        else if (Notification.permission !== 'denied') {
	            Notification.requestPermission(function (permission) {
	                if (permission === "granted") {
	                    initNogification(url,body,menuClickId);
	                }
	            });
	        }
	    },
	open:function (url) {
		 var iWidth=window.screen.width; //窗口宽度 
			var iHeight=window.screen.height;//窗口高度 		
			var iTop=iHeight/5/2;
			var iLeft=iWidth/20/2; 
			iWidth=iWidth - iLeft * 2; //窗口宽度 
			iHeight=iHeight - iTop * 2;//窗口高度 
			var sFeature = "height="+iHeight+"px, width="+iWidth+"px, top="+iTop+"px, left="+iLeft+", toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no";
			window.open(url,null,sFeature);
		
	}
};

function isJson(obj){
	var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length; 
	return isjson;
	}

$.fn.raySimpleTable=function(formId,columnDef,loading){
	return this.raytable(formId,{columnDef:columnDef,loading:loading,saveRealQuest:true});
}

$.fn.raytable=function(formId){
	settings={};
	
	return this.raytable(formId,settings);
} 
/**
 * columnDef,loading,saveRealQuest
 */
$.fn.raytable=function(formId,settings){
	if(!isJson(settings))
		settings={};
	var isDtRealQuest = false;
	if(settings.saveRealQuest&&settings["saveRealQuest"])
		isDtRealQuest = settings["saveRealQuest"];
	this.on( 'preXhr.dt', function ( e, settings, data ) {
		   data.isDtRealQuest = isDtRealQuest;
		} );
	this.on( 'xhr.dt', function ( e, settings, data ) {
		isDtRealQuest  = true;
	} );
	this.on( 'init.dt', function (e, settings, data  ) {
		/**
		 * jquery.dataTables.js 2624 行取消初始化方法，原因是明细页返回时，不能正确显示分页信息
		 */
		for(var key in data.sessionRdata){  
			if("drawstartlengthsearch[value]search[regex]currentUser".indexOf(key)<0&&key.indexOf("columns")<0){
				if($('#'+key).is('input')){
					$('#'+key).val(data.sessionRdata[key]);
				}
				if($('#'+key).is('select')){
					if($('#'+key).attr('class').indexOf("select2")>-1){
						$('#'+key).select2("val",data.sessionRdata[key].split(","));
					}else{
						$('#'+key).val(data.sessionRdata[key]);
					}
				}
			}
			
		} 
	});
	return this.DataTable({
      ajax: {
          url: ctx+$('#'+formId).attr("action"),
          type: "POST",
          data: function ( d ) {
          	 $("#"+formId+" :input").each(function(index,ele){
       	        if($(ele).data("query")=='yes'){
       	        	d[$(ele).attr('id')] = $(ele).val();
       	        }
          	 });
          	 $("#"+formId+" select").each(function(index,ele){
          		if($(ele).data("query")=='yes'){
         			 var val=$(ele).val();
         			 if($.isArray($(ele).val())){
         				val = $(ele).val().join(",") 
         			 }
         			 d[$(ele).attr('id')] = val;
         		 }
          	 });
          }
      },
      deferLoading:'loading' in settings?settings.loading:null,
      columns:getColomun(this),
      fixedColumns: {
    	  leftColumns:'leftColumns' in settings?settings.leftColumns:0,
          rightColumns: 'rightColumns' in settings?settings.rightColumns:1
      },
      scrollY: 'scrollY' in settings?settings.scrollY:390,
      scrollX: 'scrollX' in settings?settings.scrollX:true,
      fixedHeader:'fixedHeader' in settings?settings.fixedHeader:true,
      columnDefs: getColomunDefs(this,settings["columnDef"]),
      pageLength:'pageLength' in settings?settings.pageLength:10
  });
}

function sortIndex(x, y) {
    return (x.inx < y.inx) ? -1 : 1

}
//表头
function getColomun(oTb){
	  var jsonarray = eval('([])');
	  var arr="";
	  var i=0;
	  oTb.find("th").each(function(index,ele){
		 if($(ele).data("column")&&$(ele).data("column")!=''&&$(ele).data("column")!='op'){
			 arr ={"data":$(ele).data("column"),"inx":$(ele).data("inx")?$(ele).data("inx"):i++};
			 jsonarray.push(arr);
		 }
	     else if($(ele).data("column")=='op'){
	     	 arr ={"data":null,"defaultContent": '',"inx":$(ele).data("inx")?$(ele).data("inx"):i++};
	    	 jsonarray.push(arr);
	     }
	  });
		 return jsonarray.sort(sortIndex);
};
//按钮
function getColomunDefs(oTb,columnDef){
	var iconClass={
		"del":"fa fa-trash-o",
		"detail":"fa fa-file-text-o",
		"save":"fa fa-save (alias)",
		"history":"fa fa-clock-o",
		"add":"fa fa-fa-plus-square",
		"edit":"fa fa-edit"
	};
	if(!columnDef)
		columnDef = [];
	var item;
	oTb.find("th").each(function(index,ele){
		if($(ele).data("method")){
			var arr =eval($(ele).data("method"));
			if(arr.length>0){
				item= {targets: arr[0].targets,
						render: function (data, type, row) {
							var context = "";
							for ( var fnc in arr) {
								if(arr[fnc].htmlAppend){
									var htmlAppend = arr[fnc].htmlAppend;
									if(arr[fnc].replace){
										var paramsItem =arr[fnc].params.split(","); 
										for (i=0;i<paramsItem.length ;i++ ){ 
										 htmlAppend = htmlAppend.replace(new RegExp(paramsItem[i],'gm') ,row[paramsItem[i]]);
										} 
									}else if(arr[fnc].params){
										htmlAppend = htmlAppend.replace('>' ," value='"+row[arr[fnc].params]+"'>");
									}
									context +=htmlAppend;
								}else{
									if(!arr[fnc].icon){
										arr[fnc].icon="detail"
									}
									context+= "<a href=\"javascript:;\" style=\"padding-left: 7px;padding-right: 5px;font-size:18px\"  " ;
									if(arr[fnc].fncName)
										context+=" onclick=\""+arr[fnc].fncName+"(";
									if(arr[fnc].params){
										var paramsAry = (arr[fnc].params).split(',');
										for (var i = 0; i < paramsAry.length; i++) {
											if(i==0)
												context+="'"+row[paramsAry[i]]+"'";
											else
												context+=",'"+row[paramsAry[i]]+"'";
										}
									}
									if(iconClass[arr[fnc].icon])
										context+=")\" title=\""+arr[fnc].title+"\" ><i class=\""+iconClass[arr[fnc].icon]+"\" ></i></a>";
									else 
										context+=")\" title=\""+arr[fnc].title+"\" ><i class=\""+arr[fnc].icon+"\" ></i></a>";
									
								}
							}
							return context;
						}
				}	
				//columnDef.push(item);
				if(arr[0].className)
					item["className"]= arr[0].className;
				columnDef.push(item);
			}//end if length
		}//end if menthod
		
		if($(ele).data("columndefs")){
			var arr =eval($(ele).data("columndefs"));
			if(arr.length>0){
				item= {"targets": arr[0].targets}				  
				if(arr[0].className)
					item["className"]= arr[0].className;
				if(arr[0].visible)
					item["visible"]= arr[0].visible;
				columnDef.push(item);
			}//end if length
		}//end if columnDefs
		
	});
	return columnDef;
};

$.fn.rayDatePicker=function(){
	return this.datepicker({dateFormat: 'yy-mm-dd', changeYear: true,          // 年下拉菜单  
	         changeMonth: true,             // 月下拉菜单  
	         showButtonPanel: true,         // 显示按钮面板  
	         showMonthAfterYear: true,  // 月份显示在年后面 
	         fontAwesome:true,
	         currentText: "今日",         // 当前日期按钮提示文字  
	         closeText: "清空"}); 
}; 
$.fn.rayfileupload=function(attchId,callback,eventFired){
	return this.fileupload({
	    multipart: true,
	    url: ctxCdn+"/file/upload",
	    add: function (e, data) {
	    	if(eventFired)
	    		data.formData = {eventFired: eventFired,sysName:"usc"}
	      	data.submit();
	    },
	    done: function (e, data) {
	    	if(data.result.error!=""){
	    		rayDialog(data.result.error)
	   	 	}else{
	   	 		$('#'+attchId).val(data.result.fileId);
	   	 		$('#'+attchId).next("#uploadContent").remove();
	   	 		$('#'+attchId).after('<div id="uploadContent"><a href="'+ ctxCdn+'/file/download?fileId='+data.result.fileId+'" target="_blank">'+data.files[0].name+'</a></div>');
	   	 	 if(typeof callback == "function")  callback();
	   	 	}
	    },
	    fail: function (e, data) {
	    }
	}).on('fileuploadprocessalways', function (e, data) {
	    var currentFile = data.files[data.index];
	    if (data.files.error && currentFile.error) {
	        rayDialog(currentFile.error);
	    }
	}); 
}; 

$.fn.raymultiplefileUpload=function(fileList){
	return this.fileinput({
	     	language: 'zh', 
			'theme': 'explorer',
			uploadAsync:true,
			browseClass:"btn btn-primary btn-xs",
			removeClass:"btn btn-default btn-xs",
			uploadClass:"btn btn-default btn-xs",
			cancelClass:"btn btn-default btn-xs",
			uploadUrl: ctxCdn+"/file/upload", 
        }).on("filebatchselected", function(event, files) {
            $(this).fileinput("upload");
        }).on('fileuploaded', function(event, data, previewId, index) {
        	fileList.push({ fileId: data.response.fileId, KeyID: previewId })
	    }).on("filesuccessremove", function (event, data, previewId, index) { 
	    	 for (var i = 0; i < fileList.length; i++) { 
	    	      if (fileList[i].KeyID== data) { 
	    	    	  fileList.splice(i,1);
		    	      return;
	    	      } 
	    	   }
		}).on('fileclear', function(event) {	
			fileList.length = 0;
		});
}; 

$.fn.materialCategoryRadioTree=function(data){
	data.url = "/popup/materialCategoryPopup";
	window.treeLvl = 6;
	this.radioTree(data);
}
$.fn.materialCategory10RadioTree=function(data){
	data.url = "/popup/materialCategory10Popup";
	this.radioTree(data);
}

$.fn.orgRadioTree=function(data){
	data.url = "/popup/orgPopup";
	this.radioTree(data);
}

$.fn.radioTree=function(data){
	var selectedValue=data.values;
	var id=data.id;
	var name=data.name?data.name:this[0].id;
	var url=data.url;
	var defaultData=data.defaultData;
	window.selectedValue = selectedValue;
	window.defaultData = defaultData;
	window.dataUrl = url;
	var treeLvl="";
	if(window.treeLvl) 
		treeLvl = window.treeLvl;
	this.on('click', function () {
		if(window.treeLvl&&treeLvl!=window.treeLvl){
			treeLvl =window.treeLvl;
			popup.remove();
		}
		window.popup =dialog({
			id: id+'-dialog',
			align: 'bottom left',
		    width: 400,
		    height: 400,
		    padding: 0, 
			url: ctx+'/popup/radio',
			quickClose: true,
			onshow: function () { 
			},
			oniframeload: function () {
			},
			onclose: function () {
				if (this.returnValue) {
					$('#'+name).val(this.returnValue.name);
					$('#'+id).val(this.returnValue.id);
					window.selectedValue = this.returnValue.id;
				}
			},
			onremove: function () {
			}
		});
		popup.show(this);
	});
}; 


$.fn.materialCategoryCheckboxTree=function(data){
	data.url = "/popup/materialCategoryPopup";
	window.treeLvl = 6;
	this.checkboxTree(data);
}

$.fn.materialCategory10CheckboxTree=function(data){
	data.url = "/popup/materialCategory10Popup";
	this.checkboxTree(data);
}



$.fn.orgCheckboxTree=function(data){
	data.url = "/popup/orgPopup";
	this.checkboxTree(data);
}

$.fn.checkboxTree=function(data){
	var selectedValue=data.values;
	var id=data.id;
	var name=data.name?data.name:this[0].id;
	var url=data.url;
	var defaultData=data.defaultData;
	
	/*var strArr = selectedValue.split(",")
	for(var i = 0;i < strArr.length;i++){
		window.selectedValue = strArr[i];
	}*/
	window.selectedValue = selectedValue;
	window.defaultData = defaultData;
	window.dataUrl = url;
	var treeLvl="";
	if(window.treeLvl) 
		treeLvl = window.treeLvl;
	this.on('click', function () {
		if(window.treeLvl&&treeLvl!=window.treeLvl){
			treeLvl =window.treeLvl;
			popup.remove();
		}
		window.popup =dialog({
			id: id+'-dialog',
			align: 'bottom left',
		    width: 400,
		    height: 400,
		    padding: 0, 
			url: ctx+'/popup/checkbox',
			quickClose: true,
			onshow: function () { 
			},
			oniframeload: function () {
			},
			onclose: function () {
				if (this.returnValue) {
					$('#'+name).val(this.returnValue.name);
					$('#'+id).val(this.returnValue.id);
					window.selectedValue = this.returnValue.id;
				}
			},
			onremove: function () {
			}
		});
		popup.show(this);
	});
	
	
}; 

