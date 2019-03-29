<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="box-header">
	<div class="box-name">
		<span><%=request.getParameter("title")==null?"":request.getParameter("title")%></span>
	</div>
	<div class="box-icons">
		<a class="collapse-link">
			<i class="fa fa-chevron-up"></i>
		</a>
		<a class="expand-link">
			<i class="fa fa-expand"></i>
		</a>
	</div>
	<div class="no-move"></div>
</div>