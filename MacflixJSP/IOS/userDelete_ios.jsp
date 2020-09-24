<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        

<%
	request.setCharacterEncoding("utf-8");
	int seq = Integer.parseInt(request.getParameter("seq"));

//------

	String url_mysql = "jdbc:mysql://114.199.130.68/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;

	try{
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
		String A = "delete from user where seq="+seq;


	    ps = conn_mysql.prepareStatement(A);

 
	    ps.executeUpdate();
	
	    conn_mysql.close();

	} 

	catch (Exception e){
	    e.printStackTrace();

	}

%>
