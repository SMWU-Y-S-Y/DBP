<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>수강신청 사용자 정보 수정</title>
</head>

<body>
<%@ include file="../top.jsp" %>

<% if (session_id==null) response.sendRedirect("../loginPage/login.jsp"); %>

<% 
Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy";
String passwd="1234"; // 비밀번호
String dbdriver = "oracle.jdbc.driver.OracleDriver";

Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();
mySQL = "select * from student where s_id = '" + session_id + "'";
ResultSet myResultSet = stmt.executeQuery(mySQL);

if (myResultSet.next()){
	String s_id = myResultSet.getString("s_id");
	String s_name = myResultSet.getString("s_name");
	String s_pwd = myResultSet.getString("s_pwd");
	String s_email = myResultSet.getString("s_email");
	String s_addr = myResultSet.getString("s_address");
%>

<form method="post" action="update_verify.jsp">
	<table width="75%" align="center" border>
	<tr><th> ID </th>
	<td><input type="text" name="studentId" size="50" value="<%=s_id%>" disabled></td></tr>
	<tr><th> Name </th>
	<td><input type="text" name="studentName" size="50" value="<%=s_name%>" disabled></td></tr>
	<tr><th> Password </th>
	<td><input type="text" name="studentPwd" size="50" value="<%=s_pwd%>"></td></tr>
	<tr><th> Email </th>
	<td><input type="text" name="studentEmail" size="50" value="<%=s_email%>"></td></tr>
	<tr><th> Address </th>
	<td><input type="text" name="studentAddr" size="50" value="<%=s_addr%>"></td></tr>
<%
} else{
	
}
stmt.close(); myConn.close();
%>
<tr><td colspan="2" align="center"><input type="submit" value="수정"></td></tr>
</table>
</form>
</body>
</html>