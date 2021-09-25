<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8" />
<title>Details</title>
</head>
<body>
	<div class="container mx-auto" style="width:800px;">
	<div class="container-sm my-3 p-3 col-8">
		<div class="d-flex justify-content-between" style="color:#195f9b">
			<h3 class="p-3"><c:out value="${ book.title }"/></h3>
			<a href="/books">back to the shelves</a>
		</div>
		<div class="container-sm my-3 p-3 col-8">
		<p class="p-3">
		 <c:choose> 
		 	<c:when test="${ book.owner.id==user.id }">
		 	
		 	<span style="color:#6495ED;">You </span>
			</c:when>
			<c:otherwise>
			<span style="color:#00BFFF;"><c:out value="${ book.owner.username }"/> </span>
			</c:otherwise>
		 </c:choose>
			read <span style="color:#FF7F50;"><c:out value="${ book.title }"/></span> 
			by <span style="color:#1E90FF;"><c:out value="${ book.author }"/></span>
		</p>
		<hr class="dashed">
		<p>
			<c:out value="${ book.thought }" />
		</p>
		<hr class="dashed">
		</div>
		<div class="container-sm my-3 p-3 col-8">
			<c:if test="${ book.owner.id==user.id }">
				<a href="/books/${ book.id }/edit">Edit</a>
			</c:if>
		</div>
	</div>
	</div>
</body>
</html>