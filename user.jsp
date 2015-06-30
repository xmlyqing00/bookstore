<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="fudandb.*, java.sql.*" %>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> Users | BookStore of Liang </title>
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
		fudandb.Customer customers = new Customer();
		fudandb.Common com = new Common();
		fudandb.Customer_Rate customer_rates = new Customer_Rate();

		int cid = customers.getCid(name_q, con.stmt);

		String _trust = (String)request.getParameter("_trust");
		if (_trust != null && !_trust.equals("null")) {
			String _name = (String)request.getParameter("_name");
			customer_rates.update(cid, _name, _trust, con.stmt);
	%>
		<script type="text/javascript">
			alert("Update Customer Rate Successful !! ");
		</script>
	<%
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
				<li><a href="degree.jsp">2 Degree</a></li>
				<li><a href="#" class="active">Users</a></li>
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
		
		<h3>All Users : </h3>
		<table border="1">
			<tr>
				<th>&nbsp;Customer&nbsp;</th>
				<th>&nbsp;Trust Him / Her&nbsp;</th>
				<th>&nbsp;Trust Change&nbsp;</th>
			</tr>
		<%
			ResultSet results;
			results = customer_rates.showCustomer_Rate(cid, con.stmt);
			while (results.next()) {
		%>
			<tr>
				<th><%=results.getString("customer")%></th>
				<th><%=results.getBoolean("trusted")%></th>
				<th>
					<form action="user.jsp" method="post">
						<input type="hidden" name="_name" value=<%="'" + results.getString("customer")+"'"%>/>
						&nbsp;
						<label>True:</label>
						<input type="radio" name="_trust" value="true" />
						&nbsp;
						<label>False:</label>
						<input type="radio" name="_trust" value="false" />
						&nbsp;
						<label>NULL:</label>
						<input type="radio" name="_trust" value="null" checked="checked" />
						&nbsp;
						<%
							if (results.getString("customer").equals(name)) {
						%>
							<button type="submit" disabled="disabled">Submit</button>
						<%
							} else {
						%>
							<button type="submit">Submit</button>
						<%
							}
						%>
					</form>
				</th>
			</tr>
		<%
			}
		%>
		</table>
		<br/>
		<hr/>
		<br/>
		<h3>Most Trusted User : </h3>
		<table border="1">
			<tr>
				<th>&nbsp;Customer&nbsp;</th>
				<th>&nbsp;Trust Score&nbsp;</th>
			</tr>
		<%
			results = com.mostTrustUser(con.stmt);
			while (results.next()) {
		%>
			<tr>
				<th><%=results.getString("login_name")%></th>
				<th><%=results.getDouble("score")%></th>
			</tr>
		<%
			}
		%>
		</table>
		<br/>
		<hr/>
		<br/>
		<h3>Most Useful User : </h3>
		<table border="1">
			<tr>
				<th>&nbsp;Customer&nbsp;</th>
				<th>&nbsp;Useful Score&nbsp;</th>
			</tr>
		<%
			results = com.mostUsefulUser(con.stmt);
			while (results.next()) {
		%>
			<tr>
				<th><%=results.getString("login_name")%></th>
				<th><%=results.getDouble("score")%></th>
			</tr>
		<%
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
					<p>Amazing database class !! Inspired me many idas.</p>
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
