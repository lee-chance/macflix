<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String aroma = request.getParameter("aroma");
	String appearance = request.getParameter("appearance");
	String palate = request.getParameter("palate");
	String taste = request.getParameter("taste");	
%>
<%
	
	String url_mysql = "jdbc:mysql://114.199.130.68/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
        String A = "select b.beer_id, b.beer_name as beername, b.beer_style as style, b.beer_abv as abv, round(avg(review_aroma),1) as aroma, round(avg(review_appearance),1) as appear, round(avg(review_palate), 1) as palate, round(avg(review_taste), 1) as taste, round(avg(review_overall), 1) as overall, brewery.brewery_name, brewery.id from brewery, review join beer as b on b.beer_id = review.beer_beerid ";
    String B = "where review.brewery_id = brewery.id and review_aroma >= '" + aroma+"' AND review_appearance >= '" + appearance + "' And review_palate >= '" + palate + "' And review_taste >= '" + taste + "' group by brewery.brewery_name, brewery.id, beer_id, beername, style, abv";
    int count = 0;
    
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(A+B); // &quot;
%>
  	[ 
<%
        while (rs.next()) {
            if (count == 0) {

            }else{
%>
            , 
<%           
            }
            count++;                 
%>
			{
                "beer_id" : "<%=rs.getString(1) %>",
                "beer_name" : "<%=rs.getString(2).replaceAll("\\\"", "\\\\\"") %>",
                "beer_style" : "<%=rs.getString(3) %>", 
                "beer_abv" : "<%=rs.getDouble(4) %>",	
                "aroma" : "<%=rs.getString(5) %>",
                "appearance" : "<%=rs.getString(6) %>", 
                "palate" : "<%=rs.getString(7) %>",		
                "taste" : "<%=rs.getString(8) %>",
                "overall" : "<%=rs.getString(9) %>",
		"brewery_name" : "<%=rs.getString(10) %>",
                "brewery_id" : "<%=rs.getString(11) %>"
		
			}
<%		
        }
%>
		  ]
<%		
        conn_mysql.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
	
%>
