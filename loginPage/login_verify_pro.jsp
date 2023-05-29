<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>

<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");
String mode = "prof";

Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "c##ysy";
String passwd = "1234";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
	Class.forName(dbdriver);//jdbc 드라이버 로딩
	myConn=DriverManager.getConnection(dburl, user, passwd);//jdbc드라이버를 이용한 데이터베이스 연결
} catch(ClassNotFoundException e){
	System.out.println("driver 로딩 실패");
} catch(SQLException e){
	System.out.println("오라클 연결 실패");
}
stmt = myConn.createStatement();
mySQL="select p_id from professor where p_id='" + userID + "'and p_pwd='" + userPassword + "'";	
ResultSet myResultSet = stmt.executeQuery(mySQL);
if(myResultSet.next()){
	session.setAttribute("user",userID);
	session.setAttribute("mode",mode);
	response.sendRedirect("../mainPage/main.jsp");
}else {
%>
<script>
alert("사용자 아이디 혹은 암호가 틀렸습니다");
location.href="login.jsp";
</script>
<%
}
stmt.close();
myConn.close();
%>
