package demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import demo.tool.LinkSql;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class GzryMenu {
	private static PreparedStatement ps = null;
	private static ResultSet rs = null;
	private static Connection conn = null;

	// 获取工作人员菜单
	public static JSONArray returnMenu(String menuGuids) throws Exception {
		List<Object> treeList = new ArrayList<Object>();
		List<Object> children = new ArrayList<Object>();
		conn = LinkSql.getConn();
		String sql = "select * from gzrycd order by id desc";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		String[] result = null;
		int len = 0;
		if (menuGuids != null) {
			result = menuGuids.split(",");
			len = result.length;
		} else {
			len = 0;
		}
		while (rs.next()) {
			String name = rs.getString("NAME");
			String guid = rs.getString("guid");
			int id = rs.getInt("id");
			JSONObject treeObject = new JSONObject();
			for (int a = 0; a < len; a++) {
				if (guid.equals(result[a])) {
					treeObject.put("checked", true);
				}
			}
			treeObject.put("spread", true);// 是否直接展开
			treeObject.put("id", id);
			treeObject.put("guid", guid);
			treeObject.put("title", name);// tree的节点名称
			treeObject.put("children", children);// 孩子节点，递归遍历
			treeList.add(treeObject);
		}
		JSONArray json = JSONArray.fromObject(treeList);
		System.out.println(json);
		return json;

	}
	
	
	
	public static  String[] findSelectMenu(HttpSession session,String roleGuid,String zhxxGuid) throws Exception{
		conn = LinkSql.getConn();
		String roleId = session.getAttribute("roleid").toString();
		String sqlFindRole = "select guid from role where id = ?";
		ps = conn.prepareStatement(sqlFindRole);
		ps.setString(1, roleId);
		rs = ps.executeQuery();
		String menuGuids = null;
		while (rs.next()) {
			roleGuid = rs.getString("guid");
		}
		String sqlFindRoleMenu = "select menuGuids from rolemenu where roleGuid = ? and zhxxGuid = ?";
		ps = conn.prepareStatement(sqlFindRoleMenu);
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
