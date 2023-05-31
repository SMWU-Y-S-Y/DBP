<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"  %>
<!DOCTYPE html>
	<head>
		<title>수강신청 취소</title>
		<!-- <link rel='stylesheet' href='./dbDesign.css' /> -->
	</head>
	<style type="text/css">
		#in_b, #in_b:visited {
			width: 80pt;
			font-size: 17pt;
			color: blue;	
		}
	</style>
<body>
<%@ include file="../top.jsp" %>
<%   
	if (session_id == null) 
		response.sendRedirect("../loginPage/login.jsp");
	String mode=(String)session.getAttribute("mode");
	Connection myConn = null;      
	Statement stmt = null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	CallableStatement cstmt = null;
	CallableStatement cstmt1 = null;
	CallableStatement cstmt2 = null;
	String mySQL = "";
	String semesterSQL = "";
	ResultSet myResultSet = null;
	String dburl  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="c##ysy";     
	String passwd="1234";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String str_course_day = "";
	
	try {
		Class.forName(dbdriver);
        myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
	} catch(SQLException ex) {
    	System.err.println("SQLException: " + ex.getMessage());
	}
	
	if (mode == "prof") {		
%> <!-- professor login 시 -->
		<table width="75%" align="center" id="delete_table">
		<br>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>강의시간</th>
		    <th>강의장소</th>
		    <th>최대 수강인원</th>
		    <th>강의학기</th>
		    <th>강의 삭제</th>
		</tr>
<%	
	String Year = "{? = call Date2EnrollYear(SYSDATE)}";
	String Semester = "{? = call Date2EnrollSemester(SYSDATE)}";
	
	cstmt1 = myConn.prepareCall(Year);
	cstmt2 = myConn.prepareCall(Semester);
	cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
	cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
	cstmt1.execute();
	cstmt2.execute();
	
	int nYear=cstmt1.getInt(1);
	int nSemester=cstmt2.getInt(1);
	mySQL = "select t.c_id, t.c_id_no, c.c_name, t.t_year, t.t_time, t.t_location, t.t_max, t.t_semester from course c, teach t, professor p where p.p_id='"+ session_id +"' and t.t_semester = '"+nSemester+ "' and t.t_year ='"+nYear+"' and t.p_id = p.p_id and c.c_id = t.c_id and t.c_id_no = c.c_id_no";
	try{
		myResultSet = stmt.executeQuery(mySQL);
		if (myResultSet != null) {
			while (myResultSet.next()) {	
				String c_id = myResultSet.getString("c_id");
				int c_id_no = myResultSet.getInt("c_id_no");			
				String c_name = myResultSet.getString("c_name");
				int t_day = myResultSet.getInt("t_year");
				String t_time = myResultSet.getString("t_time");
				String t_where = myResultSet.getString("t_location");
				int t_max = myResultSet.getInt("t_max");
				int t_semester = myResultSet.getInt("t_semester");
				
%>
					<tr>
					  <td align="center"><%= c_id %></td>
					  <td align="center"><%= c_id_no %></td>
					  <td align="center"><%= c_name %></td>
					  <td align="center"><%=t_time %> </td>
					  <td align="center"><%= t_where %></td>
					  <td align="center"><%= t_max %>명</td>
					  <td align="center"><%= t_semester %></td>
					  <td align="center"><a id="in_b" href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">삭제</a></td>
					</tr>
<%

					}
				}
			}catch(SQLException e){
			    out.println(e);
			    e.printStackTrace();
			}
			stmt.close();  
			myConn.close();
			%>
			</table>
			<br><br><br>
			<div align="center">
			<input type="text" value=<%=nYear %> disabled>년도
			<input type="text" value=<%=nSemester %> disabled>학기
<%
	} 
	else {
%>
		<table width="75%" align="center" id="delete_table">
		<br>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>강의시간</th>
		    <th>강의장소</th>
			<th>학점</th>
		    <th>수강취소</th>
		</tr>
<%
	String Year = "{? = call Date2EnrollYear(SYSDATE)}";
	String Semester = "{? = call Date2EnrollSemester(SYSDATE)}";

	cstmt1 = myConn.prepareCall(Year);
	cstmt2 = myConn.prepareCall(Semester);
	cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
	cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
	cstmt1.execute();
	cstmt2.execute();
	
	int nYear=cstmt1.getInt(1);
	int nSemester=cstmt2.getInt(1);
	
	mySQL = "select e.c_id, e.c_id_no, e.e_semester, c.c_name, c.c_unit, t.t_year, t.t_time, t.t_location from course c, enroll e, teach t where e.s_id ='"+ session_id + "' and t.t_semester = '"+nSemester+ "' and t.t_year ='"+nYear+"'and e.c_id = c.c_id and e.c_id_no = c.c_id_no and t.c_id = c.c_id and t.c_id_no = c.c_id_no";
	try{
		myResultSet = stmt.executeQuery(mySQL);
		if (myResultSet != null) {
			while (myResultSet.next()) {	
				String c_id = myResultSet.getString("c_id");
				int c_id_no = myResultSet.getInt("c_id_no");
				int e_semester = myResultSet.getInt("e_semester");
				String c_name = myResultSet.getString("c_name");
				int c_unit = myResultSet.getInt("c_unit");
				int t_day = myResultSet.getInt("t_year");
				String t_time = myResultSet.getString("t_time");
				String t_startTime_MM = myResultSet.getString("t_time");
				String t_endTime_HH = myResultSet.getString("t_time");
				String t_endTime_MM = myResultSet.getString("t_time");
				String t_where = myResultSet.getString("t_location");

%>				
					<tr>
					  <td align="center"><%= c_id %></td> <td align="center"><%= c_id_no %></td> 
					  <td align="center"><%= c_name %></td>
					  <td align="center"><%= t_time %></td>
					  <td align="center"><%= t_where %></td>
					  <td align="center"><%= c_unit %></td>
					  <td align="center"><a id="in_b" href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">취소</a></td>
					</tr>
<%
				}
			}
		}catch(SQLException e){
		    out.println(e);
		    out.println(myResultSet);
		    e.printStackTrace();
		}
		stmt.close();  
		myConn.close();
		%>
		</table>
		<br><br><br>
		<div align="center">
		<input type="text" value=<%=nYear %> disabled>년도
		<input type="text" value=<%=nSemester %> disabled>학기
<%
	}
%>

</body></html>