package fudandb;

import java.sql.ResultSet;
import java.sql.Statement;

public class Feedback_Rate {

	private String[] attrName = { "fid", "cid", "fb_rate" };
	private String tableName = "feedback_rate";

	public Feedback_Rate() {
	}

	public void initFeedback_Rate(Statement stmt) throws Exception {

		String[] attrValue;

		attrValue = new String[] { "0", "3", "10" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "0", "1", "10" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "0", "2", "5" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "0", "10" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "2", "5" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "4", "5" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "2", "5", "1" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "4", "3", "10" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "4", "5", "1" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "3", "1", "5" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "5", "2", "10" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "0", "5", "10" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "7", "4", "5" };
		this.newFeedback_Rate(attrValue, stmt);
		attrValue = new String[] { "8", "4", "10" };
		this.newFeedback_Rate(attrValue, stmt);
	}

	public void newFeedback_Rate(String attrValue[], Statement stmt)
			throws Exception {

		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);

	}

	public ResultSet showFeedback_Rate(int fid, int user, Statement stmt)
			throws Exception {

		String query = "select fr.fb_rate as rate, c.login_name as customer, cr.trusted as trusted " 
				+ "from feedback_rate as fr left join customer as c on fr.cid=c.cid " 
				+ "left join customer_rate as cr on cr.cid2=c.cid and cr.cid1=" + user + " "
				+ "where fr.fid=" + fid + ";";
		 
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
	
	public Boolean existFeedback_Rate(int fid, String user, Statement stmt) throws Exception {
		
		String query = "select c.login_name as customer " 
				+ "from feedback_rate as fr natural join customer as c "
				+ "where fr.fid=" + fid + ";"; 
				
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

	public int countFeedback_rate(Statement stmt) throws Exception {

		Common com = new Common();
		int count = com.countTuple(tableName, stmt);
		return count;
	}
}
