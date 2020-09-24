<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

    request.setCharacterEncoding("utf-8");
    String keyword = request.getParameter("keyword");


%>
<%
	String url_mysql = "jdbc:mysql://114.199.130.68:3306/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String A = "select beer_id, beer_name, beer_style, beer_abv, round(avg(review_aroma),1) as aroma, round(avg(review_appearance),1) as appear, round(avg(review_palate), 1) as palate, round(avg(review_taste), 1) as taste, round(avg(review_overall), 1) as overall, brewery.brewery_name, brewery.id ";
    String B = "from beer, review, brewery where beer_name like '%" + keyword + "%' and beer.beer_id = review.beer_beerid and beer.beer_id = review.beer_beerid group by beer_id, beer_name, beer_style, beer_abv, brewery.brewery_name, brewery.id ";
    String C = "order by case when beer_name like '" + keyword + "' then 1 when beer_name like '" + keyword + "%' then 2 when beer_name like '%" + keyword + "%' then 3 end;";
    int count = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(A+B+C); // &quot;
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
