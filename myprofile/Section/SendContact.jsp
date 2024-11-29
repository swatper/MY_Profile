<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
        request.setCharacterEncoding("UTF-8");
        if (request.getParameter("submit") != null) {
            String name = request.getParameter("name");
            String title = request.getParameter("title");
            String msg = request.getParameter("msg");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // 데이터베이스 연결
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = "jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; // 데이터베이스 URL
                String dbUser = "root"; // 사용자명
                String dbPassword = "1234"; // 비밀번호
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                // 쿼리 작성 및 실행
                String sql = "INSERT INTO contacts (name, title, msg) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, title);
                pstmt.setString(3, msg);
                int rowsInserted = pstmt.executeUpdate();

                if (rowsInserted > 0) {
                    response.sendRedirect("../index.html");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // 자원 해제
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    out.println("<p>Error closing resources: " + ex.getMessage() + "</p>");
                }
            }
        }
    %>