<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    // 데이터베이스 연결 정보
    String jdbcDriver = "jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "1234";

    // 클라이언트로부터 데이터 받기
    String title = request.getParameter("title");
    String skill = request.getParameter("skill");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String desc = request.getParameter("desc");
    String details = request.getParameter("description");

    // 이미지 업로드 경로 설정
    String uploadPath = application.getRealPath("/") + "IMG/";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir(); // IMG 폴더가 없으면 생성
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPassword);

        // 1. Project 테이블에 데이터 삽입
        String insertProjectSQL = "INSERT INTO Project (title, skill, start_date, end_date, short_desc, description) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertProjectSQL, Statement.RETURN_GENERATED_KEYS);

        pstmt.setString(1, title);
        pstmt.setString(2, skill);
        pstmt.setString(3, startDate);
        pstmt.setString(4, endDate);
        pstmt.setString(5, desc);
        pstmt.setString(6, details);

        int rows = pstmt.executeUpdate();

        // 생성된 프로젝트 ID 가져오기
        int projectId = -1;
        if (rows > 0) {
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                projectId = rs.getInt(1);
            }
        }

        // 2. Image 테이블에 이미지 데이터 삽입
        for (int i = 0; i < 3; i++) {
            Part filePart = request.getPart("images");
            if (filePart != null && filePart.getSize() > 0) {
                // 파일 저장
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + fileName;
                filePart.write(filePath);

                // Image 테이블에 경로 저장
                String insertImageSQL = "INSERT INTO Image (project_id, image_path) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertImageSQL);
                pstmt.setInt(1, projectId);
                pstmt.setString(2, "IMG/" + fileName);
                pstmt.executeUpdate();
            }
        }

        // 성공 메시지 반환
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("error");
    } finally {
        // 리소스 정리
        if (rs != null) try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
    }
%>
