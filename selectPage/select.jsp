<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
	<link rel='stylesheet' href='../css/main.css' />
	<title> 수강신청 조회 </title>
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

<table id="select_table" width="75%" align="center">
	<tr>
	<th>과목번호</th><th>분반</th><th>과목명</th><th>강의시간</th><th>강의장소</th><th>학점</th>
	</tr>

<%
String sId = (String)session.getAttribute("user");
String selectYear = request.getParameter("selectYear");
String selectSem = request.getParameter("selectSem");

int sYear = 0;
int sSem = 0;
int nTotalUnit = 0;
int nTotalCnt = 0;
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
	mySQL = "select e.c_id, e.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from enroll e, course c, teach t where e.s_id = '" + sId + "'";
}
else if (selectSem == null || selectSem.equals("")){
	sYear = Integer.parseInt(selectYear);
	mySQL = "select e.c_id, e.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from enroll e, course c, teach t where e.s_id = '" + sId + "' and e.e_year = " + sYear;
}
else if (selectYear == null || selectYear.equals("")){
	sSem = Integer.parseInt(selectSem);
	mySQL = "select e.c_id, e.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from enroll e, course c, teach t where e.s_id = '" + sId + "' and e_semester = " + sSem;
}
else{
	sYear = Integer.parseInt(selectYear);
	sSem = Integer.parseInt(selectSem);
	
	mySQL = "select e.c_id, e.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location from enroll e, course c, teach t where e.s_id = '" + sId + "' and e.e_year = " + sYear + "and e_semester = " + sSem;
}

mySQL += "and e.c_id = c.c_id and e.c_id_no = c.c_id_no and c.c_id = t.c_id and c.c_id_no = t.c_id_no and e.e_year = t.t_year and e.e_semester = t.t_semester";
mySQL += " order by e.e_year DESC, e.e_semester DESC, length(e.c_id), e.c_id, e.c_id_no";
ResultSet myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		int c_unit = myResultSet.getInt("c_unit");
		String t_time = myResultSet.getString("t_time");
		String t_location = myResultSet.getString("t_location");
		
		nTotalCnt += 1;
		nTotalUnit += c_unit;
%>
<tr>
	<td align="center"><%= c_id %></td> 
	<td align="center"><%= c_id_no %></td>
	<td align="center"><%= c_name %></td>
	
	<td align="center"><%= t_time %></td>
	<td align="center" border-bottom="none"><%= t_location %></td>
	<td align="center"><%= c_unit %></td>
	
</tr>
<%
	}
}
stmt.close(); myConn.close();
%>

</table>
	
<table id="select_table" width="75%" align="center">
	<tr><th width="75%" align="center" >총 신청 과목 수</th><td align="center"><%=nTotalCnt %></td></tr>
	<tr><th align="center">총 신청 학점 수</th><td align="center"><%=nTotalUnit %></td></tr>
</table>

<br><br><br>
<div align="center">
<form method="post" width="75%" align="center" id="selectForm" action="select.jsp">
<input id="selectsearch" type="text" name="selectYear" <%if (selectYear != null){ %> value = <%=selectYear%><% } %>>년도
<input id="selectsearch" type="text" name="selectSem" <%if (selectSem != null){ %> value = <%=selectSem%><% } %>>학기
<input type="button" id="select_btn" value="조회" onclick="onSelect()">
</form>

</div>
</body>
</html>
