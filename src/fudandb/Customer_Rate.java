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
		attrValue = new String[] { "5", "4", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "0", "5", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "3", "5", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "2", "5", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "4", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "4", "5", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "3", "4", "true" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "2", "0", "false" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "2", "4", "false" };
		this.newCustomer_Rate(attrValue, stmt);
		attrValue = new String[] { "1", "5", "false" };
		this.newCustomer_Rate(attrValue, stmt);

	}

	public void newCustomer_Rate(String attrValue[], Statement stmt)
			throws Exception {

		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);

	}

	public ResultSet showCustomer_Rate(int cid, Statement stmt)
			throws Exception {

		String query = "";

		query = "select c.login_name as customer, t.trusted as trusted "
				+ " from customer as c left join ( "
				+ " select * from customer_rate as cr where cr.cid1=" + cid
				+ ") as t " + " on c.cid=t.cid2;";

		ResultSet results;

		System.out.println(query);

		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}

		return results;

	}

	public void update(int cid1, String name, String trust, Statement stmt)
			throws Exception {

		Customer customers = new Customer();
		int cid2 = customers.getCid("'" + name + "'", stmt);
		String query = "";
		ResultSet results;

		query = "select cr.cid2 as cid from customer_rate as cr where cr.cid1="
				+ String.valueOf(cid1) + ";";
		try {
			results = stmt.executeQuery(query);
		} catch (Exception e) {
			System.err.println("Unable to execute query:" + query + "\n");
			System.err.println(e.getMessage());
			throw (e);
		}
		boolean exist = false;
		while (results.next()) {
			if (results.getInt("cid") == cid2) {
				exist = true;
				break;
			}
		}

		if (exist) {
			query = "update customer_rate set trusted=" + trust
					+ " where cid1=" + String.valueOf(cid1) + " and cid2="
					+ String.valueOf(cid2) + ";";
			try {
				stmt.execute(query);
			} catch (Exception e) {
				System.err.println("Unable to execute query:" + query + "\n");
				System.err.println(e.getMessage());
				throw (e);
			}
		} else {
			String[] attrValue = new String[] { String.valueOf(cid1),
					String.valueOf(cid2), String.valueOf(trust) };
			this.newCustomer_Rate(attrValue, stmt);
		}
	}

	public int countFeedback_rate(Statement stmt) throws Exception {

		Common com = new Common();
		int count = com.countTuple(tableName, stmt);
		return count;
	}

}
