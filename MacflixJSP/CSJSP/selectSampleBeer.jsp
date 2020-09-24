<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

    request.setCharacterEncoding("utf-8");
    String seq = request.getParameter("seq");
    


	String url_mysql = "jdbc:mysql://114.199.130.68:3306/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String A = "select beer_id, beer.brewery_id, beer_name, beer_style, beer_abv, round(avg(review_aroma),1) as aroma, round(avg(review_appearance),1) as appearance, round(avg(review_palate), 1) as palate, round(avg(review_taste), 1) as taste, round(avg(review_overall), 1) as overall, review.beer_beerid in (select beer_beer_id from Preference where user_seq = "+seq+") as heart, brewery.brewery_name ";
    String B = "from beer, review, brewery where beer.beer_id = review.beer_beerid and review.brewery_id = brewery.id group by beer_id, beer_name, beer_style, beer_abv, brewery.brewery_name;";
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
                "beer_id" : "<%=rs.getInt(1) %>",
                "brewery_id" : "<%=rs.getInt(2) %>",
                "beer_name" : "<%=rs.getString(3).replaceAll("\\\"", "\\\\\"") %>",
                "beer_style" : "<%=rs.getString(4) %>", 
                "beer_abv" : "<%=rs.getDouble(5) %>",	
                "aroma" : "<%=rs.getString(6) %>",
                "appearance" : "<%=rs.getString(7) %>", 
                "palate" : "<%=rs.getString(8) %>",		
                "taste" : "<%=rs.getString(9) %>",
                "overall" : "<%=rs.getString(10) %>",
                "heart" : "<%=rs.getInt(11) %>",
		"brewery_name" : "<%=rs.getString(12) %>",
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
