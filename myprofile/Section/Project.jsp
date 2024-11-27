<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="Project_container">
    <div class="Project_title">Projects</div>
    <div class="projects_grid">
        <%
            // 데이터베이스 연결 정보
            String dbURL = "jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "1234";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // 데이터베이스 연결
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Project 테이블에서 데이터 읽기
                String sql = "SELECT * FROM Project";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                // 각 프로젝트를 박스로 표시
                while (rs.next()) {
                    int pid = rs.getInt("pid");
                    String title = rs.getString("title");
                    String skill = rs.getString("skill");
                    String startDate = rs.getString("start_date");
                    String endDate = rs.getString("end_date");
                    String desc = rs.getString("short_desc");
                    String details = rs.getString("description");

                    // 관련 이미지 가져오기
                    String getImageSQL = "SELECT image_path FROM Image WHERE project_id = " + pid;
                    Statement imgStmt = conn.createStatement();
                    ResultSet imgRs = imgStmt.executeQuery(getImageSQL);
                    List<String> imagePaths = new ArrayList<>();
                    while (imgRs.next()) {
                        imagePaths.add(imgRs.getString("image_path"));
                    }
                    imgRs.close();
                    imgStmt.close();
        %>
        <div class="project_box">
            <h3><%= title %></h3>
            <div class="date"><%= startDate %> ~ <%= endDate %></div>
            <div class="divider"></div>
            <p><%= desc %></p>
            <ul>
                <% 
                    if (details != null && !details.isEmpty()) {
                        String[] detailLines = details.split("-");
                        for (String line : detailLines) {
                %>
                <li><%= line.trim() %></li>
                <% 
                        }
                    } 
                %>
            </ul>
            <div class="image-slider" id="slider-<%= pid %>">
                <% for (int i = 0; i < imagePaths.size(); i++) { %>
                <img src="<%= imagePaths.get(i) %>" alt="<%= title %> 이미지" class="<%= i == 0 ? "active" : "" %>">
                <% } %>
                <div class="slider-controls">
                    <button onclick="prevSlide(this)">&#9664;</button>
                    <button onclick="nextSlide(this)">&#9654;</button>
                </div>
            </div>
        </div>
        <%  } %>
        <%  } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        %>
    </div>

    <!-- 프로젝트 추가 버튼 -->
    <button onclick="openPopup()">프로젝트 추가</button>
</div>

<!-- 프로젝트 추가 팝업 -->
<div id="popup" style="display: none; background-color: rgba(0,0,0,0.5); position: fixed; top: 0; left: 0; width: 100%; height: 100%;">
    <div style="background: white; margin: 10% auto; padding: 20px; width: 50%; border-radius: 10px;">
        <h3>프로젝트 추가</h3>
        <form id="projectForm" enctype="multipart/form-data">
            <input type="text" id="projectTitle" name="title" placeholder="프로젝트 제목" required>
            <input type="text" id="projectSkill" name="skill" placeholder="사용 스킬" required>
            <input type="date" id="startDate" name="startDate" required>
            <input type="date" id="endDate" name="endDate" required>
            <textarea id="projectDesc" name="desc" placeholder="한 줄 설명" rows="2" required></textarea>
            <textarea id="projectDetails" name="details" placeholder="프로젝트 상세 설명 (하이픈으로 구분)" rows="5" required></textarea>
            <input type="file" id="projectImages" name="images" accept="image/*" multiple required>
            <button type="button" onclick="submitProject()">추가</button>
            <button type="button" onclick="closePopup()">취소</button>
        </form>
    </div>
</div>
