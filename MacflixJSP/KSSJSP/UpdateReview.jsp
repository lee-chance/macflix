 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        
<%
	request.setCharacterEncoding("utf-8");
	String seq = request.getParameter("user_seq");
	String aroma = request.getParameter("aroma");
	String appearance = request.getParameter("appearance");
	String palate = request.getParameter("palate");
	String taste = request.getParameter("taste");
	String overall = request.getParameter("overall");

		
//------
	String url_mysql = "jdbc:mysql://114.199.130.68/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;
	try{
        Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
	    String A = "UPDATE Review SET review_aroma = ?, review_appearance = ?, review_palate = ?, review_taste = ?, review_overall = ? WHERE (seq = ?);";

	    ps = conn_mysql.prepareStatement(A);

		ps.setString(1, aroma);
		ps.setString(2, appearance);
		ps.setString(3, palate);
		ps.setString(4, taste);
		ps.setString(5, overall);
		ps.setString(6, seq);

	    ps.executeUpdate();
	
	    conn_mysql.close();
	} 
	
	catch (Exception e){
	    e.printStackTrace();
	}

%>

