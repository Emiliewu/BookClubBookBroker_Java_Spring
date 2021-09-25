<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8" />
<title>Edit</title>
</head>
<body>
	<div class="container mx-auto" style="width:800px;">
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
		<div class="container-sm my-3 p-3 col-8">
			<div class="d-flex justify-content-between" style="color:#195f9b">
			<h3 class="p-3">Change your Entry </h3>
			<a href="/books">back to the shelves</a>
			</div>
			<form:form action="/books/${ editbook.id }/update" method="POST" modelAttribute="editbook">	
			<input type="hidden" name="_method" value="PUT">
			<form:hidden path="borrower" />	
			<form:hidden path="owner" />	
		    <div class="mb-3 row">
		        <form:label path="title" class="col-sm-2 col-form-label">Title</form:label>
		        <div class="col-sm-10">
		        <form:errors path="title" style="color:red;"/>
		        <form:input path="title" class="form-control"/>
		        </div>
		    </div>
		    <div class="mb-3 row">
		        <form:label path="author" class="col-sm-2 col-form-label">Author</form:label>
		        <div class="col-sm-10">
		        <form:errors path="author" style="color:red;"/>
		        <form:input path="author" class="form-control"/>
		        </div>
		    </div>
		    <div class="mb-3 row">
		        <form:label path="thought" class="col-sm-3 col-form-label">thought: </form:label>
		        <div class="col-sm-9">
		        <form:errors path="thought" style="color:red;"/>
		        <form:input path="thought" class="form-control"/>
		        </div>
		    </div>
		    <div class="row my-2">
	         	<div class="container">
	       	      <button class="btn btn-primary" type="submit">Submit</button>
	         	</div>
	         </div>
		</form:form>  
		<c:if test="${ editbook.borrower==null }">
			<a href="/books/${ editbook.id }/delete">Delete</a>
		</c:if>
		</div>
	</div>
</body>
</html>