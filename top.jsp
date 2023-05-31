<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	boolean stu_mode = true;
	String session_id = (String)session.getAttribute("user");
	String session_mode = (String)session.getAttribute("mode");
	String user_name = (String)session.getAttribute("user_name");
	String log;
	if (session_id==null){
		log="<a href=../loginPage/login.jsp>로그인</a>";
	}
	else{
		log="<a href=../loginPage/logout.jsp>로그아웃</a>";
		if(session_mode == "prof") stu_mode = false;
	}
%>

<table width="90%" align="center" bgcolor="#FFFF99" border id="top_nav">
<tr>
	<td align="center"><b><%=log%></b></td>
	<td align="center"><b><a href="../updatePage/update.jsp">사용자 정보 수정</b></td>
<%	if( stu_mode == false ) { //교수님 모드 %> 
	<td align="center"><b><a href="../insertPage/insert_pro.jsp">수업과목 추가</b></td>
	<td align="center"><b><a href="../deletePage/delete.jsp">수업과목 삭제</b></td>
	<td align="center"><b><a href="../selectPage/select_pro.jsp">수업과목 조회</b></td>
<%  }
	else { //학생 모드%>
	<td align="center"><b><a href="../insertPage/insert.jsp">수강과목 추가</b></td>
	<td align="center"><b><a href="../deletePage/delete.jsp">수강과목 삭제</b></td>
	<td align="center"><b><a href="../selectPage/select.jsp">수강과목 조회</b></td>
	<td align="center"><b><a href="../likePage/like.jsp">찜목록</b></td>


<%  }
%>
	</tr>
</table>
