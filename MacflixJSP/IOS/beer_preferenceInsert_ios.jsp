<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        
<%
	request.setCharacterEncoding("utf-8");
	int User_seq = Integer.parseInt(request.getParameter("User_seq"));
	int beer_id = Integer.parseInt(request.getParameter("beer_id"));
		
//------
	String url_mysql = "jdbc:mysql://114.199.130.68:3306/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;
	try{
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
	    String A = "insert into Preference(User_seq, beer_beer_id";
	    String B = ") values (?,?)";
	
	    ps = conn_mysql.prepareStatement(A+B);
	    ps.setInt(1, User_seq);
	    ps.setInt(2, beer_id);
	    
	    ps.executeUpdate();
	
	    conn_mysql.close();
	} 
	
	catch (Exception e){
	    e.printStackTrace();
	}

%>

