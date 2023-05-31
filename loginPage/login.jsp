<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<HTML>
<head>
<title>수강신청 시스템 로그인</title>
<link rel='stylesheet' href='../css/main.css' />
</head>

<BODY>
	<table width="75%" align="center" bgcolor="#FFFF00" id="login_table1">
		<tr><td><div align="center"> 학생 로그인
	</table>
	
	<table width="75%" align="center" id="login_table" >
	<form method="post" action="login_verify.jsp">
		<tr>
			<td><div align="center" >아이디</div></td>
			<td><div align="center" ><input type="text" name="userID" size="80"></div></td>
		</tr>
		<tr>
			<td><div align="center">패스워드</div></td>
			<td><div align="center"><input type="password" size="80" name="userPassword"></div></td>
		</tr>
		<tr>
			<td colspan=2><div align="center">
			<INPUT id="l_btn" TYPE="SUBMIT" NAME="Submit" VALUE="로그인">
			<INPUT id="l_btn" TYPE="RESET" VALUE="취소">
			</div></td>
		</tr>
	</form>	
	
	<table width="75%" align="center" bgcolor="#FFFF00" id="login_table1">
		<tr><td><div align="center"> 교수님 로그인
	</table>
	
	<table width="75%" align="center" id="login_table">
		<form method="post" action="login_verify_pro.jsp">
		<tr>
			<td><div align="center">아이디</div></td>
			<td><div align="center"><input type="text" size="80" name="userID"></div></td>
		</tr>
		<tr>
			<td><div align="center">패스워드</div></td>
			<td><div align="center"><input type="password" size="80" name="userPassword"></div></td>
		</tr>
		<tr>
			<td colspan=2><div align="center">
			<INPUT id="l_btn" TYPE="SUBMIT" NAME="Submit" VALUE="로그인">
			<INPUT id="l_btn" TYPE="RESET" VALUE="취소">
			</div></td>
		</tr>
	</form>
	</table>
</BODY> 
</HTML>
