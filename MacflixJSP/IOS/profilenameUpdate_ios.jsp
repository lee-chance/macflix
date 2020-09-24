<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        

<%
	request.setCharacterEncoding("utf-8");
	String user_profilename = request.getParameter("user_profilename");
	int seq = Integer.parseInt(request.getParameter("seq"));	

//------

	String url_mysql = "jdbc:mysql://114.199.130.68:3306/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;

	try{
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
		String A = "update user set user_profilename = ? where seq = ?";


	    ps = conn_mysql.prepareStatement(A);

            ps.setString(1, user_profilename);
	    ps.setInt(2, seq);

 
	    ps.executeUpdate();
	
	    conn_mysql.close();

	} 

	catch (Exception e){
	    e.printStackTrace();

	}

%>
