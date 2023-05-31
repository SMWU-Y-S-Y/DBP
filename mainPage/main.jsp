<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
	<title>데이터베이스를 활용한 수강신청 시스템입니다.</title>
	<link rel='stylesheet' href='../css/main.css' />
</head>

<body>
<%@ include file="../top.jsp" %>

<table id="main_table" width="75%" align="center" height="70%">

<% if (session_id != null) { %>

<tr>
	<td align="center"><img src="../image/2.gif"></td>
	<td align="center"><%=user_name%>님 방문을 환영합니다.</td>
	<td align="center"><img src="../image/1.gif"></td>
</tr>
<% } else { %>
<tr>
	<td align="center">로그인한 후 사용하세요.</td>
</tr>

<%
}
%>
</table>
</body>
</html>