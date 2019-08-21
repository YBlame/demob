package demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import demo.tool.LinkSql;

public class DjMenu {
	private static PreparedStatement ps = null;
	private static ResultSet rs = null;
	private static Connection conn = null;
	
	public static String[] returnMenu(HttpSession session,String roleGuid,String zhxxGuid ) throws Exception{
		conn =LinkSql.getConn();
		String sqlFindRoleMenu = "select menuGuids from rolemenu where roleGuid = ? and zhxxGuid = ?";
		ps = conn.prepareStatement(sqlFindRoleMenu);
		String menuGuids=null;
		ps.setString(1, roleGuid);
		ps.setString(2, zhxxGuid);
		rs = ps.executeQuery();
		while (rs.next()) {
			menuGuids = rs.getString("menuGuids");
		}
		String[] menuGuid = null;
		if (menuGuids != null) {
			menuGuid = menuGuids.split(",");
		}
		return menuGuid;
	}
}
