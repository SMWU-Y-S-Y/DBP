<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title> 수강신청 사용자 정보 수정 </title>
</head>

<body>
<%
request.setCharacterEncoding("UTF-8");
String studentId = (String)(session.getAttribute("user"));
String studentPwd = request.getParameter("studentPwd");
String studentEmail = request.getParameter("studentEmail");
String studentAddr = request.getParameter("studentAddr");

Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy";
String passwd="1234"; // 비밀번호
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
	stmt=myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}

try {
	mySQL ="update student set s_pwd='" + studentPwd + "', s_email='" + studentEmail + "', s_address='" + studentAddr +"' where s_id="+studentId+"";
	stmt.execute(mySQL);
%>

<script>
	alert("학생정보가 수정 되었습니다. ");
	location.href="update.jsp";
</script>

<%
} catch(SQLException ex) {
	String sMessage;
	if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다";
	else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
	else sMessage="잠시 후 다시 시도하십시오";
%>

<script>
	alert("<%=sMessage%>");
	location.href="update.jsp";
</script>

<%
}
finally{
	if(stmt!=null)
		try{stmt.close(); myConn.close();}
	catch(SQLException ex) { }
}
%>
</body></html>