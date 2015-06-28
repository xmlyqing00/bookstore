package fudandb;

import java.sql.ResultSet;
import java.sql.Statement;

public class Customer_Rate {

	private String[] attrName = { "cid1", "cid2", "trusted" };
	private String tableName = "customer_rate";

	public Customer_Rate() {
	}

	public void initCustomer_Rate(Statement stmt) throws Exception {

		String[] attrValue;
		
		attrValue = new String[] { "0", "1", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "0", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "0", "2", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "0", "3", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "2", "1", "false" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "2", "3", "false" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "2", "false" };
		this.newCustomer_Rate(attrValue, stmt);

	}

	public void newCustomer_Rate(String attrValue[], Statement stmt)
			throws Exception {

		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);

	}

	public ResultSet showCustomer_Rate(String[] sigmaAttr, String[] sigmaValue,
			Statement stmt) throws Exception {

		Common com = new Common();
		return com.showTable(sigmaAttr, sigmaValue, tableName, stmt);

	}

	public int countFeedback_rate(Statement stmt) throws Exception {

		Common com = new Common();
		int count = com.countTuple(tableName, stmt);
		return count;
	}

}
