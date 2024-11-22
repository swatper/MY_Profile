<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String width = "100%";
    String height = "auto";
    //Ajax 요청에 대한 전달
    response.getWriter().write("{\"width\": \"" + width + "\", \"height\": \"" + height + "\"}");
%>