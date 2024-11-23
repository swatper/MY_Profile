<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="Skills_container">
    <div class="Skills_title">Skiils</div>

    <div class="Skills_list">
        <img class="Badge" src="https://img.shields.io/badge/C-00599C.svg?&style=flat&logo=C&logoColor=White" alt="C" onclick="fetchSkillInfo('C')">               <!--C-->
        <img class="Badge" src="https://img.shields.io/badge/C++-00599C.svg?&style=flat&logo=Cplusplus&logoColor=White" alt="C++" onclick="fetchSkillInfo('C++')">   <!--C++-->
        <img class="Badge" src="https://img.shields.io/badge/C%23-37039A?style=flat&logo=c%23&logoColor=white" alt="C#" onclick="fetchSkillInfo('C#')">             <!--C#-->
        <img class="Badge" src="https://img.shields.io/badge/JAVA-007396?style=flat&logo=OpenJDK&logoColor=white" alt="Java" onclick="fetchSkillInfo('Java')">        <!--Java-->
        <img class="Badge" src="https://img.shields.io/badge/HTML5-FF0000?style=flat&logo=HTML5&logoColor=white" alt="HTML" onclick="fetchSkillInfo('HTML')">         <!--HTML5-->
        <img class="Badge" src="https://img.shields.io/badge/CSS3-00599C?style=flat&logo=CSS3&logoColor=white" alt="CSS" onclick="fetchSkillInfo('CSS')">            <!--CSS3-->
        <img class="Badge" src="https://img.shields.io/badge/Unity-000000?style=flat&logo=unity&logoColor=white" alt="Unity" onclick="fetchSkillInfo('Unity')">        <!--Unity-->
        <img class="Badge" src="https://img.shields.io/badge/Oracle-FF0000?style=flat&logo=oracle&logoColor=white" alt="Oracle" onclick="fetchSkillInfo('Oracle')">     <!--Oracle-->
    </div>
    <div class="Skill_info">
        <div class="Skill">기술이름</di>
        <div class="Skill_desc">이정도는 껌이죠</div>
        <!--
        <script>
            fetch(`/getSkillInfo?name=${skillName}`)
                .then(response => response.json())
                .then(data => {
                    // 데이터 업데이트
                    document.getElementById('skill-name').innerText = data.name;
                    document.getElementById('skill-desc').innerText = data.description;
                    // 뱃지 주소 업데이트
                    const badges = document.querySelectorAll('.Badge');
                    badges.forEach(badge => {
                        if (badge.alt.includes(data.name)) {
                            badge.src = data.badge_url;
                        }
                    });
                })
            .catch(error => console.error('Error:', error));
        </script>
        -->
    </div>
</div>