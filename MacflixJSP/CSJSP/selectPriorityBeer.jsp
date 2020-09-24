<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");
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
	String url_mysql = "jdbc:mysql://114.199.130.68/macflix?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "select beer_id, beer_name, beer_style, beer_abv, round(avg(("+strParams[0]+"*4+"+strParams[1]+"*3+"+strParams[2]+"*2+"+strParams[3]+"*1)/10), 2) as clac, count(*) as count from review, beer where review.beer_beerid = beer.beer_id group by beer_id, beer_name, beer_style, beer_abv order by clac desc;";
    int count = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(WhereDefault); // &quot;
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
            "beerid" : "<%=rs.getInt(1) %>",
            "beer_name" : "<%=rs.getString(2).replaceAll("\\\"", "\\\\\"") %>",
            "beer_style" : "<%=rs.getString(3) %>",
            "beer_abv" : "<%=rs.getString(4) %>",
			"calc" : "<%=rs.getString(5) %>",
			"count" : "<%=rs.getString(6) %>"
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
