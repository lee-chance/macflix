<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    request.setCharacterEncoding("utf-8");
    String seq = request.getParameter("seq");
    String first = request.getParameter("first");
    String second = request.getParameter("second");
    String third = request.getParameter("third");
    String fourth = request.getParameter("fourth");

    String[] strParams = {first, second, third, fourth};

    for(int i=0; i<strParams.length; i++) {
        switch (strParams[i]) {
            case "Smell":
                strParams[i] = "review_aroma";
                break;
            case "Taste":
                strParams[i] = "review_taste";
                break;
            case "Look":
                strParams[i] = "review_appearance";
                break;
            case "Feel":
                strParams[i] = "review_palate";
                break;
        }
    }

%>

<%
	String url_mysql = "jdbc:mysql://114.199.130.68:3306/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";

    String A = "select beer_id, beer.brewery_id,beer_name, beer_style, beer_abv, round(avg(("+strParams[0]+"*4+"+strParams[1]+"*3+"+strParams[2]+"*2+"+strParams[3]+"*1)/10), 2) as clac, round(avg(review_aroma),1) as aroma, round(avg(review_appearance),1) as appearance, round(avg(review_palate), 1) as palate, round(avg(review_taste), 1) as taste, round(avg(review_overall), 1) as overall, review.beer_beerid in (select beer_beer_id from Preference where user_seq = "+seq+") as heart, brewery.brewery_name ";
    String B = "from review, beer, User, brewery ";
    String C = "where review.beer_beerid = beer.beer_id and review.brewery_id = brewery.id and User.seq = "+seq+" " ;
    String D = "group by beer_id, beer.brewery_id,beer_name, beer_style, beer_abv, brewery.brewery_name order by clac desc;";
    int count = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(A+B+C+D); // &quot;
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
			"calc" : "<%=rs.getString(6) %>",
			"aroma" : "<%=rs.getString(7) %>",
			"appearance" : "<%=rs.getString(8) %>", 
			"palate" : "<%=rs.getString(9) %>",		
			"taste" : "<%=rs.getString(10) %>",
			"overall" : "<%=rs.getString(11) %>",
			"heart" : "<%=rs.getInt(12) %>",
			"brewery_name" : "<%=rs.getString(13) %>"
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
