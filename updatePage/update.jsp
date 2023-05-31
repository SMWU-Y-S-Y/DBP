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
ResultSet myResultSet = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy";
String passwd="1234"; // 비밀번호
String dbdriver = "oracle.jdbc.driver.OracleDriver";

Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();

/* student mode */
if (stu_mode == true){
	mySQL = "select * from student where s_id = '" + session_id + "'";
	myResultSet = stmt.executeQuery(mySQL);

	if (myResultSet.next()){
		String updateId = myResultSet.getString("s_id");
		String updateName = myResultSet.getString("s_name");
		String updatePwd = myResultSet.getString("s_pwd");
		String updateEmail = myResultSet.getString("s_email");
		String updateAddr = myResultSet.getString("s_address");
		
		int idx = updateEmail.lastIndexOf("@");
		String emailId = updateEmail.substring(0, idx);
		String emailDomain = updateEmail.substring(idx+1);
		
	%>
	
	<form method="post" action="update_verify.jsp">
		<table width="75%" align="center" border>
		<tr><th> ID </th>
		<td><input type="text" name="updateId" size="50" value="<%=updateId%>" disabled></td></tr>
		<tr><th> Name </th>
		<td><input type="text" name="updateName" size="50" value="<%=updateName%>" disabled></td></tr>
		<tr><th> Password </th>
		<td><input type="text" name="updatePwd" size="50" value="<%=updatePwd%>"></td></tr>
		<tr><th> Email </th>
		<td>
			<input type="text" name="updateEmailId" size="50" value="<%=emailId%>">@
			<input type="text" name="updateEmailDomain" size="50" value="<%=emailDomain%>">
		</td></tr>
		<tr><th> Address </th>
		<td><input type="text" name="updateAddr" size="50" value="<%=updateAddr%>"></td></tr>
	<%
	} else{
		
	}
}
/* professor mode */
else {
	mySQL = "select * from professor where p_id = '" + session_id + "'";
	myResultSet = stmt.executeQuery(mySQL);

	if (myResultSet.next()){
		String updateId = myResultSet.getString("p_id");
		String updateName = myResultSet.getString("p_name");
		String updatePwd = myResultSet.getString("p_pwd");
		String updateEmail = myResultSet.getString("p_email");
		
		int idx = updateEmail.lastIndexOf("@");
		String emailId = updateEmail.substring(0, idx);
		String emailDomain = updateEmail.substring(idx+1);
	%>

	<form method="post" action="update_verify.jsp" id="updateForm">
		<table width="75%" align="center" border>
		<tr><th> ID </th>
		<td><input type="text" name="updateId" size="50" value="<%=updateId%>" disabled></td></tr>
		<tr><th> Name </th>
		<td><input type="text" name="updateName" size="50" value="<%=updateName%>" disabled></td></tr>
		<tr><th> Password </th>
		<td><input type="text" name="updatePwd" size="50" value="<%=updatePwd%>"></td></tr>
		<tr><th> Email </th>
		<td>
			<input type="text" name="updateEmailId" size="50" value="<%=emailId%>">@
			<input type="text" name="updateEmailDomain" size="50" value="<%=emailDomain%>">
		</td></tr>
	<%
	} else{
		
	}
}


stmt.close(); myConn.close();
%>
<tr><td colspan="2" align="center"><input type="submit" value="수정") ></td></tr>
</table>
</form>
</body>
</html>