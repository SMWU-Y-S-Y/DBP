<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>추가 개설 과목 입력</title>
<link rel='stylesheet' href='../css/main.css' />
</head>

<body>
<%@ include file="../top.jsp" %>

<% if (session_id==null) response.sendRedirect("../loginPage/login.jsp"); %>

<%
Connection myConn = null; 
String dburl="jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy"; 
String passwd="1234";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}

CallableStatement cstmt1 = myConn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
cstmt1.registerOutParameter(1, java.sql.Types.VARCHAR);
cstmt1.execute();
int nYear = cstmt1.getInt(1);

CallableStatement cstmt2 = myConn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
cstmt2.execute();
int nSem = cstmt2.getInt(1);
myConn.close();
%>

<table width="75%" align="center" id="p_insert_table" style="font-size: 1.2em; margin-top: 30px;">
<br>
	<tr style="background-color: #ff6347; color:white;">
		<th style="padding-top: 1%; padding-bottom: 1%;">과목명</th>
		<th>학점</th>
		<th>수업 요일</th>
		<th>수업 시간</th>
		<th>수업 장소</th>
		<th>인원</th>
	    <th>개설 연도</th>
	    <th style="padding-right: 5px;">개설 학기</th>
	</tr>
	<tr></tr><tr></tr><tr></tr>
	<tr></tr><tr></tr><tr></tr>
	<tr>	</tr>
	
	<form id="insertForm" action="insert_verify_pro.jsp?&id=<%=session_id%>" method="post">
		<td align="center"><input id="pinsertsearch" type="text" name="lec_name" ></td>
		<td align="center"><input id="pinsertsearch" type="text" style="width:60px;" name="lec_unit" id="in" value="3"></td>
		<td align="center">
			<input type="checkbox" name="lec_day" id="in_c" value="월">월
			<input type="checkbox" name="lec_day" id="in_c" value="화">화 
			<input type="checkbox" name="lec_day" id="in_c" value="수">수 
			<input type="checkbox" name="lec_day" id="in_c" value="목">목 
			<input type="checkbox" name="lec_day" id="in_c" value="금">금
		</td>
		<td align="center">
				<input type="text" name="lec_st_hh" id="pinsertH" style="font-size: 1em; width:40pt;" value="08">
				:
				<input type="text" name="lec_st_mm" id="pinsertH"style="font-size: 1em; width:40pt;" value="00">
				-
				<input type="text" name="lec_et_hh" id="pinsertH" style="font-size: 1em; width:40pt;" value="10">
				:
				<input type="text" name="lec_et_mm" id="pinsertH" style="font-size: 1em; width:40pt;" value="00">
		</td> 
		<td align="center"><input type="text" name="lec_loc" id="pinsertsearch" ></td>
		<td align="center"><input type="text" name="lec_max" style="width:65px;"id="pinsertsearch" ></td>
		<td align="center"><input type="text" name="t_year" style="width:65px;text-align:center;" id="updateinputFixed"  value=<%= nYear%> disabled></td>
		<td align="center"><input type="text" name="t_semester" style="width:65px;text-align:center;" id="updateinputFixed" value=<%= nSem%> disabled></td>
		<td align="center"><input type="submit" value="추가" id="insertbtn" style="margin-left:5px" value="1"></td>
	</form>
	</tr>
</table>
</body>
</html>
