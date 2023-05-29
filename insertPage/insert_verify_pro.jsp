<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><title> 수강신청 입력 </title></head>
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
   if(c_unit == null || c_unit.equals("")){
      isOkay = false;
   %>
      <script>   
         alert("이수학점을 확인해주세요.");
         location.href="insert_pro.jspp";
      </script>
   <%
   }
      
   int unit = 0;
   if(!c_unit.equals(""))
      unit = Integer.parseInt(c_unit);
   else 
      unit = 0;

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
   
   String year = request.getParameter("t_year");
   int t_year = 0;
   if(!year.eqauls("")){
	   t_year = Integer.parseInt(t_year);
   }
   else{
	   isOkay = false;
	   %>
	      <script>   
	         alert("년도를 확인해주세요.");
	         location.href="insert_pro.jsp";
	      </script>
	   <%
   }

   String semester = request.getParameter("t_semester");
   int t_semester = 0;
   if(t_semester == "1" || t_semester == "2"){
		t_semester = Integer.parseInt(semester);   
   }
   else{
	      isOkay = false;
   %>
      <script>   
         alert("학기을 확인해주세요.");
         location.href="insert_pro.jsp";
      </script>
   <%
   }   
   
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
    String t_time = null;
    
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
             t_time += "월";
          else if(c_day[i].equals("화"))
        	 t_time += "화";
          else if(c_day[i].equals("수"))
        	 t_time += "수";
          else if(c_day[i].equals("목"))
      	  	 t_time += "목";        
          else if(c_day[i].equals("금"))
             t_time += "금";
       }
       t_time += "/";
    }
    
    int sh, sm, eh, em;
    sh = request.getParameter("lec_st_hh"); sm = request.getParameter("lec_st_mm");
    eh = request.getParameter("lec_et_hh"); em = request.getParameter("lec_et_mm");
    t_time = t_time + sh + ":" + sm + "~" + eh + ":" + em;
    
    if (isOkay) {
    	Connection myConn = null;    
        String result = null;   
        
        String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
        String user = "c##ysy";
        String passwd = "1234";
        String dbdriver = "oracle.jdbc.driver.OracleDriver";
        
        Statement stmt = null, stmt1 = null; ResultSet rs = null, rs1 = null;
       	CallableStatement cstmt = null, cstmt1 = null;
 
       	PreparedStatement pstmt = null, pstmt1 = null;
       	String sql = null;
       	Boolean check = false;
 
       	int c_id_no = 0;
 
       	try{
       		Class.forName(dbdriver);
            myConn =  DriverManager.getConnection (dburl, user, passwd);
            stmt = myConn.createStatement();
 
            sql = "select c_id, c_id_no from course where c_name = '" + c_name+"'";
            rs = stmt.executeQuery(sql);
 
            if(rs != null) { //해당 c_id와 c_id_no 값을 가진 course 있으면
            	String c_id = null;
                while(rs.next()){
                    c_id = rs.getString("c_id");
                    check = true;
                    c_id_no = Integer.parseInt(rs.getString("c_id_no"));
                }
 
                if(check == false){ //분반만 없는 경우         	
                    String cc_id = null; 
                	int n_id;
                    stmt1 = myConn.createStatement();
                    sql = "select c_id from course";
                    rs1 = stmt1.executeQuery(sql);
                    while(rs1.next())
                    	c_id = rs1.getString("c_id");
                    cc_id = c_id.substring(1); n_id = Integer.parseInt(cc_id) + 1; out.print(n_id);
                    c_id_no = 0; c_id = "C" + n_id;
                    out.print(c_id + " " + c_id_no);
                }
                
                cstmt = myConn.prepareCall("{call InsertLecture(?,?,?,?,?,?,?,?,?,?,?,?,?)}");   
                cstmt.setString(1, c_name);
                cstmt.setString(2, c_unit);
                cstmt.setString(3, id);
                cstmt.setString(4, c_id);
                cstmt.setInt(5,c_id_no+1);
             	cstmt.setInt(6, t_time);
             	cstmt.setInt(7, t_year); // 추가
             	cstmt.setInt(8, t_semester); // 추가
             	cstmt.setString(9, c_loc); 
             	cstmt.setInt(10, max);
             
                cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
                cstmt.execute();
               
                result = cstmt.getString(11);
    %>
               <script>   
                  alert("<%=result%>");
                  location.href="insert_pro.jsp";
               </script>
               <%      
             
             }

       } catch(SQLException ex) {
           System.err.println("SQLException: " + ex.getMessage());
        }finally {
           if (pstmt != null) 
                try { 
                   pstmt.close();
                   pstmt1.close();
                   cstmt.close();
                   
                }catch(SQLException ex) { 
                   out.print("error");
                }
            if(stmt != null){
               try{
                  stmt.close();
               }catch(SQLException ex) { 
                   out.print("error");
                }
            }
            myConn.close();
        }
    }

  %>
</form></body></html>
