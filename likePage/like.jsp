<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title> 찜목록 조회 </title>
<link rel='stylesheet' href='../css/main.css' />
<script>
	function onSelect(){
		var formS = document.getElementById("selectForm");
		var selectYear = formS.selectYear.value;
		var selectSem = formS.selectSem.value;
		location.href = "select.jsp?selectYear="+selectYear+"&selectSem="+selectSem;
	}
</script>
</head>

<body>
<%@ include file="../top.jsp" %>

<% if (session_id==null) response.sendRedirect("../loginPage/login.jsp"); %>

<table id="delete_table" width="75%" align="center">
<br>
<tr>
	<th>과목번호</th><th>분반</th><th>과목명</th><th>담은 인원</th><th>찜 취소</th>
</tr>

<%
String sId = (String)session.getAttribute("user");
//String selectYear = request.getParameter("selectYear");
//String selectSem = request.getParameter("selectSem");

int sYear = 0;
int sSem = 0;
int nTotalUnit = 0;
int nTotalCnt = 0;
%>

<%
Connection myConn = null;
Statement stmt = null;
Statement stmt2 = null;
String mySQL = null;
String mySQLtwo = null;

String dburl="jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy";
String passwd="1234";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
	stmt=myConn.createStatement();
	stmt2=myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}

mySQL = "select l.c_id, l.c_id_no, c.c_name from liked l, course c where l.s_id = '" + sId + "' and c.c_id = l.c_id and c.c_id_no = l.c_id_no";
mySQL += " order by length(l.c_id), l.c_id, l.c_id_no";
ResultSet myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		mySQLtwo= "select COUNT(*) as tot from liked where c_id = '" + c_id+"' and c_id_no = '"+c_id_no+"'";
		String c_name = myResultSet.getString("c_name");
		int ismain = 0;
		int totlike = 0;
		ResultSet myResultSet1 = stmt2.executeQuery(mySQLtwo);
		if(myResultSet1!=null){
			while(myResultSet1.next()){
				totlike= myResultSet1.getInt("tot");
			}			
		}
%>
<tr>
	<td align="center"><%= c_id %></td> 
	<td align="center"><%= c_id_no %></td>
	<td align="center"><%= c_name %></td>
	<td align="center"><%= totlike %></td>
	<td align="center"><a id="heart" href="deletelike_verify.jsp?c_id=<%= c_id %>&main=<%= ismain %>&c_id_no=<%= c_id_no %>">♥</a></td>
</tr>
<%
	}
}
stmt.close();
stmt2.close();
myConn.close();
%>

</table>
	

</body>
</html>
