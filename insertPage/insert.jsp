<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>수강신청 입력</title>
<script>
var searchType = "1";
function changeValue(){
	var searchSelect = document.getElementById("selectType");
	searchType = searchSelect.options[searchSelect.selectedIndex].value;
}

function onSearch(){
	var formS = document.getElementById("insertForm");
	var searchText = formS.searchText.value;
	
	if (searchText == "")
		alert("검색어를 입력하세요.");
	else
		location.href = "insert.jsp?searchType="+searchType+"&searchText="+searchText;
}
</script>
</head>

<body>
<%@ include file="../top.jsp" %>

<% if (session_id==null) response.sendRedirect("../loginPage/login.jsp"); %>
<%
String sId = (String)session.getAttribute("user");
String sType = request.getParameter("searchType");
String sText = request.getParameter("searchText");
%>
<br><br>
	
<form method="post" width="75%" align="center" id="insertForm" action="insert.jsp">
	<select id="selectType" onchange="changeValue()">
		<%if (sText == null ||  sType.equals("1")){ %>
			<option value="1" selected>과목명</option>
			<option value="2">과목 번호</option>
		<%} else if (sType.equals("2")){%>
			<option value="1">과목명</option>
			<option value="2" selected>과목 번호</option>
		<% } %>
	</select>
	<input type="text" name="searchText" <%if (sText != null){ %>value = <%= sText%><%} %> >
	<input type="button" value="검색" onclick="onSearch()">
</form>

<table width="75%" align="center" border>
<tr>
	<th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th><th>시간</th><th>장소</th><th>현재 인원</th><th>최대 인원</th><th>수강신청</th><th>찜하기</th>
</tr>


<%
Connection myConn = null; 
Statement stmt = null;
Statement stmt2 = null;
String mySQL = null;
String mySQL2 = null;

String dburl="jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ysy"; 
String passwd="1234";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
	stmt = myConn.createStatement();
	stmt2 = myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
}

/* 현재 년도, 학기만 보이게 */
/* 저장 프로시저 사용 */
CallableStatement cstmt1 = myConn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
cstmt1.registerOutParameter(1, java.sql.Types.VARCHAR);
cstmt1.execute();
int nYear = cstmt1.getInt(1);

CallableStatement cstmt2 = myConn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
cstmt2.execute();
int nSem = cstmt2.getInt(1);

mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_location, t.t_max from course c, teach t where c.c_id not in (select e.c_id from enroll e where e.s_id='" + session_id + "' and e.e_year = " + nYear + " and e.e_semester = " + nSem + ") and t.t_year = " + nYear + "and t.t_semester = " + nSem + "and c.c_id = t.c_id and c.c_id_no = t.c_id_no";


if (sType == null || sType.equals("1")){
	if (sText != null)
		mySQL += " and c.c_name LIKE '%" + sText + "%'";
}
else if (sType.equals("2") && sText != ""){
	mySQL += " and c.c_id = '" + sText + "'";
}

mySQL += " order by length(c.c_id), c.c_id, c.c_id_no";

ResultSet myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		int c_unit = myResultSet.getInt("c_unit");
		String t_time = myResultSet.getString("t_time");
		String t_location = myResultSet.getString("t_location");
		int t_max = myResultSet.getInt("t_max");
		
		CallableStatement cstmt3 = myConn.prepareCall("{? = call getStudentCnt(?,?,?,?)}");
		cstmt3.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt3.setString(2, c_id);
		cstmt3.setInt(3, c_id_no);
		cstmt3.setInt(4, nYear);
		cstmt3.setInt(5, nSem);
		cstmt3.execute();
		int nCnt = cstmt3.getInt(1);
		
		int ismain=1;
		mySQL2 = "select * from liked l where l.c_id = '" + c_id + "' and l.c_id_no = '" + c_id_no + "'and l.s_id = '" + sId + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		boolean isliked = false;
		if(myResultSet2!=null){
			while(myResultSet2.next()){
				isliked=true;
			}
			
		}
%>
<tr>
	<td align="center"><%= c_id %></td> 
	<td align="center"><%= c_id_no %></td>
	<td align="center"><%= c_name %></td>
	<td align="center"><%= c_unit %></td>
	<td align="center"><%= t_time %></td>
	<td align="center"><%= t_location %></td>
	<td align="center"><%= nCnt %></td>
	<td align="center"><%= t_max %></td>
	<td align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">신청</a></td>
<% 	if (isliked){	%>
		<td align="center"><a href="../likePage/deletelike_verify.jsp?c_id=<%= c_id %>&main=<%= ismain %>&c_id_no=<%= c_id_no %>">♥</a></td>
<%	}else{ %>
		<td align="center"><a href="../likePage/like_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">♡</a></td>
<%	} %>
</tr>
<%
	}
}
stmt.close(); myConn.close();
%>
</table></body></html>
