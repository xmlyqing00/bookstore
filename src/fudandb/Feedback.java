package fudandb;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;

public class Feedback {

	private String[] attrName = { "fid", "ISBN", "cid", "comment", "rate",
			"fb_date" };
	private String tableName = "feedback";

	public Feedback() {
	}

	public void initFeedback(Statement stmt) throws Exception {

		String[] attrValue;

		attrValue = new String[] { "'0133760065'", "0",
				"Good Good Good", "10", "2015-5-3" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] { "'0133760065'", "2", "so so", "5",
				"2015-5-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] { "'9787500794486'", "1", "bad", "2",
				"2015-5-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'9787500794486'", "0", "so so", "5",
				"2015-5-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'9787111407010'", "1", "god like",
				"8", "2015-5-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'9787111407010'", "5", "I like it",
				"8", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'9787111407010'", "4", "I like it",
				"7", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'747266093'", "5", "I like it",
				"8", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'666666'", "2", "I like it",
				"8", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'123456'", "0", "I like it",
				"8", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'515130044'", "0", "I like it",
				"8", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'515130044'", "2", "Nice book",
				"6", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'9787500794486'", "1", "Nice book",
				"6", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'9787500794486'", "4", "Good Good",
				"6", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'0312425074'", "5", "Nice book",
				"6", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		attrValue = new String[] {  "'0312425074'", "3", "Nice",
				"6", "2015-6-10" };
		this.newFeedback(attrValue, stmt);
		
		
	}

	public void newFeedback(String attrValue0[], Statement stmt)
			throws Exception {
		
		int count = this.countFeedback(stmt);
		Calendar ca = Calendar.getInstance();
		int year = ca.get(Calendar.YEAR);
		int month = ca.get(Calendar.MONTH) + 1;
		int day = ca.get(Calendar.DATE);
		String date = "'" + year + "-" + month + "-" + day + "'";
		String[] attrValue = new String[] {String.valueOf(count), attrValue0[0],
				attrValue0[1], "'"+attrValue0[2]+"'", attrValue0[3], date}; 
		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);
	}

	public ResultSet showFeedback(String ISBN, int user, Statement stmt) throws Exception {

		String query = "";
		
		query = "select *, t.fid as fid, avg(fr.fb_rate) as useful from customer_rate as cr right join ("
				+ " select b.title as title, c.login_name as customer, f.comment as comment, f.rate as rate, f.fb_date as date, f.fid as fid, c.cid as cid" 
				+ " from feedback as f, book as b ,customer as c " 
				+ " where b.ISBN=f.ISBN and c.cid=f.cid and f.ISBN=" + ISBN + ") as t on cr.cid2=t.cid and cr.cid1=" + user + " "
				+ " left join feedback_rate as fr on fr.fid=t.fid "
				+ " group by t.fid "
				+ " order by avg(fr.fb_rate) desc;";
		
		System.out.println(query);

		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}

		return results;

	}
	
	public Boolean existFeedback(String ISBN, String user, Statement stmt) throws Exception {
		
		String query = "select c.login_name as customer " 
				+ "from feedback as f natural join customer as c "
				+ "where f.ISBN=" + ISBN + ";"; 
				
		System.out.println(query);

		ResultSet results;
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		
		while (results.next()) {
			if (results.getString("customer").equals(user)) return true;
		}

		return false;
	}

	public int countFeedback(Statement stmt) throws Exception {

		Common com = new Common();
		int count = com.countTuple(tableName, stmt);
		return count;
	}

}
