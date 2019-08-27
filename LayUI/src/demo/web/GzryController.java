package demo.web;

import demo.dao.Bmodel;
import demo.dao.GzryMenu;
import demo.tool.LinkSql;
import demo.tool.PageUtils;
import demo.tool.PublicMethod;
import demo.tool.UUIDUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

/**
 * 工作人员Controller
 * 
 * @author BLAME
 *
 */
@Controller
@RequestMapping(value = "gzry")
public class GzryController {
	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private List<Map<String, Object>> list;

	@RequestMapping(value = "findDoc")
	@ResponseBody
	/**
	 * 获取表头
	 * 
	 * @param page
	 * @param request
	 * @param res
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	public Object findDoc(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid, Integer num,
			Integer limit) throws Exception {
		try {
			HttpSession session = request.getSession();
			final String user = (String) session.getAttribute("user");
			final String role = (String) session.getAttribute("role");
			String zhxxDj = (String) session.getAttribute("zhxxDj");
			String bmDj = (String) session.getAttribute("bmDj");
			String typeDj = (String) session.getAttribute("typeDj");
			list = new ArrayList<Map<String, Object>>();
			String tn = null;
			ResultSetMetaData md = null;
			int columnCount = 0;
			String destn = null;
			String sqlRale = null;
			tn = bmDj + "_" + zhxxDj;
			destn = bmDj + "_des_" + zhxxDj;
			String sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
			sqlDes = sqlDes + " and isshow = 1  ";
			if (user != null && role != null) {
				sqlRale = "";
				sqlDes = sqlDes + sqlRale;
			}
			sqlDes = sqlDes + " order by lisnum asc,id asc ";
			conn = LinkSql.getConn();
			ps = LinkSql.Execute(conn, sqlDes, role, destn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			ps.close();
			rs.close();
			conn.close();
		}
		return list;

	}

	/**
	 * 查询左侧菜单栏渲染表格
	 * 
	 * @param request
	 * @param res
	 * @param guid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findParentMenu")
	@ResponseBody
	public List<Map<String, Object>> findMenu(HttpServletRequest request, HttpServletResponse res, String zhxxGuid)
			throws Exception {
		conn = LinkSql.getConn();
		HttpSession session = request.getSession();
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		String roleGuid = null;// 得到当前角色GUID;
		String menuGuids = null; // 当前角色下的菜单列表
		String roleId = session.getAttribute("roleid").toString();
		String[] menuGuid = GzryMenu.findSelectMenu(session, roleId, zhxxGuid);
		String tn = Bmodel.findBmByGuId("76a4ade487a246978a26ebead1aa05b5");
		String sql = "select guid,id,name,bmc,bm from " + tn + " ";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			for (int i = 0; i < menuGuid.length; i++) {
				if (!rs.getObject("guid").toString().equals(menuGuid[i])) {
				} else {
					Map<String, Object> rowData = new HashMap<String, Object>();
					for (int j = 1; j <= columnCount; j++) {
						rowData.put(md.getColumnName(j), rs.getObject(j));
					}
					desList.add(rowData);
				}
			}
		}

		return desList;
	}

	@RequestMapping(value = "findSonMenu")
	@ResponseBody
	public List<Map<String, Object>> findSonMenu(HttpServletRequest request, HttpServletResponse res,
			Integer parentMenu, String zhxxGuid) throws Exception {
		HttpSession session = request.getSession();
		String roleId = session.getAttribute("roleid").toString();
		conn = LinkSql.getConn();
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		String tn = Bmodel.findBmByGuId("73c2efa3c34f4904ae0eee4ab31dfa79");
		String sql = "select id,guid,name,bmc,bm from " + tn + " where  parentMenu = ?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, parentMenu);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();

		String[] menuGuid = GzryMenu.findSelectMenu(session, roleId, zhxxGuid);
		while (rs.next()) {
			for (int i = 0; i < menuGuid.length; i++) {
				if (!rs.getObject("guid").toString().equals(menuGuid[i])) {
				} else {
					Map<String, Object> rowData = new HashMap<String, Object>();
					for (int j = 1; j <= columnCount; j++) {
						rowData.put(md.getColumnName(j), rs.getObject(j));
					}
					desList.add(rowData);
				}
			}

		}
		return desList;
	}

	/**
	 * 查询条件
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "queryRybdbCondition")
	@ResponseBody
	public Object queryRybdbCondition(HttpServletRequest request, HttpServletResponse res, String guid, String zhxxDj,
			String bmDj, String bmcDj, String typeDj) throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		session.setAttribute("zhxxDj", zhxxDj);
		session.setAttribute("bmDj", bmDj);
		session.setAttribute("bmcDj", bmcDj);
		session.setAttribute("typeDj", typeDj);
		try {
			/*
			 * 定义
			 */
			list = new ArrayList<Map<String, Object>>();// 实例化
			String tn = null;// 数据表表名，根据guid获取
			String desTn = null;// 描述表表名
			String sqlWhere = null;// sql语句条件
			ResultSetMetaData md = null;
			int columnCount = 0;
			// 根据guid获取数据表表名，根据规则得到描述表表名
			if (typeDj.equals("true")) {
				tn = bmDj;
				desTn = bmDj + "_des";
			} else {
				tn = Bmodel.findBmByGuId(guid);// 描述表
				desTn = tn + "_des";
			}

			// 连接数据库
			conn = LinkSql.getConn();// 创建对象
			sqlWhere = " and  isselect >=1 ORDER BY isselect asc";
			String sqlFind = " SELECT id,zdm,zdmc,initval,types,jsdm,isedit,api,formtypes,guid,isselect,width FROM  "
					+ desTn + " WHERE 1=1" + sqlWhere;
			ps = LinkSql.Execute(conn, sqlFind, role, desTn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return list;

	}
	
	///货车信息
	@RequestMapping(value = "queryHcxxCondition")
	@ResponseBody
	public Object queryHcxxCondition(HttpServletRequest request, HttpServletResponse res, String guid, String zhxxDj,
			String bmDj, String bmcDj, String typeDj) throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		session.setAttribute("zhxxDj", zhxxDj);
		session.setAttribute("bmDj", bmDj);
		session.setAttribute("bmcDj", bmcDj);
		session.setAttribute("typeDj", typeDj);
		try {
			/*
			 * 定义
			 */
			list = new ArrayList<Map<String, Object>>();// 实例化
			String tn = null;// 数据表表名，根据guid获取
			String desTn = null;// 描述表表名
			String sqlWhere = null;// sql语句条件
			ResultSetMetaData md = null;
			int columnCount = 0;
			// 根据guid获取数据表表名，根据规则得到描述表表名
			if (typeDj.equals("true")) {
				tn = bmDj+"_"+zhxxDj;
				desTn = bmDj + "_des_"+zhxxDj;
			} else {
				tn = Bmodel.findBmByGuId(guid);// 描述表
				desTn = tn + "_des";
			}

			// 连接数据库
			conn = LinkSql.getConn();// 创建对象
			sqlWhere = " and  isselect >=1 ORDER BY isselect asc";
			String sqlFind = " SELECT id,zdm,zdmc,initval,types,jsdm,isedit,api,formtypes,guid,isselect,width FROM  "
					+ desTn + " WHERE 1=1" + sqlWhere;
			ps = LinkSql.Execute(conn, sqlFind, role, desTn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return list;

	}

	/**
	 * 获取表头
	 * 
	 * @param page
	 * @param request
	 * @param res
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findRybdb")
	@ResponseBody
	public Object findRybdb(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			Integer num, Integer limit) throws Exception {
		try {
			HttpSession session = request.getSession();
			final String user = (String) session.getAttribute("user");
			final String role = (String) session.getAttribute("role");
			String zhxxDj = (String) session.getAttribute("zhxxDj");
			String bmDj = (String) session.getAttribute("bmDj");
			String typeDj = (String) session.getAttribute("typeDj");
			list = new ArrayList<Map<String, Object>>();
			String tn = null;
			ResultSetMetaData md = null;
			int columnCount = 0;
			String destn = null;
			String sqlRale = null;
			tn = bmDj;
			destn = bmDj + "_des";
			String sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
			sqlDes = sqlDes + " and isshow = 1  ";
			if (user != null && role != null) {
				sqlRale = "";
				sqlDes = sqlDes + sqlRale;
			}
			sqlDes = sqlDes + " order by lisnum asc,id asc ";
			conn = LinkSql.getConn();
			ps = LinkSql.Execute(conn, sqlDes, role, destn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			ps.close();
			rs.close();
			conn.close();
		}
		return list;

	}
	
	
	@RequestMapping(value = "findHcxx")
	@ResponseBody
	public Object findHcxx(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			Integer num, Integer limit) throws Exception {
		try {
			HttpSession session = request.getSession();
			final String user = (String) session.getAttribute("user");
			final String role = (String) session.getAttribute("role");
			String zhxxDj = (String) session.getAttribute("zhxxDj");
			String bmDj = (String) session.getAttribute("bmDj");
			String typeDj = (String) session.getAttribute("typeDj");
			list = new ArrayList<Map<String, Object>>();
			String tn = null;
			ResultSetMetaData md = null;
			int columnCount = 0;
			String destn = null;
			String sqlRale = null;
			tn = bmDj+"_"+zhxxDj;
			destn = bmDj + "_des_"+zhxxDj;
			String sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
			sqlDes = sqlDes + " and iskeep = 1  ";
			if (user != null && role != null) {
				sqlRale = "";
				sqlDes = sqlDes + sqlRale;
			}
			sqlDes = sqlDes + " order by lisnum asc,id asc ";
			conn = LinkSql.getConn();
			ps = LinkSql.Execute(conn, sqlDes, role, destn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			ps.close();
			rs.close();
			conn.close();
		}
		return list;

	}
	
	
	@RequestMapping(value = "findZzpz")
	@ResponseBody
	public Object findZzpz(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			Integer num, Integer limit) throws Exception {
		try {
			HttpSession session = request.getSession();
			final String user = (String) session.getAttribute("user");
			final String role = (String) session.getAttribute("role");
			String zhxxDj = (String) session.getAttribute("zhxxDj");
			String bmDj = (String) session.getAttribute("bmDj");
			String typeDj = (String) session.getAttribute("typeDj");
			list = new ArrayList<Map<String, Object>>();
			String tn = null;
			ResultSetMetaData md = null;
			int columnCount = 0;
			String destn = null;
			String sqlRale = null;
			tn = bmDj+"_"+zhxxDj;
			destn = bmDj + "_des_"+zhxxDj;
			String sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
			sqlDes = sqlDes + " and iskeep >= 1  ";
			if (user != null && role != null) {
				sqlRale = "";
				sqlDes = sqlDes + sqlRale;
			}
			sqlDes = sqlDes + " order by iskeep asc,id asc ";
			conn = LinkSql.getConn();
			ps = LinkSql.Execute(conn, sqlDes, role, destn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			ps.close();
			rs.close();
			conn.close();
		}
		return list;

	}

	/**
	 * 渲染数据表格
	 * 
	 * @param page
	 * @param request
	 * @param res
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findDocTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findDocTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = bmDj + "_" + zhxxDj;
			destn = bmDj + "_des_" + zhxxDj;
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn + " order by lisnum asc ";
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							sqlWhere += " and " + name + " like '%" + value + "%' ";
						}
					}
				}
			}
			String sqlData = null;
			// 用于权限设置当不是开发人员时，无法对开发和主管理员的权限进行设置。
			if (guid.equals("acc0357dd46e42129f534f4820781a5a")) {
				if (!role.equals("开发人员")) {
					sqlWhere += " and guid != 'a666df5383f345868cc5b46a257da351' AND guid !='97e115aba8124896833070694701d96b'";
				}
			}
			String sqlWhereZc = "";
			if (roleid.equals("4") || roleid.equals("5")) {
				if (tn.equals("user")) {// 该操作对应主场管理员,工作人员中的人员管理，因人员管理只需要审核搭建商即可。
					if (guid.equals("00c99009ec2d4cb883acc9ae24f73b6e")
							|| guid.equals("b58f1fdfb3cf451fabd704a6c8f8eadf")) {
						sqlWhereZc += " and roleid=1";
					} else {// 该操作对应权限表中显示除开发人员外的其他人员的权限管理。
						sqlWhereZc += " and roleid!=3";
					}
				}
			}
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc
					+ " and ZT !='未提交' order by id desc ";
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();

			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				List listSh = new ArrayList();

				Integer index = 0;
				for (int j = 1; j <= columnCount; j++) {
					if (md.getColumnName(j).contains("_ZT")) {
						listSh.add(index, md.getColumnName(j));
						index++;
					}
				}

				// 获取guid
				String guids = "";
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) != null) {
						if (md.getColumnName(i).equals("guid")) {
							guids = rs.getObject(i).toString();
						}
					}
				}
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						String flag = "false";
						String ztStr = "";
						String zt = "";
						for (int k = 0; k < listSh.size(); k++) {
							ztStr = listSh.get(k).toString();
							zt = rs.getObject(listSh.get(k).toString()).toString();
							if (md.getColumnName(i).equals(ztStr.substring(0, ztStr.length() - 3))) {
								flag = "true";
								break;
							}
						}

						if (flag.equals("true")) {
							System.out.println(rs.getObject(i).toString());
							String mc = md.getColumnName(i);
							System.out.println(mc);
							// statics/imgs/1565593168033.jpg
							String wtg = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakan('" + mc
									+ "','" + guids + "','" + mc + "','" + mc
									+ "')\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakan('" + mc
									+ "','" + guids + "','" + mc + "','" + mc
									+ "')\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg = "<div><div id=\"sh\" style='text-align: center;'><a   onclick=\"chakan('" + mc
									+ "','" + guids + "','" + mc + "','" + mc
									+ "')\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";

							if (zt.equals("未通过")) {// 未通过

								rowData.put(ztStr.substring(0, ztStr.length() - 3), wtg);

							} else if (zt.equals("未审核")) {// 未审核

								rowData.put(ztStr.substring(0, ztStr.length() - 3), wsh);

							} else if (zt.equals("通过")) {// 通过

								rowData.put(ztStr.substring(0, ztStr.length() - 3), tg);
							}

						} else {
							if(md.getColumnName(i).equals("FYXXZT")){
								String wtg="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
								String wsh="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
								String tg="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
								String wtj="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/wtj.png' style='margin-top:4px;'></a></div><div>";
								if(rs.getObject(i).equals("未通过")){//未通过
								
									rowData.put(md.getColumnName(i), wtg);
																	
								}else if(rs.getObject(i).equals("已提交")){//未审核
									
									rowData.put(md.getColumnName(i), wsh);
									
								}else if(rs.getObject(i).equals("通过")){//通过
									
									rowData.put(md.getColumnName(i), tg);									
								}else if(rs.getObject(i).equals("未提交")){
									rowData.put(md.getColumnName(i), wtj);
								}
															
							}else if(md.getColumnName(i).equals("FKTZDZT")){								
								String wtj="<div><div style='text-align: center;'><img src='statics/icon/ffwtj.jpg' style='margin-top:4px;'></div><div>";
								String yfs="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/ffyfs.jpg' style='margin-top:4px;'></a></div><div>";
								String wfs="<div><div style='text-align: center;'><img src='statics/icon/ffwfs' style='margin-top:4px;'></div><div>";
								if(rs.getObject(i).equals("未提交")){//未通过								
									rowData.put(md.getColumnName(i), wtj);																	
								}else if(rs.getObject(i).equals("已发送")){//未审核									
									rowData.put(md.getColumnName(i), yfs);									
								}else if(rs.getObject(i).equals("未发送")){//通过									
									rowData.put(md.getColumnName(i), wfs);									
								}								
							}else{
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
							}
						}
					}
				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}

	/**
	 * 渲染数据表格
	 * 
	 * @param page
	 * @param request
	 * @param res
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findRybdTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findRybdTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String sj = (String) session.getAttribute("SJ");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = "RYBDB";
			destn = "RYBDB" + "_des";
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							sqlWhere += " and " + name + " like '%" + value + "%' ";
						}
					}
				}
			}
			String sqlData = null;
			String sqlWhereZc = " and ZHBH = '" + zhxxDj + "'  ";
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc;
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						String mc = md.getColumnName(i);
						// guids=rs.getObject(i).toString();
						System.out.println(md.getColumnName(i));
						String dataGuid = (String) rs.getObject("guid");
						String dwbh = (String) rs.getObject("DWBH");
						if (md.getColumnName(i).equals("BDZT") || md.getColumnName(i).equals("RYZT")) {
							String wtg = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbh
									+ "')\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbh
									+ "')\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbh
									+ "')\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
							String wtj = "<div><div id=\"sh\" style='text-align: center;'><a class='layui-table-link'><img src='statics/icon/wtj.png' style='margin-top:4px;'></a></div><div>";
							if (rs.getObject(i).toString().equals("未提交")) {
								rowData.put(md.getColumnName(i), wtj);

							} else if (rs.getObject(i).toString().equals("已提交")) {// 未审核
								rowData.put(md.getColumnName(i), wsh);

							} else if (rs.getObject(i).toString().equals("未通过")) {// 未通过
								rowData.put(md.getColumnName(i), wtg);

							} else if (rs.getObject(i).toString().equals("已通过")) {// 通过
								rowData.put(md.getColumnName(i), tg);
							}
						} else {
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
						}

						// rowData.put(md.getColumnName(i),
						// rs.getObject(i).toString());
					}

				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}
	
	
	@RequestMapping(value = "findkptyjTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findkptyjTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String sj = (String) session.getAttribute("SJ");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = "KPTYJ";
			destn = "KPTYJ" + "_des";
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							sqlWhere += " and " + name + " like '%" + value + "%' ";
						}
					}
				}
			}
			String sqlData = null;
			String sqlWhereZc = " and ZHBH = '" + zhxxDj + "'  ";
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc;
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						String mc = md.getColumnName(i);
						// guids=rs.getObject(i).toString();
						System.out.println(md.getColumnName(i));
						String dataGuid = (String) rs.getObject("guid");
						if (md.getColumnName(i).equals("HKZT") ) { // onclick=\"chakan('"+mc+"','"+guids+"','"+mc+"','"+mc+"')\"
							String wtg = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
							String wtj = "<div><div id=\"sh\" style='text-align: center;'><a class='layui-table-link'><img src='statics/icon/wtj.png' style='margin-top:4px;'></a></div><div>";
							if (rs.getObject(i).toString().equals("未提交")) {
								rowData.put(md.getColumnName(i), wtj);

							} else if (rs.getObject(i).toString().equals("已提交")) {// 未审核
								rowData.put(md.getColumnName(i), wsh);

							} else if (rs.getObject(i).toString().equals("未通过")) {// 未通过
								rowData.put(md.getColumnName(i), wtg);

							} else if (rs.getObject(i).toString().equals("已通过")) {// 通过
								rowData.put(md.getColumnName(i), tg);
							}
						} else if(md.getColumnName(i).equals("KPZT")){
							String wtg = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakankp('"
									+ zhxxDj + "','" + dataGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakankp('"
									+ zhxxDj + "','" + dataGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakankp('"
									+ zhxxDj + "','" + dataGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
							String wtj = "<div><div id=\"sh\" style='text-align: center;'><a class='layui-table-link'><img src='statics/icon/wtj.png' style='margin-top:4px;'></a></div><div>";
							if (rs.getObject(i).toString().equals("未提交")) {
								rowData.put(md.getColumnName(i), wtj);

							} else if (rs.getObject(i).toString().equals("已提交")) {// 未审核
								rowData.put(md.getColumnName(i), wsh);

							} else if (rs.getObject(i).toString().equals("未通过")) {// 未通过
								rowData.put(md.getColumnName(i), wtg);

							} else if (rs.getObject(i).toString().equals("已通过")) {// 通过
								rowData.put(md.getColumnName(i), tg);
							}
							
						} else{
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
						}

						// rowData.put(md.getColumnName(i),
						// rs.getObject(i).toString());
					}

				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}
	
	@RequestMapping(value = "findHcxxTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findHcxxTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String sj = (String) session.getAttribute("SJ");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = "hcxx_"+zhxxDj;
			destn = "hcxx" + "_des_"+zhxxDj;
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							sqlWhere += " and " + name + " like '%" + value + "%' ";
						}
					}
				}
			}
			String sqlData = null;
			String sqlWhereZc = " and ZHBH = '" + zhxxDj + "'  ";
			sqlData = "select" + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc +" group BY dwbh";
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						String mc = md.getColumnName(i);
						// guids=rs.getObject(i).toString();
						System.out.println(md.getColumnName(i));
						String dataGuid = (String) rs.getObject("guid");
						String dwbhGuid = (String) rs.getObject("dwbh");
						if (md.getColumnName(i).equals("ZT")) { // onclick=\"chakan('"+mc+"','"+guids+"','"+mc+"','"+mc+"')\"
							String wtg = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbhGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbhGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbhGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
							String wtj = "<div><div id=\"sh\" style='text-align: center;'><a class='layui-table-link'><img src='statics/icon/wtj.png' style='margin-top:4px;'></a></div><div>";
							if (rs.getObject(i).toString().equals("未提交")) {
								rowData.put(md.getColumnName(i), wtj);

							} else if (rs.getObject(i).toString().equals("已提交")) {// 未审核
								rowData.put(md.getColumnName(i), wsh);

							} else if (rs.getObject(i).toString().equals("未通过")) {// 未通过
								rowData.put(md.getColumnName(i), wtg);

							} else if (rs.getObject(i).toString().equals("已通过")) {// 通过
								rowData.put(md.getColumnName(i), tg);
							}
						} else {
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
						}

						// rowData.put(md.getColumnName(i),
						// rs.getObject(i).toString());
					}

				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}
	
	
	@RequestMapping(value = "findZzpzTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findZzpzTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String sj = (String) session.getAttribute("SJ");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = "zzpz_"+zhxxDj;
			destn = "zzpz" + "_des_"+zhxxDj;
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							sqlWhere += " and " + name + " like '%" + value + "%' ";
						}
					}
				}
			}
			String sqlData = null;
			String sqlWhereZc = " and ZHBH = '" + zhxxDj + "'  ";
			sqlData = "select" + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc +" group BY dwbh";
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						String mc = md.getColumnName(i);
						// guids=rs.getObject(i).toString();
						System.out.println(md.getColumnName(i));
						String dataGuid = (String) rs.getObject("guid");
						String dwbhGuid = (String) rs.getObject("dwbh");
						if (md.getColumnName(i).equals("ZT")) { // onclick=\"chakan('"+mc+"','"+guids+"','"+mc+"','"+mc+"')\"
							String wtg = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbhGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh = "<div><div id=\"sh\" style='text-align: center;'><a onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbhGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg = "<div><div id=\"sh\" style='text-align: center;'><a  onclick=\"chakan('"
									+ zhxxDj + "','" + dataGuid+ "','" + dwbhGuid
									+ "')\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
							String wtj = "<div><div id=\"sh\" style='text-align: center;'><a class='layui-table-link'><img src='statics/icon/wtj.png' style='margin-top:4px;'></a></div><div>";
							if (rs.getObject(i).toString().equals("未提交")) {
								rowData.put(md.getColumnName(i), wtj);

							} else if (rs.getObject(i).toString().equals("已提交")) {// 未审核
								rowData.put(md.getColumnName(i), wsh);

							} else if (rs.getObject(i).toString().equals("未通过")) {// 未通过
								rowData.put(md.getColumnName(i), wtg);

							} else if (rs.getObject(i).toString().equals("已通过")) {// 通过
								rowData.put(md.getColumnName(i), tg);
							}
						} else {
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
						}

						// rowData.put(md.getColumnName(i),
						// rs.getObject(i).toString());
					}

				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}

	/**
	 * 渲染数据表格
	 * 
	 * @param page
	 * @param request
	 * @param res
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "userSh", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object userSh(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = bmDj + "_" + zhxxDj;
			destn = bmDj + "_des_" + zhxxDj;
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							if (name.equals("ZT")) {
								sqlWhere += " and " + name + " like '" + value + "' ";
							} else {
								sqlWhere += " and " + name + " like '%" + value + "%' ";
							}

						}
					}
				}
			}
			String sqlData = null;
			// 用于权限设置当不是开发人员时，无法对开发和主管理员的权限进行设置。
			if (guid.equals("acc0357dd46e42129f534f4820781a5a")) {
				if (!role.equals("开发人员")) {
					sqlWhere += " and guid != 'a666df5383f345868cc5b46a257da351' AND guid !='97e115aba8124896833070694701d96b'";
				}
			}
			String sqlWhereZc = "";
			if (roleid.equals("4") || roleid.equals("5")) {
				if (tn.equals("user")) {// 该操作对应主场管理员,工作人员中的人员管理，因人员管理只需要审核搭建商即可。
					if (guid.equals("00c99009ec2d4cb883acc9ae24f73b6e")
							|| guid.equals("b58f1fdfb3cf451fabd704a6c8f8eadf")) {
						sqlWhereZc += " and roleid=1  order by id desc";
					} else {// 该操作对应权限表中显示除开发人员外的其他人员的权限管理。
						sqlWhereZc += " and roleid!=3 order by id desc";
					}
				}
			}
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc;
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String wtg = "<div><div id=\"sh\" style='text-align: center;'><a  lay-event=\"audit\"  class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
			String wsh = "<div><div id=\"sh\" style='text-align: center;'><a  lay-event=\"audit\"  class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
			String tg = "<div><div id=\"sh\" style='text-align: center;'><a   lay-event=\"audit\"  class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						if (md.getColumnName(i).equals("ZT")) {
							switch (rs.getObject(i).toString()) {
							case "未审核":
								rowData.put(md.getColumnName(i), wsh);
								break;
							case "未通过":
								rowData.put(md.getColumnName(i), wtg);
								break;
							case "通过":
								rowData.put(md.getColumnName(i), tg);
								break;
							}
						} else {
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
						}
					}

				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}

	/**
	 * 查询条件图片路径
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "GetimgByGuid")
	@ResponseBody
	public Object GetimgByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid, String shguid,
			String shmc) throws Exception {
		String tp = "";
		String mc = "";
		JSONObject json = new JSONObject();
		try {
			/*
			 * 定义
			 */
			list = new ArrayList<Map<String, Object>>();// 实例化
			String tn = "bgxx_" + zhxxguid;// 数据表表名，根据guid获取
			String desTn = "bgxx_des_" + zhxxguid;// 描述表表名
			ResultSetMetaData md = null;
			int columnCount = 0;

			// 连接数据库
			if (shmc.equals("ZWTZ")) {
				conn = LinkSql.getConn();// 创建对象
				String sqlFind = " SELECT ZTJG,ZWTZ,ZWJGT,SJY,BGDH,CTSJS,GCSSJH,GCSZZZS  FROM  " + tn + " WHERE guid='"
						+ shguid + "'";
				ps = LinkSql.Execute(conn, sqlFind, "5", tn);
				rs = ps.executeQuery();
				md = rs.getMetaData(); // 获得结果集结构信息,元数据
				columnCount = md.getColumnCount(); // 获得列数
				while (rs.next()) {
					tp = rs.getObject(shmc).toString();
					String ZTJG = rs.getObject("ZTJG").toString();
					String ZWJGT = rs.getObject("ZWJGT").toString();
					String SJY = rs.getObject("SJY").toString();
					String BGDH = rs.getObject("BGDH").toString();
					String CTSJS = rs.getObject("CTSJS").toString();
					String GCSSJH = rs.getObject("GCSSJH").toString();
					String GCSZZZS = rs.getObject("GCSZZZS").toString();
					json.put("tp", tp);
					json.put("ZTJG", ZTJG);
					json.put("ZWJGT", ZWJGT);
					json.put("SJY", SJY);
					json.put("BGDH", BGDH);
					json.put("CTSJS", CTSJS);
					json.put("GCSSJH", GCSSJH);
					json.put("GCSZZZS", GCSZZZS);
					json.put("lx", true);
				}

			} else {
				conn = LinkSql.getConn();// 创建对象
				String sqlFind = " SELECT " + shmc + " FROM  " + tn + " WHERE guid='" + shguid + "'";
				ps = LinkSql.Execute(conn, sqlFind, "5", tn);
				rs = ps.executeQuery();
				md = rs.getMetaData(); // 获得结果集结构信息,元数据
				columnCount = md.getColumnCount(); // 获得列数
				while (rs.next()) {
					tp = rs.getObject(shmc).toString();
					json.put("tp", tp);
					json.put("lx", false);
				}

			}

			String sqlFindmc = " SELECT zdmc FROM  " + desTn + " WHERE zdm='" + shmc + "'";
			ps = LinkSql.Execute(conn, sqlFindmc, "5", tn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				mc = rs.getObject("zdmc").toString();
				json.put("mc", mc);
			}

		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return json;

	}

	@RequestMapping("updStateByGuid")
	@ResponseBody
	public int updStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid, String shguid,
			String shmc, String audit, String suggest) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;
			try {
				if (audit.equals("pass")) {
					String tn = "bgxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "bgxx_des_" + zhxxguid;// 描述表表名
					shmc = shmc + "_ZT";
					String sqlAudit = "UPDATE " + tn + " SET " + shmc + "='通过'  WHERE GUID=?";

					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudit);
					ps.setString(1, shguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}

					// 查询是不是全部都是通过 先查描述表所有带状态的字段
					String flagzt = "false";
					String flagwsh = "false";
					String flagfy="false";
					int columnCount = 0;
					ResultSetMetaData md = null;
					String sql = "select * from  " + tn + " WHERE GUID='" + shguid + "'";
					conn = LinkSql.getConn();// 创建对象
					ps = LinkSql.Execute(conn, sql, "5", tn);
					rs = ps.executeQuery();
					md = rs.getMetaData(); // 获得结果集结构信息,元数据
					columnCount = md.getColumnCount(); // 获得列数
					while (rs.next()) {
						Map<String, Object> rowData = new HashMap<String, Object>();
						for (int i = 1; i <= columnCount; i++) {
							rowData.put(md.getColumnName(i), rs.getObject(i));

							if (md.getColumnName(i).contains("_ZT") && rs.getObject(i) == "未审核") {
								flagwsh = "trun";

							}

							if (md.getColumnName(i).contains("_ZT") && rs.getObject(i) == "未通过") {
								flagzt = "trun";
								break;
							}
							
							//费用状态
							if (md.getColumnName(i).equals("FYXXZT") && rs.getObject(i) == "已通过") {
								flagfy = "trun";
								break;
							}
							
						}
					}

					if (flagzt.equals("true")) {// 不通过
						String sqlAudits = "UPDATE " + tn + " SET ZT='拒绝'  WHERE GUID=?";

						conn.setAutoCommit(false);
						ps = conn.prepareStatement(sqlAudits);
						ps.setString(1, shguid);
						try {
							flag = ps.executeUpdate();
							conn.commit();
						} catch (Exception e) {
							// TODO 自动生成的 catch 块
							conn.rollback();
						}

					} else {
						if (flagwsh.equals("true")) {// 未审核
							String sqlAudits = "UPDATE " + tn + " SET ZT='待审核'  WHERE GUID=?";

							conn.setAutoCommit(false);
							ps = conn.prepareStatement(sqlAudits);
							ps.setString(1, shguid);
							try {
								flag = ps.executeUpdate();
								conn.commit();
							} catch (Exception e) {
								// TODO 自动生成的 catch 块
								conn.rollback();
							}

						} else {
							String sqlAudits = "UPDATE " + tn + " SET ZT='通过'  WHERE GUID=?";

							conn.setAutoCommit(false);
							ps = conn.prepareStatement(sqlAudits);
							ps.setString(1, shguid);
							try {
								flag = ps.executeUpdate();
								conn.commit();
							} catch (Exception e) {
								// TODO 自动生成的 catch 块
								conn.rollback();
							}
							
							
							if(flagfy.equals("true")){
								String sqlfy = "UPDATE " + tn + " SET FKTZDZT='未发送'  WHERE GUID=?";

								conn.setAutoCommit(false);
								ps = conn.prepareStatement(sqlfy);
								ps.setString(1, shguid);
								try {
									flag = ps.executeUpdate();
									conn.commit();
								} catch (Exception e) {
									// TODO 自动生成的 catch 块
									conn.rollback();
								}								
							}
						}
					}

				} else if (audit.equals("NoPass")) {
					// 修改报馆信息状态
					String tn = "bgxx_" + zhxxguid;
					String desTn = "bgxx_des_" + zhxxguid;
					String shmczt = shmc + "_ZT";
					String sqlAudit = "UPDATE " + tn + " SET " + shmczt + "='未通过'  WHERE GUID=?";

					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudit);
					ps.setString(1, shguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}

					// 只要有一个状态是不通过,就把大的状态修改成拒绝
					String sqlAudits = "UPDATE " + tn + " SET ZT='拒绝'  WHERE GUID=?";

					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudits);
					ps.setString(1, shguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sqlFktzdzt = "UPDATE " + tn + " SET FKTZDZT='未提交'  WHERE GUID=?";
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlFktzdzt);
					ps.setString(1, shguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}

					// 查找更新数据
					String sqlSelect = "SELECT ZGH,ZWH FROM " + tn + " WHERE GUID=?";
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlSelect);
					ps.setString(1, shguid);
					rs = ps.executeQuery();
					rs.first();
					String gh = rs.getString("ZGH").trim();
					String zwh = rs.getString("ZWH").trim();

					// 向审核记录表中插入数据
					// SHYJ, SHRY, SHRYBH, SHDXBH, SHSJ, SHXM,ZHBH, GH, ZWH
					String shry = (String) session.getAttribute("NAME");
					String shrybh = (String) session.getAttribute("guid");
					String guid = UUIDUtil.getUUID();
					String sql = "insert into bgshjl(guid,SHYJ,SHRY,SHRYBH,SHDXBH,SHSJ,SHXM,ZHBH,GH,ZWH) VALUES(?,?,?,?,?,now(),?,?,?,?)";
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);
					ps.setString(1, guid);
					ps.setString(2, suggest);
					ps.setString(3, shry);
					ps.setString(4, shrybh);
					ps.setString(5, shguid);
					ps.setString(6, shmc);
					ps.setString(7, zhxxguid);
					ps.setString(8, gh);
					ps.setString(9, zwh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
						conn.rollback();
					}

				} else {
					return flag;
				}

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}

	@RequestMapping(value = "getAduitRecord", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String getAduitRecord(HttpServletRequest request, HttpServletResponse res, String shdxbh, String shmc)
			throws Exception {
		conn = LinkSql.getConn();
		ResultSetMetaData md = null;
		list = new ArrayList<Map<String, Object>>();
		int columnCount = 0;

		try {
			String sql = "SELECT SHYJ,SHSJ,SHRY FROM BGSHJL WHERE SHDXBH=? AND SHXM=?";
			ps = LinkSql.Execute(conn, sql, "5", "BGSHJL");
			ps.setString(1, shdxbh);
			ps.setString(2, shmc);
			rs = ps.executeQuery();
		} catch (Exception e) {
			conn.rollback();
		}
		md = rs.getMetaData();
		columnCount = md.getColumnCount(); // 获得列数
		String flag = "notNull";
		while (rs.next()) {
			System.out.println(rs.getObject("SHYJ"));
			if (rs.getObject("SHYJ").equals("")) {
				flag = "isNull";
			} else {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						rowData.put(md.getColumnName(i), rs.getObject(i).toString());
					}
				}
				list.add(rowData);
			}
		}
		if (flag.equals("isNull")) {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":1,\"data\":" + null + "}";
			return jso;
		} else {
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":1,\"data\":" + js + "}";
			return jso;
		}

	}

	/**
	 * 查询条件
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "queryCondition")
	@ResponseBody
	public Object queryCondition(HttpServletRequest request, HttpServletResponse res, String guid, String zhxxDj,
			String bmDj, String bmcDj, String typeDj) throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		session.setAttribute("zhxxDj", zhxxDj);
		session.setAttribute("bmDj", bmDj);
		session.setAttribute("bmcDj", bmcDj);
		session.setAttribute("typeDj", typeDj);
		try {
			/*
			 * 定义
			 */
			list = new ArrayList<Map<String, Object>>();// 实例化
			String tn = null;// 数据表表名，根据guid获取
			String desTn = null;// 描述表表名
			String sqlWhere = null;// sql语句条件
			ResultSetMetaData md = null;
			int columnCount = 0;
			// 根据guid获取数据表表名，根据规则得到描述表表名
			if (typeDj.equals("true")) {
				tn = bmDj + "_" + zhxxDj;
				desTn = bmDj + "_des_" + zhxxDj;
			} else {
				tn = Bmodel.findBmByGuId(guid);// 描述表
				desTn = tn + "_des";
			}

			// 连接数据库
			conn = LinkSql.getConn();// 创建对象
			sqlWhere = " and  isselect >=1 ORDER BY isselect asc";
			String sqlFind = " SELECT id,zdm,zdmc,initval,types,jsdm,isedit,api,formtypes,guid,isselect,width FROM  "
					+ desTn + " WHERE 1=1" + sqlWhere;
			ps = LinkSql.Execute(conn, sqlFind, role, desTn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);
			}
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return list;

	}

	/**
	 * 查询施工人员保单图片
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "GetbdimgByGuid")
	@ResponseBody
	public Object GetbdimgByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid)
			throws Exception {
		String tp = "";
		JSONObject json = new JSONObject();
		try {
			/*
			 * 定义
			 */
			list = new ArrayList<Map<String, Object>>();// 实例化
			String tn = "sgrybx_" + zhxxguid;// 数据表表名，根据guid获取
			String desTn = "sgrybx_des_" + zhxxguid;// 描述表表名
			ResultSetMetaData md = null;
			int columnCount = 0;

			conn = LinkSql.getConn();// 创建对象
			String sqlFind = " SELECT SGRYBD FROM  " + tn;
			ps = LinkSql.Execute(conn, sqlFind, "5", tn);
			rs = ps.executeQuery();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			while (rs.next()) {
				tp = rs.getObject("SGRYBD").toString();
				json.put("tp", tp);
			}

		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return json;
	}
	@RequestMapping(value = "findsgryDoc")
	 @ResponseBody
	 /**
	  * 获取表头
	  * 
	  * @param page
	  * @param request
	  * @param res
	  * @param guid
	  * @param num
	  * @param limit
	  * @return
	  * @throws Exception
	  */
	 public Object findsgryDoc(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid) throws Exception {
	  try {
	   HttpSession session = request.getSession();
	   final String user = (String) session.getAttribute("user");
	   final String role = (String) session.getAttribute("role");
	   String zhxxDj = (String) session.getAttribute("zhxxDj");
	   String bmDj = (String) session.getAttribute("bmDj");
	   String typeDj = (String) session.getAttribute("typeDj");
	   list = new ArrayList<Map<String, Object>>();
	   String tn = null;
	   ResultSetMetaData md = null;
	   int columnCount = 0;
	   String destn = null;
	   String sqlRale = null;
	   if (typeDj.equals("true")) {
	    tn = bmDj + "_" + zhxxDj;
	    destn = bmDj + "_des_" + zhxxDj;
	   } else {
	    tn = Bmodel.findBmByGuId(guid);// 描述表
	    destn = tn + "_des";
	   }

	   String sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
	   sqlDes = sqlDes + " and isshow = 1  ";
	   if (user != null && role != null) {
	    sqlRale = "";
	    sqlDes = sqlDes + sqlRale;
	   }
	   sqlDes = sqlDes + " order by lisnum asc,id asc ";
	   conn = LinkSql.getConn();
	   ps = LinkSql.Execute(conn, sqlDes, role, destn);
	   rs = ps.executeQuery();
	   md = rs.getMetaData(); // 获得结果集结构信息,元数据
	   columnCount = md.getColumnCount(); // 获得列数
	   while (rs.next()) {
	    Map<String, Object> rowData = new HashMap<String, Object>();
	    for (int i = 1; i <= columnCount; i++) {
	     rowData.put(md.getColumnName(i), rs.getObject(i));
	    }
	    list.add(rowData);
	   }
	  } finally {
	   ps.close();
	   rs.close();
	   conn.close();
	  }
	  return list;
	 }
	 
	/**
	 * 渲染数据表格
	 * 
	 * @param page
	 * @param request
	 * @param res
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findsgryDocTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findsgryDocTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit) throws Exception {
		HttpSession session = request.getSession();
		final String role = (String) session.getAttribute("role");
		String roleid = (String) session.getAttribute("roleid");
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		if (typeDj.equals("true")) {
			tn = bmDj + "_" + zhxxDj;
			destn = bmDj + "_des_" + zhxxDj;
		} else {
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
		}
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String sqlzdm = "select zdm from " + destn;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlWhere = "";
			if (postData != null) {
				String tmp[] = postData.split("&");
				for (int i = 0; i < tmp.length; i++) {
					String s = postData.split("&")[i];
					s = s + " ";
					String name = s.split("=")[0];
					String value = s.split("=")[1];
					value = value.trim();
					if (value.length() != 0) {
						if (!value.equals("请选择")) {
							sqlWhere += " and " + name + " like '%" + value + "%' ";
						}
					}
				}
			}
			String sqlData = null;
			// 用于权限设置当不是开发人员时，无法对开发和主管理员的权限进行设置。
			if (guid.equals("acc0357dd46e42129f534f4820781a5a")) {
				if (!role.equals("开发人员")) {
					sqlWhere += " and guid != 'a666df5383f345868cc5b46a257da351' AND guid !='97e115aba8124896833070694701d96b'";
				}
			}
			String sqlWhereZc = "";
			if (roleid.equals("4") || roleid.equals("5")) {
				if (tn.equals("user")) {// 该操作对应主场管理员,工作人员中的人员管理，因人员管理只需要审核搭建商即可。
					if (guid.equals("00c99009ec2d4cb883acc9ae24f73b6e")
							|| guid.equals("b58f1fdfb3cf451fabd704a6c8f8eadf")) {
						sqlWhereZc += " and roleid=1  order by id desc";
					} else {// 该操作对应权限表中显示除开发人员外的其他人员的权限管理。
						sqlWhereZc += " and roleid!=3 order by id desc";
					}
				}
			}
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc;
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						//图片重新定义字段值
						if(md.getColumnName(i).equals("SFZSMJ")||md.getColumnName(i).equals("SGRYBD")||md.getColumnName(i).equals("PZ")){
							String[] tp=rs.getObject(i).toString().split(",");
							String chakan="";
							String ck="<div><div style='text-align: center;'>";
							if(tp.length>1){
								for(int j=0;j<tp.length;j++){																	
									ck+="<a class='layui-table-link' href='"+tp[j]+"' target='_blank'><img style='width:38px;height:38px' src='"+tp[j]+"' class='layui-table-link'></a>";
								}
								ck+="</div><div>";
								rowData.put(md.getColumnName(i),ck);
								
							}else{
								chakan="<div><div style='text-align: center;'><a class='layui-table-link' href='"+tp[0]+"' target='_blank'><img style='height:38px;height:38px' src='"+tp[0]+"' class='layui-table-link'></a></div><div>";
								rowData.put(md.getColumnName(i),chakan);
							}																											
						}else{
							rowData.put(md.getColumnName(i), rs.getObject(i).toString());
						}												
					}

				}
				list.add(rowData);
			}

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1 " + sqlWhere + " ";
			ps = conn.prepareStatement(sqlCount);
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			String count = null;
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					count = rs.getObject(i).toString();
				}
			}
			JSONArray json = JSONArray.fromObject(list);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} else {
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}

	}
	
	@RequestMapping("updryStateByGuid")
	@ResponseBody
	public int updryStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid,String audit,String suggest,String dwbh) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;
			try {
				if(audit.equals("pass")){
					String tn = "sgryxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "sgryxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE RYBDB SET BDZT='已通过',RYZT='已通过'  WHERE ZHBH=? and dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					ps.setString(2, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sql1 = "UPDATE "+tn+" SET  ZT='已通过' where dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql1);
					ps.setString(1, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					tn = "sgrybx_" + zhxxguid;
					String sql2 = "UPDATE "+tn+" SET ZT='已通过' where dwbh=?";													
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql2);	
					ps.setString(1, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
						flag=1;
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}																																					
										
				}else if(audit.equals("NoPass")){
					//修改报馆信息状态
					String tn = "sgryxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "sgryxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE RYBDB SET BDZT='未通过',RYZT='未通过'  WHERE ZHBH=? and dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					ps.setString(2, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sql1 = "UPDATE "+tn+" SET  ZT='未通过' where dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql1);	
					ps.setString(1, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					tn = "sgrybx_" + zhxxguid;
					String sql2 = "UPDATE "+tn+" SET ZT='未通过' where dwbh=?";													
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql2);
					ps.setString(1, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}					
					
					//向审核记录表中插入数据
					// SHYJ, SHRY, SHRYBH, SHDXBH, SHSJ, SHXM,ZHBH, GH, ZWH
					String shry=(String)session.getAttribute("NAME");
				    String shrybh=(String)session.getAttribute("guid");
				    String guid=UUIDUtil.getUUID();
				    String sqlinsert = "insert into bgshjl(guid,SHYJ,SHRY,SHRYBH,SHSJ,SHXM,ZHBH,DWBH) VALUES(?,?,?,?,now(),?,?,?)";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlinsert);				
					ps.setString(1, guid);
					ps.setString(2, suggest);
					ps.setString(3, shry);
					ps.setString(4, shrybh);		
					ps.setString(5, "SGRYXX");
					ps.setString(6, zhxxguid);
					ps.setString(7, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
						conn.rollback();
					}				   					
					
				}else{
					return flag;
				}		

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	
	@RequestMapping("updhcStateByGuid")
	@ResponseBody
	public int updhcStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid,String audit,String suggest,String dwbh) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;
			try {
				if(audit.equals("pass")){
					String tn = "hcxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "hcxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE "+tn+" SET ZT='已通过'  WHERE ZHBH=? and dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					ps.setString(2, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
						flag=1;
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}																																													
										
				}else if(audit.equals("NoPass")){
					//修改报馆信息状态
					String tn = "hcxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "hcxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE "+tn+" SET ZT='未通过'  WHERE ZHBH=? and dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					ps.setString(2, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}											
					
					//向审核记录表中插入数据
					// SHYJ, SHRY, SHRYBH, SHDXBH, SHSJ, SHXM,ZHBH, GH, ZWH
					String shry=(String)session.getAttribute("NAME");
				    String shrybh=(String)session.getAttribute("guid");
				    String guid=UUIDUtil.getUUID();
				    String sqlinsert = "insert into bgshjl(guid,SHYJ,SHRY,SHRYBH,SHSJ,SHXM,ZHBH,DWBH) VALUES(?,?,?,?,now(),?,?,?)";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlinsert);				
					ps.setString(1, guid);
					ps.setString(2, suggest);
					ps.setString(3, shry);
					ps.setString(4, shrybh);		
					ps.setString(5, "HCXX");
					ps.setString(6, zhxxguid);
					ps.setString(7, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
						conn.rollback();
					}				   					
					
				}else{
					return flag;
				}		

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	
	@RequestMapping("updpzStateByGuid")
	@ResponseBody
	public int updpzStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid,String audit,String suggest,String dwbh) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;
			try {
				if(audit.equals("pass")){
					String tn = "zzpz_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "zzpz_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE "+tn+" SET ZT='已通过'  WHERE ZHBH=? and dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					ps.setString(2, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
						flag=1;
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}																																													
										
				}else if(audit.equals("NoPass")){
					//修改报馆信息状态
					String tn = "zzpz_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "zzpz_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE "+tn+" SET ZT='未通过'  WHERE ZHBH=? and dwbh=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					ps.setString(2, dwbh);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}											
					
					//向审核记录表中插入数据
					// SHYJ, SHRY, SHRYBH, SHDXBH, SHSJ, SHXM,ZHBH, GH, ZWH
					String shry=(String)session.getAttribute("NAME");
				    String shrybh=(String)session.getAttribute("guid");
				    String guid=UUIDUtil.getUUID();
				    String sqlinsert = "insert into bgshjl(guid,SHYJ,SHRY,SHRYBH,SHSJ,SHXM,ZHBH) VALUES(?,?,?,?,now(),?,?)";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlinsert);				
					ps.setString(1, guid);
					ps.setString(2, suggest);
					ps.setString(3, shry);
					ps.setString(4, shrybh);		
					ps.setString(5, "ZZPZ");
					ps.setString(6, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
						conn.rollback();
					}				   					
					
				}else{
					return flag;
				}		

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	//退押金审核
	@RequestMapping("updtyjshStateByGuid")
	@ResponseBody
	public int updtyjshStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid,String audit,String suggest,String dwbh) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;
			try {
				if(audit.equals("pass")){
					String tn = "tyjxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "tyjxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE KPTYJ SET HKZT='已通过'  WHERE ZHBH=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sql1 = "UPDATE "+tn+" SET  ZT='已通过'";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql1);				
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}																																										
										
				}else if(audit.equals("NoPass")){
					//修改报馆信息状态
					String tn = "tyjxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "tyjxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE KPTYJ SET HKZT='未通过'  WHERE ZHBH=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sql1 = "UPDATE "+tn+" SET  ZT='未通过'";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql1);				
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}								
					
					//向审核记录表中插入数据
					// SHYJ, SHRY, SHRYBH, SHDXBH, SHSJ, SHXM,ZHBH, GH, ZWH
					String shry=(String)session.getAttribute("NAME");
				    String shrybh=(String)session.getAttribute("guid");
				    String guid=UUIDUtil.getUUID();
				    String sqlinsert = "insert into bgshjl(guid,SHYJ,SHRY,SHRYBH,SHSJ,SHXM,ZHBH) VALUES(?,?,?,?,now(),?,?)";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlinsert);				
					ps.setString(1, guid);
					ps.setString(2, suggest);
					ps.setString(3, shry);
					ps.setString(4, shrybh);		
					ps.setString(5, "TYJXX");
					ps.setString(6, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
						conn.rollback();
					}				   					
					
				}else{
					return flag;
				}		

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	//开票信息审核
	@RequestMapping("updkpshStateByGuid")
	@ResponseBody
	public int updkpshStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid,String audit,String suggest,String dwbh) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;
			try {
				if(audit.equals("pass")){
					String tn = "kfpxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "kfpxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE KPTYJ SET KPZT='已通过'  WHERE ZHBH=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sql1 = "UPDATE "+tn+" SET  ZT='已通过'";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql1);				
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}																																										
										
				}else if(audit.equals("NoPass")){
					//修改报馆信息状态
					String tn = "kfpxx_" + zhxxguid;// 数据表表名，根据guid获取
					String desTn = "kfpxx_des_" + zhxxguid;// 描述表表名
					
					String sql = "UPDATE KPTYJ SET KPZT='未通过'  WHERE ZHBH=?";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql);				
					ps.setString(1, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}
					
					String sql1 = "UPDATE "+tn+" SET  ZT='未通过'";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sql1);				
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}								
					
					//向审核记录表中插入数据
					// SHYJ, SHRY, SHRYBH, SHDXBH, SHSJ, SHXM,ZHBH, GH, ZWH
					String shry=(String)session.getAttribute("NAME");
				    String shrybh=(String)session.getAttribute("guid");
				    String guid=UUIDUtil.getUUID();
				    String sqlinsert = "insert into bgshjl(guid,SHYJ,SHRY,SHRYBH,SHSJ,SHXM,ZHBH) VALUES(?,?,?,?,now(),?,?)";					
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlinsert);				
					ps.setString(1, guid);
					ps.setString(2, suggest);
					ps.setString(3, shry);
					ps.setString(4, shrybh);		
					ps.setString(5, "KFPXX");
					ps.setString(6, zhxxguid);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
						conn.rollback();
					}				   					
					
				}else{
					return flag;
				}		

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	//施工人员信息提交审核
	@RequestMapping("updtijiaoStateByGuid")
	@ResponseBody
	public int updtijiaoStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();			
			try {				
					//修改报馆信息状态
					String tn = "sgryxx_" + zhxxguid;
					String desTn = "sgryxx_des_" + zhxxguid;
					String sqlAudit = "UPDATE "+tn+" SET ZT='已提交'";
													
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudit);								
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}				
					
					
					//根据展会编号查找展会名称
					String str = "select id from rybdb where zhbh='"+zhxxguid+"'";
					ps = conn.prepareStatement(str);
					rs = ps.executeQuery();
					String flagcz="false";
					while (rs.next()) {
						flagcz="true";
					}
					
					if(flagcz.equals("true")){//存在
						//只要有一个状态是不通过,就把大的状态修改成拒绝
						String sql = "UPDATE rybdb SET RYZT='已提交'  WHERE ZHBH=?";
						
						conn.setAutoCommit(false);
						ps = conn.prepareStatement(sql);				
						ps.setString(1, zhxxguid);
						try {
							flag = ps.executeUpdate();
							conn.commit();
						} catch (Exception e) {
							// TODO 自动生成的 catch 块
							conn.rollback();
						}													
						
					}else{
						//根据展会编号查找展会名称
						String sqlzhbh = "select zhmc from zhxx where guid='"+zhxxguid+"'";
						ps = conn.prepareStatement(sqlzhbh);
						rs = ps.executeQuery();
						String zhmc="";
						while (rs.next()) {
							zhmc = rs.getString("zhmc");
						}			
									
						//同时向施工人员过程表添加一条数据RYBDB   ZHBH,DWMC,LXR,SJ,RYZT(已填报),BDZT(未填报)  guid = UUIDUtil.getUUID();
						String sqlinsert = "INSERT INTO RYBDB (ZHBH,DWMC,LXR,SJ,RYZT,BDZT,guid,DWBH,ZHMC) VALUES (\'" + zhxxguid + "\',\'" + gsmc + "\',\'" + names + "\',\'" + sjDJ + "\','已提交','未提交',\'" + UUIDUtil.getUUID() + "\',\'" + guiddwbh + "\',\'" +zhmc+ "\')";
						ps = conn.prepareStatement(sqlinsert);
						ps.executeUpdate();
						conn.commit();						
					}
																				

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	
	@RequestMapping("updtyjStateByGuid")
	@ResponseBody
	public int updtyjStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();			
			try {				
					
					String tn = "tyjxx_" + zhxxguid;
					String desTn = "tyjxx_des_" + zhxxguid;
					String sqlAudit = "UPDATE "+tn+" SET ZT='已提交'";
													
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudit);								
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}				
					
					
					//根据展会编号查找展会名称
					String str = "select id from kptyj where zhbh='"+zhxxguid+"'";
					ps = conn.prepareStatement(str);
					rs = ps.executeQuery();
					String flagcz="false";
					while (rs.next()) {
						flagcz="true";
					}
					
					if(flagcz.equals("true")){//存在						
						String sql = "UPDATE kptyj SET HKZT='已提交'  WHERE ZHBH=?";
						
						conn.setAutoCommit(false);
						ps = conn.prepareStatement(sql);				
						ps.setString(1, zhxxguid);
						try {
							flag = ps.executeUpdate();
							conn.commit();
						} catch (Exception e) {
							// TODO 自动生成的 catch 块
							conn.rollback();
						}													
						
					}else{
						//根据展会编号查找展会名称
						String sqlzhbh = "select zhmc from zhxx where guid='"+zhxxguid+"'";
						ps = conn.prepareStatement(sqlzhbh);
						rs = ps.executeQuery();
						String zhmc="";
						while (rs.next()) {
							zhmc = rs.getString("zhmc");
						}			

						String sqlinsert = "INSERT INTO kptyj (ZHBH,DWMC,LXR,SJ,HKZT,KPZT,guid,DWBH) VALUES (\'" + zhxxguid + "\',\'" + gsmc + "\',\'" + names + "\',\'" + sjDJ + "\','已提交','未提交',\'" + UUIDUtil.getUUID() + "\',\'" + guiddwbh + "\')";
						ps = conn.prepareStatement(sqlinsert);
						ps.executeUpdate();
						conn.commit();						
					}
																				

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	
	@RequestMapping("updkfpStateByGuid")
	@ResponseBody
	public int updkfpStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();			
			try {				
					
					String tn = "kfpxx_" + zhxxguid;
					String desTn = "kfpxx_des_" + zhxxguid;
					String sqlAudit = "UPDATE "+tn+" SET ZT='已提交'";
													
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudit);								
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}				
					
					
					//根据展会编号查找展会名称
					String str = "select id from kptyj where zhbh='"+zhxxguid+"'";
					ps = conn.prepareStatement(str);
					rs = ps.executeQuery();
					String flagcz="false";
					while (rs.next()) {
						flagcz="true";
					}
					
					if(flagcz.equals("true")){//存在						
						String sql = "UPDATE kptyj SET KPZT='已提交'  WHERE ZHBH=?";
						
						conn.setAutoCommit(false);
						ps = conn.prepareStatement(sql);				
						ps.setString(1, zhxxguid);
						try {
							flag = ps.executeUpdate();
							conn.commit();
						} catch (Exception e) {
							// TODO 自动生成的 catch 块
							conn.rollback();
						}													
						
					}else{
						//根据展会编号查找展会名称
						String sqlzhbh = "select zhmc from zhxx where guid='"+zhxxguid+"'";
						ps = conn.prepareStatement(sqlzhbh);
						rs = ps.executeQuery();
						String zhmc="";
						while (rs.next()) {
							zhmc = rs.getString("zhmc");
						}			

						String sqlinsert = "INSERT INTO kptyj (ZHBH,DWMC,LXR,SJ,HKZT,KPZT,guid,DWBH) VALUES (\'" + zhxxguid + "\',\'" + gsmc + "\',\'" + names + "\',\'" + sjDJ + "\','未提交','已提交',\'" + UUIDUtil.getUUID() + "\',\'" + guiddwbh + "\')";
						ps = conn.prepareStatement(sqlinsert);
						ps.executeUpdate();
						conn.commit();						
					}
																				

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	@RequestMapping("updhcxxStateByGuid")
	@ResponseBody
	public int updhcxxStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();	
			try {				
				//修改报馆信息状态
				String tn = "hcxx_" + zhxxguid;
				String desTn = "hcxx_des_" + zhxxguid;
				String sqlAudit = "UPDATE "+tn+" SET ZT='已提交' where DWBH='"+guiddwbh+"'";
												
				conn.setAutoCommit(false);
				ps = conn.prepareStatement(sqlAudit);								
				try {
					flag = ps.executeUpdate();
					conn.commit();
				} catch (Exception e) {
					// TODO 自动生成的 catch 块
					conn.rollback();
				}																																							
			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	@RequestMapping("updzzpzStateByGuid")
	@ResponseBody
	public int updzzpzStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();	
			try {				
				//修改报馆信息状态
				String tn = "zzpz_" + zhxxguid;
				String desTn = "zzpz_des_" + zhxxguid;
				String sqlAudit = "UPDATE "+tn+" SET ZT='已提交' where DWBH='"+guiddwbh+"'";
												
				conn.setAutoCommit(false);
				ps = conn.prepareStatement(sqlAudit);								
				try {
					flag = ps.executeUpdate();
					conn.commit();
				} catch (Exception e) {
					// TODO 自动生成的 catch 块
					conn.rollback();
				}																																							
			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	@RequestMapping("updtijiaobxStateByGuid")
	@ResponseBody
	public int updtijiaobxStateByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();			
			try {				
					//修改报馆信息状态
					String tn = "sgrybx_" + zhxxguid;
					String desTn = "sgrybx_des_" + zhxxguid;
					String sqlAudit = "UPDATE "+tn+" SET ZT='已提交'";
													
					conn.setAutoCommit(false);
					ps = conn.prepareStatement(sqlAudit);								
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						// TODO 自动生成的 catch 块
						conn.rollback();
					}				
					
					
					//根据展会编号查找展会名称
					String str = "select id from rybdb where zhbh='"+zhxxguid+"' and dwbh='"+guiddwbh+"'";
					ps = conn.prepareStatement(str);
					rs = ps.executeQuery();
					String flagcz="false";
					while (rs.next()) {
						flagcz="true";
					}
					
					if(flagcz.equals("true")){//存在
						//只要有一个状态是不通过,就把大的状态修改成拒绝
						String sql = "UPDATE rybdb SET BDZT='已提交'  WHERE ZHBH=?";
						
						conn.setAutoCommit(false);
						ps = conn.prepareStatement(sql);				
						ps.setString(1, zhxxguid);
						try {
							flag = ps.executeUpdate();
							conn.commit();
						} catch (Exception e) {
							// TODO 自动生成的 catch 块
							conn.rollback();
						}													
						
					}else{
						//根据展会编号查找展会名称
						String sqlzhbh = "select zhmc from zhxx where guid='"+zhxxguid+"'";
						ps = conn.prepareStatement(sqlzhbh);
						rs = ps.executeQuery();
						String zhmc="";
						while (rs.next()) {
							zhmc = rs.getString("zhmc");
						}			
									
						//同时向施工人员过程表添加一条数据RYBDB   ZHBH,DWMC,LXR,SJ,RYZT(已填报),BDZT(未填报)  guid = UUIDUtil.getUUID();
						String sqlinsert = "INSERT INTO RYBDB (ZHBH,DWMC,LXR,SJ,RYZT,BDZT,guid,DWBH,ZHMC) VALUES (\'" + zhxxguid + "\',\'" + gsmc + "\',\'" + names + "\',\'" + sjDJ + "\','未提交','已提交',\'" + UUIDUtil.getUUID() + "\',\'" + guiddwbh + "\',\'" +zhmc+ "\')";
						ps = conn.prepareStatement(sqlinsert);
						ps.executeUpdate();
						conn.commit();						
					}
																				

			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}
	
	
	//根据状态显示不合格内容
	@RequestMapping("getshjlByGuid")
	@ResponseBody
	public int getshjlByGuid(HttpServletRequest request, HttpServletResponse res, String zhxxguid,String bm) throws Exception {
		{
			HttpSession session = request.getSession();
			conn = LinkSql.getConn();
			int flag = 0;		
			String gsmc = session.getAttribute("GSMC").toString();
			String names = session.getAttribute("NAME").toString();
			String sjDJ = session.getAttribute("SJ").toString();
			String guiddwbh = session.getAttribute("guid").toString();
			
			String tn = bm+"_" + zhxxguid;
			String desTn = bm+"_des_" + zhxxguid;
			try {								
				//根据展会编号查找项目状态
				String sqlzhbh = "select ZT from "+tn+"where DWBH='"+guiddwbh+"'";
				ps = conn.prepareStatement(sqlzhbh);
				rs = ps.executeQuery();
				String zt="";
				while (rs.next()) {
					zt = rs.getString("ZT");
				}
				
				if(zt.equals("未通过")){
					sqlzhbh = "select SHYJ from bgshjl where zhbh='"+zhxxguid+"' and SHXM='"+bm+"'";
					ps = conn.prepareStatement(sqlzhbh);
					rs = ps.executeQuery();
					String yy="";
					while (rs.next()) {
						yy = rs.getString("SHYJ");
					}
					
					
				}
				conn.setAutoCommit(false);								
				try {
					flag = ps.executeUpdate();
					conn.commit();
				} catch (Exception e) {
					// TODO 自动生成的 catch 块
					conn.rollback();
				}																																							
			} catch (Exception e) {
				conn.rollback();
			}
			return flag;
		}
	}						
}
