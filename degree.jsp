<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="fudandb.*, java.sql.*" %>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> 2 Degree | BookStore of Liang </title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="css/images/favicon.ico" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
	<!--[if IE 6]>
		<script type="text/javascript" src="js/png-fix.js"></script>
	<![endif]-->
	<script type="text/javascript" src="js/functions.js"></script>
</head>
<body>
	<%
		Cookie[] cookies = request.getCookies();
		String name="", name_q="";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				
				if (cookie.getName().equals("loginname")) {
					name = cookie.getValue();
					break;
				}
			}
		}
		if (name.equals("")) {
	%>
		<script type="text/javascript">
			alert("Please Login First !!");
			location.href="index.html";
		</script>
	<% 
		} 
		name_q = "'" + name + "'";
		
		fudandb.Connector con = new Connector();
		fudandb.Book books = new Book();
		
	%>
	<!-- Header -->
	<div id="header" class="shell">
		<div id="logo"><h1><a href="#">BestSeller</a></h1><span><a href="http://www.lyq.me">Designed by Liang Yongqing</a></span></div>
		<!-- Navigation -->
		<div id="navigation">
			<ul>
				<li><a href="home.jsp" >Home</a></li>
				<li><a href="browsebook.jsp">Browse Books</a></li>
				<li><a href="#" class="active">2 Degree</a></li>
				<li><a href="user.jsp">Users</a></li>
				<li><a href="newbook.jsp">New Books</a></li>
			</ul>
		</div>
		<!-- End Navigation -->
		<div class="cl">&nbsp;</div>
		<!-- Login-details -->
		<div id="login-details">
			<p>Welcome, </p><p id="user"><%=name%></p> <p><a id="logout">Logout</a></p><p>&nbsp;&nbsp;&nbsp; My Orders</p> <a href="orders.jsp" class="cart" ><img src="css/images/cart-icon.png" alt="orders" /></a>
			<script type="text/javascript">
				$("#logout").click(function(e) {
				    document.cookie = "loginname=";
   					location.href="index.html";
				});
			</script>
		</div>
		<!-- End Login-details -->
	</div>
	<div id="main" class="shell">
		<h3>All Books ( Just for Testing Degree ): </h3>
		<table border="1">
			<tr>
				<th>ISBN</th>
				<th>Title</th>
				<th>Author</th>
				<th>Publisher</th>
				<th>Publish_Year</th>
				<th>Copies</th>
				<th>Price</th>
				<th>Format</th>
				<th>Keywords</th>
				<th>Subject</th>
				<th>rate</th>
				<th>trust_rate</th>
			</tr>
			<%
				String emptyQuery = "";
				ResultSet results = books.browseBook(emptyQuery, 4, name_q, con.stmt);
				while (results.next()) {
			%>
			<tr>
				<%
					String ISBN = results.getString("ISBN");
					String href = "'onebook.jsp?ISBN=" + ISBN + "'";
				%>
				<th><a target="_blank" href=<%=href%> ><%=ISBN%></a></th>
				
				<th><%=results.getString("title")%></th>
				<th><%=results.getString("author")%></th>
				<th><%=results.getString("publisher")%></th>
				<th><%=results.getString("publish_year")%></th>
				<th><%=results.getInt("copies")%></th>
				<th><%=results.getDouble("price")%></th>
				<th><%=results.getString("format")%></th>
				<th><%=results.getString("keywords")%></th>
				<th><%=results.getString("subject")%></th>
				<th><%=results.getDouble("rate")%></th>
				<th><%=results.getDouble("trust_rate")%></th>
			</tr>
			<%
				}
			%>
			
		</table>
		<br/><hr/><br/>
		<h3>Two Authors Degree: </h3>
		<form action="degree.jsp" method="post">
			<label>Author 1 : </label>
			<input type="text" name="author1" required="required"/>
			<label>Author 2 : </label>
			<input type="text" name="author2" required="required"/>
			<button type="submit">Submit</button>
		</form>
		<p>Example 1 Degree ---- Author 1 : Lifeifei and Author 2 : Xiaohong</p>
		<p>Example 2 Degree ---- Author 1 : Xiaoming and Author 2 : Xiaohong</p>
		<br/><hr/><br/>
		<h3>Result of Degree : </h3>
		<%
			String author1 = (String)request.getParameter("author1");
			String author2 = (String)request.getParameter("author2");
			String degree = "";
			if (author1 != null && !author1.equals("")) {
				fudandb.Common com = new Common();
				degree = com.degree(author1, author2, con.stmt);
				if (degree.charAt(0) == '0') {
		%>
				<p>Degree is 0.</p>
		<%
				} else if (degree.charAt(0) == '1') {
		%>
				<p>Degree is 1. Share by <%=degree.substring(1)%>.</p>
		<%
				} else {
		%>
				<p>Degree is 2. Share by <%=degree.substring(1)%>.</p>		
		<%
				}
			}
			con.closeConnection();
		%>

	</div>
<div id="footer" class="shell">
		<div class="top">
			<div class="cnt">
				<div class="col about">
					<h4>About Me</h4>
					<p>Name : Liang Yongqing </p>
					<p>NO : 13307130254 </p>
					<p>HomePage : http://www.lyq.me </p>
					<p>Mail : 13307130254@fudan.edu.cn / root@lyq.me </p>
					<p>Skill : Computer Vision & Graphics</p>

				</div>
				
				<div class="col" id="newsletter">
					<h4>About Website</h4>
					<p>BUILT FOR ALL FUNCTIONALITY !! </p>
					<p>If you can NOT find ANY functionality. Please Contact Me :)</p>
					<p>If you want to MINUS MY SCORE. Please Contact Me :(</p>
					<br/>
					<p>Amazing database class !! Inspired me many ideas.</p>
					<p>Thanks Feifei a lot !!</p>
				</div>
				<div class="cl">&nbsp;</div>
				<div class="copy">
					<p>&copy; <a href="#">BestSeller.com</a>. Design by <a href="http://www.lyq.me/">Liang Yongqing</a></p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
