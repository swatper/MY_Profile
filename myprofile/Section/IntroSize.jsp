<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //메인 html에 넘겨줄 jsp가 사용할 페이지 크기
    String width = "80%";
    String height = "auto";
    //Ajax 요청에 대한 전달
    response.setContentType("application/json");
    response.getWriter().write("{\"width\": \"" + width + "\", \"height\": \"" + height + "\"}");
%>