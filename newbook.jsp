<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="fudandb.*, java.sql.*" %>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> Add Book | BookStore of Liang </title>
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
		} else if (!name.equals("root")) {
	%>
		<script type="text/javascript">
			alert("You Do NOT have ROOT Permission !! ");
			history.go(-1);
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
				<li><a href="browsebook.jsp" >Browse Books</a></li>
				<li><a href="degree.jsp">2 Degree</a></li>
				<li><a href="user.jsp">Users</a></li>
				<li><a href="#" class="active">New Books</a></li>
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
	<%
		String copy = (String)request.getParameter("copy");
		if (copy != null && !copy.equals("")) {
			
			String title = (String)request.getParameter("book_name");	

			String[] attr = {"copies"};
			String[] value = {copy};
			books.updateBook("title", "'"+title+"'", attr, value, con.stmt);
	%>
	<script type="text/javascript">alert("Update Copies of Book Successful !!")</script>
	<%
		}
		String ISBN = (String)request.getParameter("ISBN");
		if (ISBN != null && !ISBN.equals("")) {
		
			String title = "'"+(String)request.getParameter("title")+"'";
			String author = "'"+(String)request.getParameter("author")+"'";
			String publisher = "'"+(String)request.getParameter("publisher")+"'";
			String publish_year = "'"+(String)request.getParameter("publish_year")+"'";
			String copies = (String)request.getParameter("copies");
			String price = (String)request.getParameter("price");
			String format = "'"+(String)request.getParameter("format")+"'";
			String keywords = "'"+(String)request.getParameter("keywords")+"'";
			String subject = "'"+(String)request.getParameter("subject")+"'";

			String[] bookValue = new String[] {ISBN, title, author, publisher, publish_year, copies, price, format, keywords, subject};
			books.newBook(bookValue, con.stmt);
	%>
	<script type="text/javascript">alert("Add New Book Successful !!")</script>
	<%
		}
	%>
	<div id="main" class="shell">
		<h3>Arrival of more copies : </h3>
		<form action="newbook.jsp" method="POST">
			<label>Name of Book : </label>
			<select name="book_name" >
				<%
					String query = "";
					ResultSet results = books.browseBook(query, 0, name_q, con.stmt);
					while (results.next()) { 
						String title = results.getString("title");
						String title_q = "'" + title + "'";
				%>
					<option value=<%= title_q%>><%= title%></option>	
				<% } %>
			</select>
			<label>Copies of Book : </label>
			<input name="copy" type="text">
			<button type="submit" onclick="return checkMoreCopies()">Submit</button>
		</form>
		<br/>

		<h3>New book : </h3>
		<form action="newbook.jsp" method="POST">
			
			<label>ISBN : </label>
			<input name="ISBN" type="text">
			<label>Title : </label>
			<input name="title" type="text">
			<label>Author (Strictly Split by ',') : </label>
			<input name="author" type="text">
			<br/>
			<label>Publisher : </label>
			<input name="publisher" type="text">
			<label>publish_year (yyyy-mm-dd) : </label>
			<input name="publish_year" type="text">
			<br/>
			<label>Copies : </label>
			<input name="copies" type="text">
			<label>Price : </label>
			<input name="price" type="text">
			<label>Format : </label>
			<input name="format" type="text">
			<br/>
			<label>Keywords: </label>
			<input name="keywords" type="text">
			<label>Subject: </label>
			<input name="subject" type="text">
			<button type="submit" onclick="return checkNewBook()">Submit</button>
		</form>
		
		<%
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