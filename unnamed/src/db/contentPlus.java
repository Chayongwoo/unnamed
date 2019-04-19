package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class contentPlus {
	public static void main(String[] args) {

		for (int i = 0; i < 1020; i++) {
			String title = "title" + i;
			String content = "content" + i;
			String id = "corsair456";
			try {
				DBManager db = DBManager.getInstance();
				Connection con = db.open();
				
				
				
				String sql = "insert into article values (null,?,?,0,?)";

				PreparedStatement stmt = con.prepareStatement(sql);
				stmt.setString(1, title);
				stmt.setString(2, content);
				stmt.setString(3, id);
				stmt.executeUpdate();

			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
