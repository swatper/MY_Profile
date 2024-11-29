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

                    String[] skillList = skill.split("-"); // 스킬 분리

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

            <div class="project_skills">
                <%
                    // Skill 데이터를 분리하여 각 배지 생성
                    if (skill != null && !skill.isEmpty()) {
                        String[] skillArray = skill.split("-"); // '-'로 분리
                        for (String skill1 : skillArray) {
                            String currentSkill = skill1.trim(); // 공백 제거
                            switch (currentSkill) {
                                case "C":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/C-00599C.svg?&style=flat&logo=C&logoColor=White" alt="C">
                <%
                                    break;
                                case "C++":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/C++-00599C.svg?&style=flat&logo=Cplusplus&logoColor=White" alt="C++">
                <%
                                    break;
                                case "C#":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/C%23-37039A?style=flat&logo=c%23&logoColor=white" alt="C#">
                <%
                                    break;
                                case "html":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/HTML5-FF0000?style=flat&logo=HTML5&logoColor=white" alt="HTML">
                <%
                                    break;
                                case "css":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/CSS3-00599C?style=flat&logo=CSS3&logoColor=white" alt="css">
                <%
                                    break;
                                case "Unity":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/Unity-000000?style=flat&logo=unity&logoColor=white" alt="unity">
                <%
                                    break;
                                case "Oracle":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/Oracle-FF0000?style=flat&logo=oracle&logoColor=white" alt="oracle">
                <%
                                    break;
                                case "Java":
                %>
                                    <img class="p_Badge" src="https://img.shields.io/badge/JAVA-007396?style=flat&logo=OpenJDK&logoColor=white" alt="Java">
                <%
                                    break;
                                default:
                %>
                                    <span>Unknown skill: <%= currentSkill %></span> <!-- 디버깅용 -->
                <%
                                    break;
                            }
                        }
                    } else {
                %>
                    <p>No skills available</p>
                <%
                    }
                %>
            </div>

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

</div>

<!-- 프로젝트 추가 팝업 -->
<div id="popup" style="display: none; background-color: rgba(0,0,0,0.5); position: fixed; top: 0; left: 0; width: 100%; height: 100%;">
    <div class="InputInfo">
        <h3>프로젝트 추가</h3>
        <form id="projectForm" action="addProject.jsp" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
            <input type="text"  name="title" placeholder="프로젝트 제목" required>
            <input type="text" name="skill" placeholder="사용 스킬" required>
            <input type="date" name="startDate" required>
            <input type="date" name="endDate" required>
            <textarea  name="shortDesc" placeholder="한 줄 설명" rows="2" required></textarea>
            <textarea  name="description" placeholder="프로젝트 상세 설명 (하이픈으로 구분)" rows="5" required></textarea>
            <input type="file" id="images" name="images" accept="image/*" multiple required>
            <div class="Buttons">
                <button type="button" onclick="submitProject()">추가</button>
                <button type="button" onclick="closePopup()">취소</button>
            </div>
        </form>
    </div>
</div>