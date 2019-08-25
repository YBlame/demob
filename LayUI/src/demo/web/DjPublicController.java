package demo.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.dao.Bmodel;
import demo.tool.LinkSql;
import demo.tool.MD5;
import demo.tool.PageUtils;
import demo.tool.PublicMethod;
import demo.tool.UUIDUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "djpublic")
public class DjPublicController {

	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private List<Map<String, Object>> list;

	@RequestMapping(value = "submitXx")
	@ResponseBody
	public JSONObject submitXx(HttpServletRequest request) throws Exception {
		// 获取描述表字段
		HttpSession session = request.getSession();
		Enumeration pNames = request.getParameterNames();
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		JSONObject json = new JSONObject();
		String name = null;
		String sqlSet = "";
		String zhxxGuid = null;
		String thisGuid = null;
		String bmc = null;
		while (pNames.hasMoreElements()) {
			name = (String) pNames.nextElement();
			if (name.equals("ZHBH")) {
				zhxxGuid = request.getParameter(name).trim();
			} else if (name.equals("guid")) {
				thisGuid = request.getParameter(name).trim();
			} else if (name.equals("bmc")) {
				bmc = request.getParameter(name).trim();
			} else {
				sqlSet += name.trim() + "='" + request.getParameter(name).trim() + "',";
			}
		}
		sqlSet = sqlSet.substring(0, sqlSet.length() - 1);

		conn = LinkSql.getConn();
		String sql = "select bm from smodel where bmc = '" + bmc + "' ";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		rs.next();
		String bm = rs.getString("bm");
		conn = LinkSql.getConn();
		conn.setAutoCommit(false);
		String tn = bm + "_" + zhxxGuid;
		String sqlSelect = "";
		if(bm.equals("SGRYBX")){
			sqlSelect = "UPDATE " + tn + " SET " + sqlSet + ",RQ=NOW(),ZT='未提交' where guid = ?";
		}else{
			sqlSelect = "UPDATE " + tn + " SET " + sqlSet + " where guid = ?";
		}
		
		ps = conn.prepareStatement(sqlSelect);
		ps.setString(1, thisGuid);
		try {
			ps.executeUpdate();
			conn.commit();
			json.put("msg", "修改信息成功");
			json.put("success", true);
			json.put("zhxx", zhxxDj);
			json.put("bm", bmDj);
			json.put("bmc", bmc);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			conn.rollback();
			e.printStackTrace();
			json.put("msg", "修改失败，请重试");
			json.put("success", false);
			return json;
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return json;

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
						sqlWhereZc += " and roleid=1";
					} else {// 该操作对应权限表中显示除开发人员外的其他人员的权限管理。
						sqlWhereZc += " and roleid!=3 ";
					}
				}
			}
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + sqlWhereZc +"   order by id desc";
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
						// 图片重新定义字段值
						if (md.getColumnName(i).equals("SFZSMJ") || md.getColumnName(i).equals("SGRYBD")|| md.getColumnName(i).equals("YBRNSRZM")|| md.getColumnName(i).equals("PZ")) {
							String[] tp = rs.getObject(i).toString().split(",");
							String chakan = "";
							String ck = "<div><div style='text-align: center;'>";
							if (tp.length > 1) {
								for (int j = 0; j < tp.length; j++) {
									ck += "<a class='layui-table-link' href='" + tp[j]
											+ "' target='_blank'><img style='width:38px;height:38px' src='" + tp[j]
											+ "' class='layui-table-link'></a>";
								}
								ck += "</div><div>";
								rowData.put(md.getColumnName(i), ck);

							} else {
								chakan = "<div><div style='text-align: center;'><a class='layui-table-link' href='"
										+ tp[0] + "' target='_blank'><img style='height:38px;height:38px' src='" + tp[0]
										+ "' class='layui-table-link'></a></div><div>";
								rowData.put(md.getColumnName(i), chakan);
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
	 * 去添加数据页面
	 * 
	 * @param model
	 * @param request
	 * @param res
	 * @param guid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toAddDataJsp")
	public String toAddDataJsp(Model model, HttpServletRequest request, HttpServletResponse res, String guid,
			String bmc, String bm ,String zhxx, Integer id, String thisName, String zhxxDj, String bmcDj, String bmDj, String typeDj,
			String jbxx) throws Exception {
		HttpSession session = request.getSession();

		if (jbxx != null) {
			if (jbxx.equals("jbxx")) {
				request.setAttribute("zhxxDj", zhxxDj);
				request.setAttribute("bmcDj", bmcDj);
				request.setAttribute("bmDj", bmDj);
				request.setAttribute("typeDj", typeDj);
				session.setAttribute("zhxxDj", zhxxDj);
				session.setAttribute("bmcDj", bmcDj);
				session.setAttribute("bmDj", bmDj);
				session.setAttribute("typeDj", typeDj);
				request.setAttribute("bmc", bmc);
			}
		} else {
			request.setAttribute("guid", guid);
			request.setAttribute("id", null);
			request.setAttribute("parentName", null);
			request.setAttribute("bmc", bmc);
			request.setAttribute("bm", bm);
		}
		return "/DJ/public/public_add";
	}

	/**
	 * 去添加数据
	 * 
	 * @param model
	 * @param pid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toAddData")
	@ResponseBody
	public Object toAddData(Model model, HttpServletRequest request, HttpServletResponse res, String guid,
			String guidBmodel) throws Exception {
		HttpSession session = request.getSession();
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		String bmcDj = (String) session.getAttribute("bmcDj");

		// 拿到guid,查询模型表表名
		list = new ArrayList<Map<String, Object>>();
		ResultSetMetaData md = null;
		String tn = null;
		int columnCount = 0;
		tn = bmDj + "_des_" + zhxxDj;
		rs = PublicMethod.findBmodelFieldDj(tn);
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i));
			}
			if (rs.getObject("jsdm").equals(".")) {
				rowData.put("jsdmFlag", "0");
			} else {
				rowData.put("jsdmFlag", "1");
			}
			list.add(rowData);
		}
		rs.close();
		return list;
	}

	/**
	 * 添加数据
	 * 
	 * @param model
	 * @param guid
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("public_doAdd")
	public void public_doAdd(Model model, String guid, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		String gsmc = session.getAttribute("GSMC").toString();
		String names = session.getAttribute("NAME").toString();
		String sjDJ = session.getAttribute("SJ").toString();
		String guiddwbh = session.getAttribute("guid").toString();
		String zhxxDj = (String) session.getAttribute("zhxxDj");
		String bmDj = (String) session.getAttribute("bmDj");
		String typeDj = (String) session.getAttribute("typeDj");
		String bmcDj = (String) session.getAttribute("bmcDj");
		String dataName = "";
		String destn = "";
		String dataTname = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String name = null;
		Enumeration pNames = request.getParameterNames();
		dataTname = bmcDj;
		dataName = bmDj + "_" + zhxxDj;
		destn = bmDj + "_des_" + zhxxDj;
		// 获取数据表中字段
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = "";

		int rows;
		String value;
		try {
			rs = PublicMethod.findBmodelByZdm(destn);
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			// 循环出字段名
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					sqlZdmc = sqlZdmc + rs.getObject(i) + ",";

				}
			}
			rs.last();// 指针移到最后一条后面
			rows = rs.getRow();
			value = "";
			// 循环出字段对应值
			for (int i = 0; i < rows; i++) {
				value += "? ,";
			}
			value = value.substring(0, value.length() - 1);// 数据表字段对应值
			sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);// 数据表字段
		} finally {
			rs.close();
			ps.close();
		}
		/**
		 * 当添加或修改时的隐藏字段，赋予默认值
		 */
		conn = LinkSql.getConn();
		String sqlXs = null;
		sqlXs = "select zdm from " + destn + " where xs =0";
		ps = conn.prepareStatement(sqlXs);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		String valueXs = "";
		String sqlZdmcXs = "";
		columnCount = 0;
		if (rs.next()) {
			rs.beforeFirst();
			while (rs.next()) {
				String zdm = rs.getString("zdm");
				valueXs += "," + zdm;
				switch (zdm) {
				case "DW":
					sqlZdmcXs += ",'"+session.getAttribute("GSMC").toString()+"'";
					break;
				case "ZHBH":
					sqlZdmcXs += ",'"+zhxxDj+"'";
					break;
				case "ZHMC":
					sqlZdmcXs += ",''";
					break;
				case "ZWH":
					sqlZdmcXs += ",''";
					break;
				case "ZWMC":
					sqlZdmcXs += ",''";
					break;
				case "ZGMC":
					sqlZdmcXs += ",''";
					break;
				case "JBR":
					String jbr = (String) session.getAttribute("guid");
					sqlZdmcXs += ",'" + jbr + "'";
					break;
				case "LXR":
					String lxr = (String) session.getAttribute("NAME");
					sqlZdmcXs += ",'" + lxr + "'";
					break;
				case "DWBH":
					String dwbh = (String) session.getAttribute("guid");
					sqlZdmcXs += ",'" + dwbh + "'";
					break;
				case "GH":
					sqlZdmcXs += ",'.'";
					break;
				case "RQ":
					sqlZdmcXs += ",NOW()";
					break;
				case "ZT":
					sqlZdmcXs += ",'未提交'";
					break;
				case "DJSMC":
					String djsmc = (String) session.getAttribute("GSMC");
					sqlZdmcXs += ",'" + djsmc + "'";
					break;
				case "SJ":
					String sj = (String) session.getAttribute("SJ");
					sqlZdmcXs += ",'" + sj + "'";
					break;
				case "DJSSJ":
					String djssj = (String) session.getAttribute("SJ");
					sqlZdmcXs += ",'" + djssj + "'";
					break;
				}

			}
			value += sqlZdmcXs;// 包含添加或修改中的不显示的字段
			sqlZdmc += valueXs;// 包含添加或修改中的不显示的字段
		}

		guid = UUIDUtil.getUUID();
		String sqlFindByBm = "INSERT INTO " + dataName + "(" + sqlZdmc + ",guid)VALUES(" + value + ",\'" + guid + "\')";
		conn = LinkSql.getConn();
		conn.setAutoCommit(false);
		String flag = null;
		try {
			ps = LinkSql.Execute(conn, sqlFindByBm, role, dataName);
			for (int e = 1; e <= rows; e++) {
				while (pNames.hasMoreElements()) {
					name = (String) pNames.nextElement();
					if (name.equals("file")) {
						ps.setString(e, request.getParameter("imgUrls"));
					} else {
						if (request.getParameter(name) == "") {

							ps.setString(e, null);
						} else {
							if (name.equals("mm")) {
								ps.setString(e, MD5.GetMd5(request.getParameter(name)));
							} else {
								ps.setString(e, request.getParameter(name));
							}
						}
					}
					break;
				}
			}
			ps.executeUpdate();
			conn.commit();
			flag = "addFinish";
			if(bmDj.equals("SGRYBX")){								
				String type = "当前操作已保存";
				request.getRequestDispatcher(
						"/DJ/public/public_edit.jsp?guid=" + guid + "&bmc=" + bmcDj+"&zt=true&bm="+bmDj+""+"&flag="+type)
						.forward(request, response);
			}else{
				request.getRequestDispatcher(
						"/DJ/public/public_Index.jsp?zhxx="+ zhxxDj+"&bmc="+bmcDj+"&bm="+bmDj+"&typeDj=true")
						.forward(request, response);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			flag = "addError";
			request.getRequestDispatcher("/DJ/public/public_Index.jsp?flag=" + flag).forward(request, response);
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
	}

	/**
	 * 做修改操作
	 * 
	 * @param model
	 * @param guid
	 * @param guidBmodel
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("doc_doEdit")
	public void doc_doEdit(Model model, String guid, String guidBmodel, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		guid = request.getParameter("guid"); // 数据表GUID;做修改数据操作
		String dataName = "";
		String destn = "";
		String dataTname = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String name = null;
		Enumeration pNames = request.getParameterNames();
		dataName = Bmodel.findBmByGuId(guidBmodel);
		dataTname = Bmodel.findBmcBybm(dataName);
		destn = dataName + "_des";
		// 获取数据表中字段
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = "";

		rs = PublicMethod.findBmodelByZdm(destn);
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		// 循环出字段名
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + "=?,";
			}
		}
		rs.last();// 指针移到最后一条后面
		int rows = rs.getRow();
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);// 数据表字段
		/**
		 * 当添加或修改时的隐藏字段，赋予默认值
		 */
		conn = LinkSql.getConn();
		String sqlXs = "select zdm,types from " + destn + " where xs=0";
		ps = conn.prepareStatement(sqlXs);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		String valueXs = "";
		rs.last();
		int row = rs.getRow();
		if (row != 0) {
			rs.previous();
			while (rs.next()) {
				for (int i = 0; i < row; i++) {
					String types = rs.getString("types");
					String zdm = rs.getString("zdm");
					switch (types) {
					case "datetime":
						valueXs += "," + zdm + "=NOW() ";
						break;
					case "varchar":
						if(zdm.equals("ZT")){
							valueXs += "," + zdm + "=未提交";
						}else{
							valueXs += "," + zdm + "=null";
						}
						
						break;
					case "int":
						if (zdm.equals("parentMenu")) {
							valueXs += "," + zdm + "=0";
						} else {
							valueXs += "," + zdm + "=1";
						}
						break;
					case "data":
						valueXs += "," + zdm + "=CURDATE()";
						break;
					}
				}
			}
			sqlZdmc += valueXs;// 包含添加或修改中的不显示的字段
		}
		conn = LinkSql.getConn();
		conn.setAutoCommit(false);
		String sql = "UPDATE " + dataName + " SET " + sqlZdmc + " WHERE guid =\'" + guid + "\'";
		ps = LinkSql.Execute(conn, sql, role, dataName);
		for (int e = 1; e <= rows; e++) {
			while (pNames.hasMoreElements()) {
				name = (String) pNames.nextElement();
				if (request.getParameter(name) == "") {
					ps.setString(e, null);
				} else {
					if (name.equals("mm")) {
						ps.setString(e, MD5.GetMd5(request.getParameter(name)));
					} else {
						ps.setString(e, request.getParameter(name));
					}
				}
				break;
			}
		}
		String flag = null;
		try {

			ps.executeUpdate();
			conn.commit();
			request.getRequestDispatcher("/zhxx/public/public_Index.jsp?flag=" + flag + "&bmc=" + dataTname
					+ "&guidBmodel=" + guid + " &guid=" + guidBmodel).forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			flag = "editError";
			request.getRequestDispatcher("/zhxx/public/public_edit.jsp?flag=" + flag + "&bmc=" + dataTname
					+ " &guidBmodel=" + guidBmodel + " &guid=" + guid).forward(request, response);
		}
	}

	/**
	 * 去修改页面
	 * 
	 * @param request
	 * @param res
	 * @param guid
	 * @param guidBmodel
	 * @throws Exception
	 */
	@RequestMapping("toUpdateDoc")
	public void toUpdate(HttpServletRequest request, HttpServletResponse res, String guid, String guidBmodel,
			String bmc) throws Exception {
		request.getRequestDispatcher("/DJ/public/public_edit.jsp?guid=" + guid + "&guidBmodel=" + guidBmodel + "&bmc=" + bmc)
				.forward(request, res);
	}
	/**
	 * 去不同搭建商下的不同的保单页
	 * 判断是否存在不存在进入添加页，
	 * 存在进入修改页
	 * @param request
	 * @param res
	 * @param guid
	 * @param guidBmodel
	 * @throws Exception
	 */
	@RequestMapping("toBdxx")
	public void toBdxx(HttpServletRequest request, HttpServletResponse res, String bmc ,String bm,
			String zhxx) throws Exception {
		HttpSession session = request.getSession();
		String jbr = session.getAttribute("guid").toString();
		session.setAttribute("bmDj", bm);
		session.setAttribute("bmcDj", bmc);
		session.setAttribute("typeDj", "true");
		session.setAttribute("zhxxDj", zhxx);
		conn = LinkSql.getConn();
		String tn = bm+"_"+zhxx;
		String sql = "select * from "+tn+" where jbr=?  ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, jbr);
		rs = ps.executeQuery();
		if (rs.next()) {
			rs.beforeFirst();
			while(rs.next()){
				String guid = rs.getString("guid").toString();
				String zt = rs.getString("ZT").toString();
				String ztStr = null;
				switch (zt) {
				case "未通过":
					ztStr = "true";
					break;
				case "已通过":
					ztStr = "false";
					break;
				case "未提交":
					ztStr = "true";
					break;
				case "已提交":
					ztStr = "false";
					break;
				}
				request.getRequestDispatcher(
						"/DJ/public/public_edit.jsp?guid=" + guid + "&bmc=" + bmc+"&zt="+ztStr)
						.forward(request, res);
			}
		}else{
			request.setAttribute("id", null);
			request.setAttribute("parentName", null);
			request.setAttribute("bmc", bmc);
			request.getRequestDispatcher(
					"/DJ/public/public_add.jsp?bmc=" + bmc)
					.forward(request, res);
		}
	}
}
