package demo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import demo.tool.LinkSql;
import net.sf.json.JSONObject;

public class demo {
	static List<Object> listTree = new ArrayList<>();

	public static void main(String[] args) throws Exception {
		List<Object> treeList = findTypeTree("f9b0690ccd414ef0b6b67b61b411aa9b", 0);
		System.out.println(treeList);
		for (Object object : treeList) {
			System.out.println(object);
		}
	}

	private static List<Object> findTypeTree(String string, int i) throws Exception {
		PreparedStatement psta = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM menu where zhxx_menu=?";
		conn = LinkSql.getConn();
		psta = conn.prepareStatement(sql);
		psta.setString(1, string);
		rs = psta.executeQuery();
		while (rs.next()) {
			String name = rs.getString("name");
			int parentMenu = rs.getInt("parentMenu");
			Integer id = rs.getInt("id");
			String guid = rs.getString("guid");
			String zhxx_menu = rs.getString("zhxx_menu");
			if (parentMenu == 0) {// 判断是否是一级菜单
				Map<String, Object> treeObject = new HashMap<String, Object>();
				treeObject.put("id", id);
				treeObject.put("guid", guid);
				treeObject.put("name", name);// tree的节点名称
				treeObject.put("zhxx_menu", zhxx_menu);
				treeObject.put("children", getChildren(id));// 孩子节点，递归遍历
				listTree.add(treeObject);
			}
		}
		conn.close();
		return listTree;
	}

	// 获取树形图子类
	public static List<Object> getChildren(Integer parentId) throws Exception {
		Connection conn = LinkSql.getConn();
		PreparedStatement psta = null;
		List<Object> listChildren = new ArrayList<>();
		ResultSet rs = null;
		String sql = "SELECT * FROM menu where parentMenu=?";
		psta = conn.prepareStatement(sql);
		psta.setInt(1, parentId);
		rs = psta.executeQuery();
		while (rs.next()) {
			String name = rs.getString("name");
			Integer id = rs.getInt("id");
			String guid = rs.getString("guid");
			String zhxx_menu = rs.getString("zhxx_menu");
			Map<String, Object> treeObject = new HashMap<String, Object>();
			treeObject.put("id", id);
			treeObject.put("guid", guid);
			treeObject.put("name", name);// tree的节点名称
			treeObject.put("zhxx_menu", zhxx_menu);
			treeObject.put("children", getChildren(id));// 孩子节点，递归遍历
			listTree.add(treeObject);
		}
		return listChildren;
	}

}
