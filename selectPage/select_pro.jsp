<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title> 수업과목 조회 </title>
<script>
	function onSelect(){
		var formS = document.getElementById("selectForm");
		var selectYear = formS.selectYear.value;
		var selectSem = formS.selectSem.value;
		location.href = "select_pro.jsp?selectYear="+selectYear+"&selectSem="+selectSem;
	}
</script>
</head>

<body>
<%@ include file="../top.jsp" %>

<% if (session_id==null) response.sendRedirect("../loginPage/login.jsp"); %>

<table width="75%" align="center" border>
<br>
<tr>
	<th>과목번호</th><th>분반</th><th>과목명</th><th>강의시간</th><th>강의장소</th><th>학점</th>
</tr>

<%
String pId = (String)session.getAttribute("user");
String selectYear = request.getParameter("selectYear");
String selectSem = request.getParameter("selectSem");

int sYear = 0;
int sSem = 0;
//int nTotalUnit = 0;
//int nTotalCnt = 0;
%>

<%
Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl="jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy";
String passwd="1234";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
	stmt=myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}


if ((selectYear == null || selectYear.equals("")) && (selectSem == null || selectSem.equals(""))){
	mySQL = "select t.c_id, t.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from course c, teach t where t.p_id = '" + pId + "'";
}
else if (selectSem == null || selectSem.equals("")){
	sYear = Integer.parseInt(selectYear);
	mySQL = "select t.c_id, t.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from course c, teach t where t.p_id = '" + pId + "' and t.t_year = " + sYear;
}
else if (selectYear == null || selectYear.equals("")){
	sSem = Integer.parseInt(selectSem);
	mySQL = "select t.c_id, t.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from course c, teach t where t.p_id = '" + pId + "' and t.t_semester = " + sSem;
}
else{
	sYear = Integer.parseInt(selectYear);
	sSem = Integer.parseInt(selectSem);
	
	mySQL = "select t.c_id, t.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from course c, teach t where t.p_id = '" + pId + "' and t.t_year = " + sYear + "and t.t_semester = " + sSem;
}

mySQL += "and c.c_id = t.c_id and c.c_id_no = t.c_id_no";
mySQL += " order by t.t_year DESC, t.t_semester DESC, length(t.c_id), t.c_id, t.c_id_no";

ResultSet myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		int c_unit = myResultSet.getInt("c_unit");
		String t_time = myResultSet.getString("t_time");
		String t_location = myResultSet.getString("t_location");
		System.out.println("결과출력");
		System.out.println(c_name);
		System.out.println(c_unit);	
		System.out.println(t_time);
		System.out.println(t_location);	
%>
<tr>
	<td align="center"><%= c_id %></td>
	<td align="center"><%= c_id_no %></td>
	<td align="center"><%= c_name %></td>
	<td align="center"><%= t_time %></td>
	<td align="center"><%= t_location %></td>
	<td align="center"><%= c_unit %></td>
	
</tr>
<%
	}
}
stmt.close(); myConn.close();
%>

</table>

<br><br><br>
<div align="center">
<form method="post" width="75%" align="center" id="selectForm" action="select.jsp">
<input type="text" name="selectYear" <%if (selectYear != null){ %> value = <%=selectYear%><% } %>>년도
<input type="text" name="selectSem" <%if (selectSem != null){ %> value = <%=selectSem%><% } %>>학기
<input type="button" value="조회" onclick="onSelect()">
</form>

</div>
</body>
</html>
