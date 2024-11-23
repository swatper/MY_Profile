<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String width = "100%";
    String height = "auto";
    response.setContentType("application/json");
    response.getWriter().write("{\"width\": \"" + width + "\", \"height\": \"" + height + "\"}");
%>