<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");
	int seq = Integer.parseInt(request.getParameter("seq"));
	String user_password = request.getParameter("user_password");

%>
<%
	String url_mysql = "jdbc:mysql://114.199.130.68/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    	String WhereDefault = "select user_password from User where seq = "+seq+" and user_password = '"+user_password+"';";
	int count = 0;
	
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(WhereDefault); // &quot;
        
     	   while(rs.next()){
      		count++;
	}
	%>
	
        	<%=Integer.toString(count)%>
	
	<%
        	conn_mysql.close();
    	} catch (Exception e) {
        	e.printStackTrace();
    	}
%>
