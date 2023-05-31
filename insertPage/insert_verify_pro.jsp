<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head><title> 수강신청 입력 </title></head>

<body>
<%
   request.setCharacterEncoding("UTF-8");

   String mode = request.getParameter("mode");
   String id = request.getParameter("id");
   int to_day = 0;
   boolean isOkay = true;
   
   String c_name = request.getParameter("lec_name");
   if(c_name == null || c_name.equals("")){
      isOkay = false;
   %>
      <script>   
         alert("과목명을 확인해주세요.");
         location.href="insert_pro.jsp";
      </script>
   <%
   }
   
   String c_unit = request.getParameter("lec_unit");
   if(c_unit.equals("")){
      isOkay = false;
      %>
      <script>   
         alert("이수학점을 확인해주세요.");
         location.href="insert_pro.jsp";
      </script>
   	<%
   }
      
   int unit = 0;
   if(!c_unit.equals(""))
      unit = Integer.parseInt(c_unit);
   else 
      unit = 0;
   System.out.println(unit);
   if(unit == 0){
      isOkay = false;
   %>
      <script>   
         alert("이수학점을 확인해주세요.");
         location.href="insert_pro.jsp";
      </script>
   <%
   }
      
   String c_loc = request.getParameter("lec_loc");
   if(c_loc == null || c_loc.equals("")){
      isOkay = false;
   %>
      <script>   
         alert("강의실을 확인해주세요.");
         location.href="insert_pro.jsp";
      </script>
   <%
   }
   
   Connection myConn1 = null; 
   String dburl1="jdbc:oracle:thin:@localhost:1521:xe";
   String user1="c##ysy"; 
   String passwd1="1234";
   String dbdriver1 = "oracle.jdbc.driver.OracleDriver";

   try {
   	Class.forName(dbdriver1);
   	myConn1 = DriverManager.getConnection (dburl1, user1, passwd1);
   } catch(SQLException ex) {
   	System.err.println("SQLException: " + ex.getMessage());
   }

   CallableStatement cstmt1 = myConn1.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
   cstmt1.registerOutParameter(1, java.sql.Types.VARCHAR);
   cstmt1.execute();
   int t_year = cstmt1.getInt(1);

   CallableStatement cstmt2 = myConn1.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
   cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
   cstmt2.execute();
   int t_semester = cstmt2.getInt(1);
   myConn1.close();
   
   String c_max = request.getParameter("lec_max");
   int max = 0;
   if(!c_max.equals(""))
      max = Integer.parseInt(c_max);
   else 
      max = 0;

   if(max == 0){
      isOkay = false;
   %>
      <script>   
         alert("강의 인원을 확인해주세요.");
         location.href="insert_pro.jsp";
      </script>
   <%
   }
   
    String[] c_day = request.getParameterValues("lec_day");
    String s_time = "";
    
    if(c_day == null || c_day.length > 2){
       isOkay = false;
    %>
       <script>   
          alert("요일을 다시 선택해주세요.");
          location.href="insert_pro.jsp";
       </script>
    <%
    }
    else{
       for(int i=0; i<c_day.length; i++){
          if(c_day[i].equals("월"))
             s_time += "월";
          else if(c_day[i].equals("화"))
        	 s_time += "화";
          else if(c_day[i].equals("수"))
        	 s_time += "수";
          else if(c_day[i].equals("목"))
      	  	 s_time += "목";        
          else if(c_day[i].equals("금"))
             s_time += "금";
       }
       s_time += "/";
    }

    String sh, sm, eh, em;
    sh = request.getParameter("lec_st_hh"); sm = request.getParameter("lec_st_mm");
    eh = request.getParameter("lec_et_hh"); em = request.getParameter("lec_et_mm");
    s_time = s_time + sh + ":" + sm + "~" + eh + ":" + em;
    
    if (isOkay) {
    	Connection myConn2 = null;    
        String result = null;   
        
        String dburl2 = "jdbc:oracle:thin:@localhost:1521:xe";
        String user2 = "c##ysy";
        String passwd2 = "1234";
        String dbdriver2 = "oracle.jdbc.driver.OracleDriver";
        
        Statement stmt = null; Statement stmt1 = null; 
        ResultSet rs = null; ResultSet rs1 = null;
       	CallableStatement cstmt3 = null;
       	PreparedStatement pstmt = null; PreparedStatement pstmt1 = null;
       	String sql = null;
       	Boolean check = false; //기존에 있는 값인지 확인
 
       	try{
       		Class.forName(dbdriver2);
            myConn2 =  DriverManager.getConnection (dburl2, user2, passwd2);
            stmt = myConn2.createStatement();
 
            //기존 테이블에서 과목명으로 검색
            sql = "select c_id, c_id_no from course where c_name = '" + c_name+ "'";
            rs = stmt.executeQuery(sql);
 
            if(rs != null) {
            	String c_id = null;
            	int c_id_no = 0;
            	
                while(rs.next()){ //기존에 있는 수업이라면 c_id, c_id_no 가져오기
                    c_id = rs.getString("c_id");
                    check = true;
                    c_id_no = Integer.parseInt(rs.getString("c_id_no"));
                    //System.out.println("기존에 있는 수업입니다. 과목번호: " + c_id + "분반번호" + c_id_no);
                }
                
	            if(check == false){ //새로운 수업이라면   	
	                String cc_id = null; 
	            	int n_id=0;
	                int max_id=0;
	            	stmt1 = myConn2.createStatement();
	                sql = "select c_id from course"; //모든 c_id 출력
	                rs1 = stmt1.executeQuery(sql);

	                if(rs1 != null){
	                	while(rs1.next()){
		                	c_id = rs1.getString("c_id");
		                	cc_id = c_id.substring(1); // 숫자만 출력
		                	if(max_id < Integer.parseInt(cc_id) + 1){
		                		max_id = Integer.parseInt(cc_id)+1; 
		                	}
	                	}
	                }
	                c_id = "c" +max_id;
	                c_id_no = 1;
	            }
	            else{ //기존에 있는 수업이라면
	            	c_id_no += 1; //과목코드는 그대로, 분반은 하나 증가
	            }

	            //System.out.println("새로운 과목 코드입니다. 과목번호: " + c_id + "분반번호" + c_id_no);
	            
                cstmt3 = myConn2.prepareCall("{call InsertLecture(?,?,?,?,?,?,?,?,?,?,?)}");   
                cstmt3.setString(1, c_name);
                cstmt3.setInt(2, unit);
                cstmt3.setString(3, id);
                cstmt3.setString(4, c_id);
                cstmt3.setInt(5,c_id_no);
             	cstmt3.setString(6, s_time);
             	cstmt3.setInt(7, t_year); 
             	cstmt3.setInt(8, t_semester); 
             	cstmt3.setString(9, c_loc); 
             	cstmt3.setInt(10, max);
          
                cstmt3.registerOutParameter(11, java.sql.Types.VARCHAR);
                cstmt3.execute();
               
                result = cstmt3.getString(11);
                //System.out.println(result);
    		 %>
    		 <script>   
    		 	alert("<%=result%>");
          		location.href="insert_pro.jsp";
       		</script>
       		<%
            }
       	}catch(SQLException ex) {
           System.err.println("SQLException: " + ex.getMessage());
        }finally {
           if (pstmt != null){ 
                try { 
                   pstmt.close(); pstmt1.close(); cstmt3.close();
                }catch(SQLException ex) { 
                   out.print("error");
                }
           }
           if(stmt != null){
        	   try{
                  stmt.close();
               }catch(SQLException ex) { 
                   out.print("error");
               }
            }
            myConn2.close();
        }
    }
 %>
</body></html>
