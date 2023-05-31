<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
	boolean stu_mode = true;
	String session_id = (String)session.getAttribute("user");
	String session_mode = (String)session.getAttribute("mode");
	String user_name = (String)session.getAttribute("user_name");
	String log;
	if (session_id==null){
		log="<a href=../loginPage/login.jsp id='top_title'>로그인</a>";
	}
	else{
		log="<a href=../loginPage/logout.jsp id='top_title'>로그아웃</a>";
		if(session_mode == "prof") stu_mode = false;
	}
%>

<table width="90%" align="center" bgcolor="#FFFF99" border id="top_nav">
<tr>
	<td align="center" id="top_td"><b><%=log%></b></td>
	<td align="center" id="top_td"><b><a href="../updatePage/update.jsp" id="top_title">사용자 정보 수정</b></td>
<%	if( stu_mode == false ) { //교수님 모드 %> 
	<td align="center" id="top_td"><b><a href="../insertPage/insert_pro.jsp" id="top_title">수업과목 추가</b></td>
	<td align="center" id="top_td"><b><a href="../deletePage/delete.jsp" id="top_title">수업과목 삭제</b></td>
	<td align="center" id="top_td"><b><a href="../selectPage/select_pro.jsp" id="top_title">수업과목 조회</b></td>
<%  }
	else { //학생 모드%>
	<td align="center" id="top_td"><b><a href="../insertPage/insert.jsp" id="top_title">수강과목 추가</b></td>
	<td align="center" id="top_td"><b><a href="../deletePage/delete.jsp" id="top_title">수강과목 삭제</b></td>
	<td align="center" id="top_td"><b><a href="../selectPage/select.jsp" id="top_title">수강과목 조회</b></td>
	<td align="center" id="top_td"><b><a href="../likePage/like.jsp" id="top_title">찜목록</b></td>


<%  }
%>
	</tr>
</table>
