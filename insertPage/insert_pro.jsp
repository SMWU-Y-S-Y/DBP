<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>수강신청 입력</title>
</head>

<body>
<%@ include file="../top.jsp" %>

<% if (session_id==null) response.sendRedirect("../loginPage/login.jsp"); %>

<table width="70%" align="center" id="p_insert_table" style="font-size: 1.2em; margin-top: 8%;">
<br>
	<tr style="background-color: #ff6347; color:white;">
		<th style="padding-top: 1%; padding-bottom: 1%;">과목명</th>
		<th>학점</th>
		<th>수업 요일</th>
		<th>수업 시간</th>
		<th>수업 장소</th>
		<th>인원</th>
	    <th>강의 추가</th>
	</tr>
	<tr></tr><tr></tr><tr></tr>
	<tr></tr><tr></tr><tr></tr>
	<tr>	</tr>
	
	<form action="insert_verify_pro.jsp?&id=<%=session_id%>" method="post">
		<td align="center"><input type="text" name="lec_name" id="in"></td>
		<td align="center"><input type="text" style="width:60px;" name="lec_unit" id="in" value="3"></td>
		<td align="center">
			<input type="checkbox" name="lec_day" id="in_c" value="월">월
			<input type="checkbox" name="lec_day" id="in_c" value="화">화 
			<input type="checkbox" name="lec_day" id="in_c" value="수">수 
			<input type="checkbox" name="lec_day" id="in_c" value="목">목 
			<input type="checkbox" name="lec_day" id="in_c" value="금">금
		</td>
		<td align="center">
				<input type="text" name="lec_st_hh" id="in" style="font-size: 1em; width:25pt;" value="08">
				:
				<input type="text" name="lec_st_mm" id="in" style="font-size: 1em; width:25pt;" value="00">
				-
				<input type="text" name="lec_et_hh" id="in" style="font-size: 1em; width:25pt;" value="10">
				:
				<input type="text" name="lec_et_mm" id="in" style="font-size: 1em; width:25pt;" value="00">
		</td> 
		<td align="center"><input type="text" name="lec_loc" id="in"></td>
		<td align="center"><input type="text" name="lec_max" style="width:65px;" id="in"></td>
		<td align="center"><input type="text" name="t_year" style="width:65px;" id="in"></td>
		<td align="center"><input type="text" name="t_semester" style="width:65px;" id="in"></td>
		<td align="center"><input type="submit" value="추가" id="in_b" style="font-family: ppi;" value="1"></td>
	</form>
	</tr>
</table>
</body>
</html>
