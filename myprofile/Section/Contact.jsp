<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="Contact_container">
    <h1 class="Contact_title">Contact</h1>
    <form method="post" action="Section/SendContact.jsp" class="Contact_form" accept-charset="UTF-8">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>

        <label for="msg">Message:</label>
        <textarea id="msg" name="msg" rows="5" required></textarea>

        <button type="submit" name="submit" value="전송 완료">Send</button>
    </form>

    
</div>