<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String width = "80%";
    String height = "500px";
    response.setContentType("application/json");
    response.getWriter().write("{\"width\": \"" + width + "\", \"height\": \"" + height + "\"}");
%>