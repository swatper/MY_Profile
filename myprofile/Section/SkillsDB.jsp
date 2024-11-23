<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn =null;
    Statement stmt =null;
    ResultSet rs =null;
    try {
        String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC";
        String dbUser ="tester"; //mysql id
        String dbPass ="1234"; //mysql password

        //Data list
        String pLang = "lag";
        String badgeURL = "url";
        String langDesc = "dec";

        pLang = request.getParameter("name");

        if(pLang.equals("C++")){
            pLang = "Cplus";
        }
        if(pLang.equals("C#")){
            pLang = "Csharp";
        }

        String query ="select * from ProgramLanguage where pname = \'" + pLang+"\'"; //query
        // Create DB Connection
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        // Create Statement 
        stmt = conn.createStatement();
        // Run Qeury
        rs = stmt.executeQuery(query);
        //Set Value
        if (rs.next()) {
            badgeURL = rs.getString("url");
            langDesc = rs.getString("description");
        } 
        else {
            throw new Exception("No data found for the given name: " + pLang);
        }

    }catch (Exception e) {
        e.printStackTrace();
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write("{\"url\": \"" + badgeURL + "\", \"description\": \"" + langDesc + "\"}");
%>