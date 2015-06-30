<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="fudandb.*, java.sql.*" %>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> Browse | BookStore of Liang </title>
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
				<li><a href="#" class="active">Browse Books</a></li>
				<li><a href="degree.jsp">2 Degree</a></li>
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
		<h3>All Books ( Just for Testing Browsing ): </h3>
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
		<br/><br/>
		<h3>Browse Books ( Case Sensitive ): </h3>
		<form action="browsebook.jsp" method="POST">
			<label>Type 1 : </label>
			<select name="type1" >
				<option value="author">author</option>	
				<option value="publisher">publisher</option>
				<option value="title">title-word</option>
				<option value="subject">subject</option>
			</select>
			<label>Value 1 : </label>
			<input name="value1" type="text">
			<br/>
			<label>Conjective 1 and 2 : </label>
			<select name="conj1">
				<option value="and">and</option>
				<option value="or">or</option>
			</select>
			<br/>
			<label>Type 2 : </label>
			<select name="type2" >
				<option value="author">author</option>	
				<option value="publisher">publisher</option>
				<option value="title">title-word</option>
				<option value="subject">subject</option>
			</select>
			<label>Value 2 : </label>
			<input name="value2" type="text">
			<br/>
			<label>Conjective 2 and 3 : </label>
			<select name="conj2">
				<option value="and">and</option>
				<option value="or">or</option>
			</select>
			<br/>
			<label>Type 3 : </label>
			<select name="type3" >
				<option value="author">author</option>	
				<option value="publisher">publisher</option>
				<option value="title">title-word</option>
				<option value="subject">subject</option>
			</select>
			<label>Value 3 : </label>
			<input name="value3" type="text">
			<br/>
			<label>Conjective 3 and 4 : </label>
			<select name="conj3">
				<option value="and">and</option>
				<option value="or">or</option>
			</select>
			<br/>
			<label>Type 4 : </label>
			<select name="type4" >
				<option value="author">author</option>	
				<option value="publisher">publisher</option>
				<option value="title">title-word</option>
				<option value="subject">subject</option>
			</select>
			<label>Value 4 : </label>
			<input name="value4" type="text">
			<br/><br/>
			<label>Sort By : </label>
			<select name="sort" >
				<option value="0">Don't sort</option>
				<option value="1">Year</option>
				<option value="2">Avg Numerical Scores of Feedbacks</option>
				<option value="3">Avg Numerical Scores of TRUSTED Users' Feedbacks</option>
			</select>
			<button type="submit">Submit</button>
		</form>
		<br/>
		<br/>
		<h3>Results of Search</h3>
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
				String query = "";
				String value, type, conj;
				value = (String)request.getParameter("value1");
				type = (String)request.getParameter("type1");
				if (value != null && !value.equals("")) {
					query += type + " like " + "'%" + value + "%'";
									
					value = (String)request.getParameter("value2");
					type = (String)request.getParameter("type2");
					if (value != null && !value.equals("")) {
						conj = (String)request.getParameter("conj1");
						query += conj + " ";
						query += type + " like " + "'%" + value + "%'";
					
						value = (String)request.getParameter("value3");
						type = (String)request.getParameter("type3");
						if (value != null && !value.equals("")) {
							conj = (String)request.getParameter("conj2");
							query += conj + " ";
							query += type + " like " + "'%" + value + "%'";
						
							value = (String)request.getParameter("value4");
							type = (String)request.getParameter("type4");
							if (value != null && !value.equals("")) {
								conj = (String)request.getParameter("conj3");
								query += conj + " ";
								query += type + " like " + "'%" + value + "%'";
							}
						}
					}

					out.println(query);
					int sort = Integer.valueOf((String)request.getParameter("sort"));
					results = books.browseBook(query, sort, name_q, con.stmt);
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
				}
			%>
			
		</table>
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