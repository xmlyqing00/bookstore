package fudandb;

import java.sql.ResultSet;
import java.sql.Statement;

public class Orders {

	private String[] attrName = { "oid", "ISBN", "cid", "buy_date", "amount" };
	private String tableName = "orders";

	public Orders() {
	}

	public void initOrders(Statement stmt) throws Exception {

		String[] attrValue;

		attrValue = new String[] { "0", "'0133760065'", "0", "'2015-3-20'", "3" };
		this.newOrders(attrValue, stmt);
		attrValue = new String[] { "1", "'0133760065'", "0", "'2015-3-22'", "2" };
		this.newOrders(attrValue, stmt);
		attrValue = new String[] { "2", "'0133760065'", "2", "'2015-3-20'", "5" };
		this.newOrders(attrValue, stmt);
		attrValue = new String[] { "3", "'9787500794486'", "1", "'2015-4-20'",
				"1" };
		this.newOrders(attrValue, stmt);
		attrValue = new String[] { "4", "'9787500794486'", "0", "'2015-4-20'",
				"2" };
		this.newOrders(attrValue, stmt);
		attrValue = new String[] { "5", "'9787111407010'", "1", "'2015-4-20'",
				"3" };
		this.newOrders(attrValue, stmt);
	}

	public void newOrders(String[] attrValue, Statement stmt) throws Exception {

		Common com = new Common();
		com.newTuple(attrValue, tableName, attrName, stmt);

		Book books = new Book();
		String[] sigmaAttr = { "ISBN" };
		String[] sigmaValue = { attrValue[1] };
		ResultSet resultTable = books.showBook(sigmaAttr, sigmaValue, stmt);

		int copies = 0;
		if (resultTable.next())
			copies = Integer.valueOf(resultTable.getInt("copies"));

		String[] tempAttr = { "copies" };
		String[] tempValue = { String.valueOf(copies
				- Integer.valueOf(attrValue[4])) };
		books.updateBook("ISBN", attrValue[1], tempAttr, tempValue, stmt);

	}

	public ResultSet showOrders(String[] sigmaAttr, String[] sigmaValue,
			Statement stmt) throws Exception {

		Common com = new Common();
		ResultSet resultTable = com.showTable(sigmaAttr, sigmaValue, tableName,
				stmt);
		return resultTable;

	}

	public int countOrders(Statement stmt) throws Exception {

		Common com = new Common();
		int count = com.countTuple(tableName, stmt);
		return count;
	}
}
