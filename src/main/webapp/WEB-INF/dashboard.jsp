<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8" />
<title>All Books</title>
</head>
<body>
	<div class="container mx-auto" style="width:800px; ">
		<div class="d-flex justify-content-between" style="color:#195f9b">
		<h3 class="p-3">Welcome <c:out value="${ user.username }" /></h3>
		<a href="/logout">Logout</a>
		</div>
		<div class="d-flex justify-content-around" style="color:#195f9b">
		<h5 class="p-3">Books from everyone's shelves</h5>
		<a href="/bookmarket">Book Market</a>
		<a href="/books/new">+Add one to my shelf</a>
		</div>
		<div class="container-sm my-3 p-3 col-8" style="border:1px solid black">
			<table class="table table-striped table-hover">
			<thead>
		    <tr>
		      <th scope="col">ID</th>
		      <th scope="col">Title</th>
		      <th scope="col">Author</th>
		      <th scope="col">Posted By</th>
		    </tr>
			</thead>
			<tbody>
			<c:forEach var="b" items="${ allbooks }">
				<tr>
					<td scope="row"><c:out value="${ b.id }"/></td>
					<td scope="row"><a href="/books/${ b.id }"><c:out value="${ b.title }"/></a></td>
					<td scope="row"><c:out value="${ b.author }"/></td>
					<td scope="row"><c:out value="${ b.getOwner().getUsername() }"/></td>
				</tr>
			</c:forEach>
  			</tbody>
			</table>
		</div>
	</div>
</body>
</html>