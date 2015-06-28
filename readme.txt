1. Compile the java code in WEB-INF/classes: javac fudandb/*.java

2. Edit the web.xml in WEB-INF; replace Your Name with your first name
and last name.

3. Access your homepage via http://10.141.208.26:8080/~fudanuxx

4. To work on your own database, you need to modify the credentials in Connector.java (so that it connects to your own database, rather than the class-wide database acmdb). Note that the sample JSP code then will not work, since the sample "orders" table does not exist in your own database. You can always use the distributed script orders.sql (use "source orders.sql;" in mysql client) to produce that table in your own database, so that the sample JSP code will work with your own database. (be careful when doing this if your database already has a "orders" table from your phase 1; that table will be overwritten. To avoid that, change the orders.sql script to have a different table name, and also change the Orders.java code to query the new table instead).

5. Place any of your JSP pages directly under the public_html folder, and your java code
with the necessary package folder structure under the WEB-INF/classes folder.
You can then access your abc.jsp page from http://10.141.208.26:8080/~fudanuxx/abc.jsp. And inside your abc.jsp page, you can import your java class (see orders.jsp for an example).

