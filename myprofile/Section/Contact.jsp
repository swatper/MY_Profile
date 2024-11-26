<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="Contact_container">
    <h1 class="Contact_title">Contact</h1>
    <form>
        <label for="name">Name</label>
        <input type="text" id="name" name="name" placeholder="Enter your name">

        <label for="title">Title</label>
        <input type="text" id="title" name="title" placeholder="Enter a title">

        <label for="message">Message</label>
        <textarea id="message" name="message" rows="10" placeholder="Enter your message"></textarea>

        <button type="submit">Send</button>
    </form>
</div>