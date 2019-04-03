<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>查看图片</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
</script>
</head>
<body>
	<a href="${fns:getConfig('cdn.url')}/file/download?fileId=${img.attachId}" target="_blank" >
		<img src="${fns:getConfig('cdn.url')}/file/showImg?fileId=${img.attachId}"  width="100%" height="100%"/>
	</a>
</body>
</html>
