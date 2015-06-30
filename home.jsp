<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="fudandb.*, java.sql.*" %>
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title> BookStore of Liang </title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="resource/favicon.ico" />
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
		} else {
			name_q = "'" + name + "'";
		}
		fudandb.Connector con = new Connector();
		fudandb.Book books = new Book();
		fudandb.Customer customers = new Customer();
		fudandb.Common com = new Common();

		int cid = customers.getCid(name_q, con.stmt);
	%>
	<!-- Header -->
	<div id="header" class="shell">
		<div id="logo"><h1><a href="#">BestSeller</a></h1><span><a href="http://www.lyq.me">Designed by Liang Yongqing</a></span></div>
		<!-- Navigation -->
		<div id="navigation">
			<ul>
				<li><a href="#" class="active">Home</a></li>
				<li><a href="browsebook.jsp">Browse Books</a></li>
				<li><a href="degree.jsp">2 Degree</a></li>
				<li><a href="user.jsp">Users</a></li>
				<li><a href="newbook.jsp">New Books</a></li>
			</ul>
		</div>
		<!-- End Navigation -->
		<div class="cl">&nbsp;</div>
		<!-- Login-details -->
		<div id="login-details">
			<p>Welcome, </p><p id="user"><%=name%></p> <p><a id="logout">Logout</a></p><p>&nbsp;&nbsp;&nbsp; My Orders</p> <a href="orders.jsp" class="cart" ><img src="resource/cart-icon.png" alt="orders" /></a>
			<script type="text/javascript">
				$("#logout").click(function(e) {
				    document.cookie = "loginname=";
   					location.href="index.html";
				});
			</script>
		</div>
		<!-- End Login-details -->
	</div>
	<!-- End Header -->
	<!-- Slider -->
	<div id="slider">
		<div class="shell">
			<ul>
				<li>
					<div class="image">
						<img src="resource/books.png" alt="" />
					</div>
					<div class="details">
						<h2>Best Book</h2>
						<h3>Special Offers</h3>
						<p class="title">The World is Flat</p>
						<p class="description">No one today chronicles global shifts in simple and practical terms quite like Friedman. He plucks insights from his travels and the published press that can leave you spinning like a top. Or rather, a pancake.</p>
						<a href="onebook.jsp?ISBN=0312425074" class="read-more-btn">Read More</a>
					</div>
				</li>
				<li>
					<div class="image">
						<img src="resource/books.png" alt="" />
					</div>
					<div class="details">
						<h2>Best Book</h2>
						<h3>Special Offers</h3>
						<p class="title">The Coming Economic Collapse</p>
						<p class="description">Stephen Leeb shows how hard times can be a boon for smart investors. As the world faces an energy crisis of unprecedented scope, renowed economist Stephen Leeb shows how surging oil prices will contribute to an economic collapse.</p>
						<a href="onebook.jsp?ISBN=0446699004" class="read-more-btn">Read More</a>
					</div>
				</li>
				<li>
					<div class="image">
						<img src="resource/books.png" alt="" />
					</div>
					<div class="details">
						<h2>Best Book</h2>
						<h3>Special Offers</h3>
						<p class="title">The World is Flat</p>
						<p class="description">No one today chronicles global shifts in simple and practical terms quite like Friedman. He plucks insights from his travels and the published press that can leave you spinning like a top. Or rather, a pancake.</p>
						<a href="onebook.jsp?ISBN=0312425074" class="read-more-btn">Read More</a>
					</div>
				</li>
				<li>
					<div class="image">
						<img src="resource/books.png" alt="" />
					</div>
					<div class="details">
						<h2>Best Book</h2>
						<h3>Special Offers</h3>
						<p class="title">The Coming Economic Collapse</p>
						<p class="description">Stephen Leeb shows how hard times can be a boon for smart investors. As the world faces an energy crisis of unprecedented scope, renowed economist Stephen Leeb shows how surging oil prices will contribute to an economic collapse.</p>
						<a href="onebook.jsp?ISBN=0446699004" class="read-more-btn">Read More</a>
					</div>
				</li>
			</ul>
			<div class="nav">
				<a href="#">1</a>
				<a href="#">2</a>
				<a href="#">3</a>
				<a href="#">4</a>
			</div>
		</div>
	</div>
	<!-- End Slider -->
	<!-- Main -->
	<div id="main" class="shell">
		<!-- Sidebar -->
		<div id="sidebar">
			<ul class="categories">
				<li>
					<h4>Top Popular Authors</h4>
					<ul>
						<%
							ResultSet popularResult = com.mostPopularAuthor("10", con.stmt);
							while (popularResult.next()) {
						%>
							<li><%=popularResult.getString("author")%></li>
						<%
							}
						%>
					</ul>
				</li>
				<li>
					<h4>Top Popular Publishers</h4>
					<ul>
						<%
							popularResult = com.mostPopular("publisher", "10", con.stmt);
							while (popularResult.next()) {
						%>
							<li><%=popularResult.getString("publisher")%></li>
						<%
							}
						%>
					</ul>
				</li>
			</ul>
		</div>
		<!-- End Sidebar -->
		<!-- Content -->
		<div id="content">
			<!-- Products -->
			<div class="products">
				<h3>Buying Seggestions (Cover Random. lol)</h3>
				<ul>
					<%
						//out.println(cid);
						ResultSet results = com.suggest(String.valueOf(cid), con.stmt);
						int count = 0;
						while (results.next()) {
							count++;
							if (count >= 9) break;
							String ISBN = results.getString("ISBN");
							String href = "'onebook.jsp?ISBN=" + ISBN + "'"; 
							int len = 30;
							String bookName = results.getString("title");
							if (len > bookName.length()) len = bookName.length();
							bookName = bookName.substring(0, len);
							len = 15;
							String author = results.getString("author");
							if (len > author.length()) len = author.length();
							author = author.substring(0, len);
							String d = results.getDouble("price") + "";
							int price = Integer.valueOf(d.substring(0, d.indexOf('.')));
							//String img_href = "'resource/book_" + ISBN + ".jpg'";
							String img_href = "'resource/image0" + count + ".jpg'";
							
					%>
					<li>
						<div class="product">
							<a href=<%=href%> class="info">
								<span class="holder">
									<img src=<%=img_href%> alt="" />
									<span class="book-name"><%=bookName%></span>
									<span class="author"><%=author%></span>
									<span class="description">Some descriptions. <br />More descriptions.</span>
								</span>
							</a>
							<a href=<%=href%> class="buy-btn">BUY NOW <span class="price"><span class="low">$</span><%=price%><span class="high">00</span></span></a>
						</div>
					</li>
					<%
						}

						for (count=count + 1; count <= 8; count++) {
							String img_href0 = "'resource/image0" + count + ".jpg'";
					%>
					<li>
						<div class="product">
							<a href="browsebook.jsp" class="info">
								<span class="holder">
									<img src=<%=img_href0%> alt="" />
									<span class="book-name">Jump to All Books</span>
									<span class="author">Author</span>
									<span class="description">A description.<br />More descriptions. <br />Many descriptions.</span>
								</span>
							</a>
							<a href="browsebook.jsp" class="buy-btn">BUY NOW <span class="price"><span class="low">$</span>40<span class="high">00</span></span></a>
						</div>
					</li>
					<%
						}
					%>
				</ul>
			<!-- End Products -->
			</div>
			<div class="cl">&nbsp;</div>
			<!-- Best-sellers -->
			<div id="best-sellers">
				<h3>Top Popular Books (Cover Random. lol)</h3>
				<ul>
					<%
						count = 0;
						results = com.mostPopular("ISBN", "8", con.stmt);
						while (results.next()) {

							count++;
							String ISBN = results.getString("ISBN");
							String popularHref = "'onebook.jsp?ISBN=" + ISBN + "'"; 
							String img_href = "'resource/image0" + count + ".jpg'";
							int len = 15;
							String bookName = results.getString("title");
							if (len > bookName.length()) len = bookName.length();
							bookName = bookName.substring(0, len);
							len = 15;
							String author = results.getString("author");
							if (len > author.length()) len = author.length();
							author = author.substring(0, len);
							String d= results.getDouble("price") + "";
							int price = Integer.valueOf(d.substring(0, d.indexOf('.')));
							
					%>
						<li>
							<div class="product">
							<a href=<%=popularHref%>>
								<img src=<%=img_href%> alt="" />
								<span class="book-name"><%=bookName%> </span>
								<span class="author"><%=author%></span>
								<span class="price"><span class="low">$</span><%=price%><span class="high">00</span></span>
							</a>
						</li>
					<%
						}
						con.closeConnection();
					%>
				</ul>
			</div>
			<!-- End Best-sellers -->
		</div>
		<!-- End Content -->
		<div class="cl">&nbsp;</div>
	</div>
	<!-- End Main -->
	<!-- Footer -->
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
	<!-- End Footer -->
</body>
</html>