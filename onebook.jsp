<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="fudandb.*, java.sql.*" %>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> One | BookStore of Liang </title>
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
		fudandb.Feedback feedbacks = new Feedback();
		fudandb.Feedback_Rate feedback_rates = new Feedback_Rate();
		fudandb.Customer customers = new Customer();

		int cid = customers.getCid(name_q, con.stmt);
		String ISBN = "'"+(String)request.getParameter("ISBN")+"'";

		String fr_rate_submit = request.getParameter("fr_rate");
		if (fr_rate_submit != null && !fr_rate_submit.equals("-1")) {
			String fid_submit = request.getParameter("fid");
			String[] FR_val = new String[] {fid_submit, String.valueOf(cid), fr_rate_submit};
			feedback_rates.newFeedback_Rate(FR_val, con.stmt);
		}

		String comment_submit = request.getParameter("fb_comment");
		if (comment_submit != null && !comment_submit.equals("")) {
			String fb_rate_submit = request.getParameter("fb_rate");
			String[] FB_val = new String[] {ISBN, String.valueOf(cid), comment_submit, fb_rate_submit};
			feedbacks.newFeedback(FB_val, con.stmt);
		}
	%>
	<!-- Header -->
	<div id="header" class="shell">
		<div id="logo"><h1><a href="#">BestSeller</a></h1><span><a href="http://www.lyq.me">Designed by Liang Yongqing</a></span></div>
		<!-- Navigation -->
		<div id="navigation">
			<ul>
				<li><a href="home.jsp" >Home</a></li>
				<li><a href="browsebook.jsp">Browse Books</a></li>
				<li><a href="newbook.jsp">New Books</a></li>
				<li><a href="#">Promotions</a></li>
				<li><a href="#">Profile</a></li>
				<li><a href="#">About Us</a></li>
				<li><a href="#">Contacts</a></li>
			</ul>
		</div>
		<!-- End Navigation -->
		<div class="cl">&nbsp;</div>
		<!-- Login-details -->
		<div id="login-details">
			<p>Welcome, </p><p id="user"><%=name%></p> <p><a id="logout">Logout</a></p><p><a href="#" class="cart" ><img src="css/images/cart-icon.png" alt="" /></a>Shopping Cart (0) <a href="#" class="sum">$4.00</a></p>
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
		<h3>Book Detail : </h3>
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
				String emptyQuery = " ISBN = " + (String)request.getParameter("ISBN") + " ";
				ResultSet results = books.browseBook(emptyQuery, 4, name_q, con.stmt);
				while (results.next()) {
			%>
			<tr>
				<th><%=results.getString("ISBN")%></th>
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
		<br/>
		<hr/>
		<br/>

		<h3>Feedbacks (Order by Useful) : </h3>
		<%
			
			ResultSet resultFeedback = feedbacks.showFeedback(ISBN, cid, con.stmt);
			while (resultFeedback.next()) {
		%>
			<table border="1">
				<tr>
					<th>Comment</th>
					<th>Rate</th>
					<th>Date</th>
					<th>Customer</th>
					<th>Trust User</th>
					<th>Useful</th>
				</tr>
				<tr>
					<th><%=resultFeedback.getString("comment")%></th>
					<th><%=resultFeedback.getInt("rate")%></th>
					<th><%=resultFeedback.getString("date")%></th>
					<th><%=resultFeedback.getString("customer")%></th>
					<th><%=resultFeedback.getBoolean("trusted")%></th>
					<th><%=resultFeedback.getDouble("useful")%></th>
				</tr>
			</table>
			<div style="padding-left: 3em;">
				<h4>Rate of This Feedback : </h4>
				<table border="1">
					<tr>
						<th>Useful Rate</th>
						<th>Customer</th>
						<th>Trust User</th>
					</tr>
					<%
						int fid = resultFeedback.getInt("fid");
						Statement stmt2 = con.con.createStatement();
						ResultSet resultFR = feedback_rates.showFeedback_Rate(fid, cid, stmt2);
						while (resultFR.next()) {
					%>
						<tr>
							<th><%=resultFR.getInt("rate")%></th>
							<th><%=resultFR.getString("customer")%></th>
							<th><%=resultFR.getBoolean("trusted")%></th>
						
						</tr>
					<%
						}
					%>
				</table>
				<br/>
				<h4>Your New Rate : </h4>
				<%
					if (name.equals(resultFeedback.getString("customer"))) {	
				%>
					<p>Sorry, You can not rate YOURSELF !!</p>	

				<% } else { 

					Statement stmt3 = con.con.createStatement();
					Boolean existFR = feedback_rates.existFeedback_Rate(fid, name, stmt3);
					if (existFR) {
				%>
					<p>Sorry, You can not give your rate more than Twice !!</p>
				<%
					} else {
				%>
					<form action="onebook.jsp" method="POST">
						<input type="hidden" name="ISBN" value=<%="'" + request.getParameter("ISBN") +"'"%> />
						<input type="hidden" name="fid" value=<%= "'" +fid+ "'"%> />
						<select name="fr_rate">
							<option value="-1">------</option>
							<option value="10">Very Useful</option>
							<option value="5">Useful</option>
							<option value="1">Useless</option>
						</select>
						<button type="submit">Submit</button>
					</form>
				<%
					}
				}
				%>
				
				<br/>
			</div>
			<hr/>
			<br/>
		<%
			}
		%>
		<h3>Your New Feedback : </h3>
		<%

			Statement stmt4 = con.con.createStatement();
			Boolean existFB = feedbacks.existFeedback(ISBN, name, stmt4);
			if (existFB) {
		%>
			<p>Sorry, You can not give Feedback more than Twice !!</p>
		<%
			} else {
		%>
			<form action="onebook.jsp" method="POST">
				<input type="hidden" name="ISBN" value=<%="'" + request.getParameter("ISBN") +"'"%> />
				<label>Comment : </label>
				<input type="text" name="fb_comment" required="required"/>
				<label>Rate : </label>
				<select name="fb_rate">
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
				<button type="submit">Submit</button>
			</form>
		<%
			}
		%>
		<%
			con.closeConnection();
		%>

	</div>

	<div id="footer" class="shell">
		<div class="top">
			<div class="cnt">
				<div class="col about">
					<h4>About BestSellers</h4>
					<p>Nulla porttitor pretium mattis. Mauris lorem massa, ultricies non mattis bibendum, semper ut erat. Morbi vulputate placerat ligula. Fusce <br />convallis, nisl a pellentesque viverra, ipsum leo sodales sapien, vitae egestas dolor nisl eu tortor. Etiam ut elit vitae nisl tempor tincidunt. Nunc sed elementum est. Phasellus sodales viverra mauris nec dictum. Fusce a leo libero. Cras accumsan enim nec massa semper eu hendrerit nisl faucibus. Sed lectus ligula, consequat eget bibendum eu, consequat nec nisl. In sed consequat elit. Praesent nec iaculis sapien. <br />Curabitur gravida pretium tincidunt.  </p>
				</div>
				<div class="col store">
					<h4>Store</h4>
					<ul>
						<li><a href="#">Home</a></li>
						<li><a href="#">Special Offers</a></li>
						<li><a href="#">Log In</a></li>
						<li><a href="#">Account</a></li>
						<li><a href="#">Basket</a></li>
						<li><a href="#">Checkout</a></li>
					</ul>
				</div>
				<div class="col" id="newsletter">
					<h4>Newsletter</h4>
					<p>Lorem ipsum dolor sit amet  consectetur. </p>
					<form action="" method="post">
						<input type="text" class="field" value="Your Name" title="Your Name" />
						<input type="text" class="field" value="Email" title="Email" />
						<div class="form-buttons"><input type="submit" value="Submit" class="submit-btn" /></div>
					</form>
				</div>
				<div class="cl">&nbsp;</div>
				<div class="copy">
					<p>&copy; <a href="#">BestSeller.com</a>. Design by <a href="http://css-free-templates.com/">CSS-FREE-TEMPLATES.COM</a></p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
