<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    response.setContentType("application/json");
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (!isMultipart) {
        out.print("{\"success\": false, \"message\": \"Form must have enctype=multipart/form-data.\"}");
        return;
    }

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    String title = null, skill = null, startDate = null, endDate = null, shortDesc = null, description = null;
    boolean success = false;
    int projectId = -1; // 프로젝트 ID 저장
    List<FileItem> fileItems = null;

    try {
        // 요청 데이터 파싱
        fileItems = upload.parseRequest(request);

        for (FileItem item : fileItems) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");
                switch (fieldName) {
                    case "title": title = fieldValue; break;
                    case "skill": skill = fieldValue; break;
                    case "startDate": startDate = fieldValue; break;
                    case "endDate": endDate = fieldValue; break;
                    case "shortDesc": shortDesc = fieldValue; break;
                    case "description": description = fieldValue; break;
                }
            }
        }

        // 데이터베이스 연결
        String dbURL = "jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "1234";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            // 프로젝트 데이터 삽입
            String projectInsertSQL = 
                "INSERT INTO Project (title, skill, start_date, end_date, short_desc, description) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(projectInsertSQL, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, title);
                pstmt.setString(2, skill);
                pstmt.setString(3, startDate);
                pstmt.setString(4, endDate);
                pstmt.setString(5, shortDesc);
                pstmt.setString(6, description);
                success = pstmt.executeUpdate() > 0;

                // 생성된 프로젝트 ID 가져오기
                if (success) {
                    try (ResultSet rs = pstmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            projectId = rs.getInt(1);
                        }
                    }
                }
            }

            // 이미지 파일 처리 및 저장
            if (projectId != -1 && success) {
                String uploadPath = application.getRealPath("/") + "MY_Profile/myprofile/IMG/";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // 업로드 디렉토리 생성
                }

                String imageInsertSQL = "INSERT INTO Image (project_id, image_path) VALUES (?, ?)";
                try (PreparedStatement imageStmt = conn.prepareStatement(imageInsertSQL)) {
                    for (FileItem item : fileItems) {
                        if (!item.isFormField() && item.getName() != null && !item.getName().isEmpty()) {
                            String fileName = new File(item.getName()).getName();
                            String filePath = uploadPath + fileName;

                            // 서버에 파일 저장
                            item.write(new File(filePath));

                            // 이미지 경로를 DB에 삽입
                            imageStmt.setInt(1, projectId);
                            imageStmt.setString(2, "IMG/" + fileName);
                            imageStmt.executeUpdate();
                        }
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        success = false;
    }

    // JSON 응답 반환
    out.print("{\"success\": " + success + "}");
%>
