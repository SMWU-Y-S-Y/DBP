<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<head><title> Âò Ãë¼Ò </title></head>
<body>

<%
	Connection myConn = null;    String	result = null;	
	String dburl  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="c##ysy";   String passwd="1234";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	CallableStatement cstmt;
	int is;
	try {
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
	} catch(SQLException ex) {
    	 System.err.println("SQLException: " + ex.getMessage());
	}
	
	boolean stu_mode = true;
	String session_id= (String)session.getAttribute("user");
	if(session_id == null) {
		session_id = (String)session.getAttribute("prof");
	if(session_id != null) stu_mode = false;
	}
	
	
	String s_id=session_id;
	//String s_id = (String)session.getAttribute("user");
	String c_id = request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));		
	is = Integer.parseInt(request.getParameter("main"));
    cstmt = myConn.prepareCall("{call DeleteLike(?,?,?,?)}");
	cstmt.setString(1, s_id);
	cstmt.setString(2, c_id);
	cstmt.setInt(3, c_id_no);
	cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);	
	
	try  {  	
		cstmt.execute();
		result = cstmt.getString(4);		
%>
<script>
	console.log(<%=is%>);
	alert("<%=result%>"); 
	if(<%=is%>==1){
		location.href="../insertPage/insert.jsp";
	}else{
		location.href="like.jsp";
	}
	
	
</script>
<%		
	} catch(SQLException ex) {		
		 System.err.println("SQLException: " + ex.getMessage());
	}  
	finally {
	    if (cstmt != null) 
            try { myConn.commit(); cstmt.close();  myConn.close(); }
 	      catch(SQLException ex) { }
     }
 
%>
</form></body></html>
