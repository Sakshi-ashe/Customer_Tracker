<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.luv2code.springdemo.util.SortUtils" %>

<!-- spring mvc form tags are fantastic when data binding
	error messages etc-->
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>List Customers</title>
	<link type="text/css" 
			rel="stylesheet"
			href="${pageContext.request.contextPath}/resources/css/style.css">
			
	<!-- pageContext.request.contextPath gives name of our application -->
</head>
<body>
	<div id="wrapper">
			<div id="header">
					<h2>CRM -Customer Relationsip Manager</h2>
			</div>
	</div>
	
	<div id="container">
			<div id="content">
			
					<!-- put new button: Add Customer -->
					<input type="button" value="Add Customer"
							onclick="window.location.href='showFormForAdd';return false;"
							class="add-button"
					/>
					
					<!--  add a search box -->
		            <form:form action="search" method="GET">
		                Search customer: <input type="text" name="theSearchName" />
		                
		                <input type="submit" value="Search" class="add-button" />
		            </form:form>
		            
   
   
    				<!-- construct a sort link for first name -->
    				<c:url var="sortLinkFirstName" value="/customer/list">
    					<c:param name="sort" value="<%= Integer.toString(SortUtils.FIRST_NAME) %>" />
    				</c:url>		


    				<!-- construct a sort link for last name -->
    				<c:url var="sortLinkLastName" value="/customer/list">
    					<c:param name="sort" value="<%= Integer.toString(SortUtils.LAST_NAME) %>" />
    				</c:url>					
     
    				<!-- construct a sort link for email -->
    				<c:url var="sortLinkEmail" value="/customer/list">
    					<c:param name="sort" value="<%= Integer.toString(SortUtils.EMAIL) %>" />
    				</c:url>					



    				
					<!-- add out html table here -->
					<table>
							<tr>
    					<th><a href="${sortLinkFirstName}">First Name</a></th>
    					<th><a href="${sortLinkLastName}">Last Name</a></th>
    					<th><a href="${sortLinkEmail}">Email</a></th>
    					<th>Action</th>
    				</tr>
							
							<!-- loop over and print our customers -->
							<c:forEach var="tempCustomer" items="${customers}">
							
									<!-- construct an update link with customer id -->
									<c:url var="updateLink" value="/customer/showFormForUpdate">
										<c:param name="customerId" value="${tempCustomer.id}" />
									</c:url>
									<!-- construct an delete link with customer id -->
									<c:url var="deleteLink" value="/customer/delete">
										<c:param name="customerId" value="${tempCustomer.id}" />
									</c:url>
									<tr>
										<td>${tempCustomer.firstName}</td>
										<td>${tempCustomer.lastName}</td>	
										<td>${tempCustomer.email}</td>								
										<td> 
											<!-- http://localhost:8081/web-customer-tracker/customer/showFormForUpdate?customerId=6-->
											<a href="${updateLink}">Update</a>
											|
											<!-- http://localhost:8081/web-customer-tracker/customer/delete?customerId=2 -->
											<a href="${deleteLink}"
											onClick="if (!(confirm('Are you sure you want to delete this customer?')))  return false">Delete</a>
										</td>							
									</tr>
							</c:forEach>
					</table>
			</div>
	</div>
</body>
</html>