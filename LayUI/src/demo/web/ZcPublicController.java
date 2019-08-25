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

/**
 * 主场公用Controller 展馆管理 展位管理 消息管理 人员管理
 * 
 * @author BLAME
 *
 */

@Controller
@RequestMapping(value = "public")
public class ZcPublicController {
	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private List<Map<String, Object>> list;

	/**
	 * 获取表头
	 * 
	 * @param page
	 * @param guid
	 * @param num
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findDoc")
	@ResponseBody
	public Object findDoc(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid, Integer num,
			Integer limit) throws Exception {
		try {
			HttpSession session = request.getSession();
			final String user = (String) session.getAttribute("user");
			final String role = (String) session.getAttribute("role");
			String roleid=session.getAttribute("roleid").toString();
			list = new ArrayList<Map<String, Object>>();
			String tn = null;
			ResultSetMetaData md = null;
			int columnCount = 0;
			String destn = null;
			String sqlRale = null;
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
			String sqlDes = null;
			if(tn.equals("SYRZC")){
				if(roleid.equals("3")){
					// **在主场管理员中人员管理，不需要显示的值用iskeep来替换显示，默认为0**
					sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
					sqlDes = sqlDes + " and beizhu = 1  ";
				}else{
					sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
					sqlDes = sqlDes + " and iskeep = 0   ";
				}
				
			} else {
				sqlDes = "select zdm,zdmc,width,formtypes from " + destn + " where 1=1 ";
				sqlDes = sqlDes + " and isshow = 1  ";
			}
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
			String postData, Integer num, Integer limit, String zhxxGuid) throws Exception {
		HttpSession session = request.getSession();
		String uguid = session.getAttribute("guid").toString();
		final String role = (String) session.getAttribute("role");
		String roleid = session.getAttribute("roleid").toString().trim();
		list = new ArrayList<Map<String, Object>>();
		String tn = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String destn = null;
		tn = Bmodel.findBmByGuId(guid);// 描述表
		destn = tn + "_des";
		if (limit == null) {
			limit = 10;
		}
		page.setRows(limit);
		list = new ArrayList<Map<String, Object>>();
		String sqlZdmc = " ";
		conn = LinkSql.getConn();
		String desWhere = "";
		 if (tn.equals("SYRZC")) {//如果进入
				if(roleid.equals("3")){
					desWhere = " AND beizhu =1 ";
				}else{
					desWhere = " AND xs =1 ";
				}
			}
		String sqlzdm = "select zdm from " + destn +" where 1=1 "+desWhere;
		ps = LinkSql.Execute(conn, sqlzdm, role, destn);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		String sqlWhere = "";
		if (!zhxxGuid.equals("")) {
			if (tn.equals("SYRZC")) {//如果进入
				if(roleid.equals("3")){
					sqlWhere = " AND roleid =4 ";
				}else{
					sqlWhere = " AND roleid =5 AND GS='"+uguid+"' ";
				}
				
			} else {
				sqlWhere = " AND ZHGUID = ? ";
			}

		} else {
			if (tn.equals("SYRZC")) {//如果进入
				if(roleid.equals("3")){
					sqlWhere = " AND roleid =4 ";
				}else{
					sqlWhere = " AND roleid =5 AND GS='"+roleid+"' ";
				}
				
			}else {
				sqlWhere = " AND 1>2 ";
			}
		}
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
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		if (sqlZdmc.length() != 0) {
			String sqlData = null;
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere + " order by id desc  limit "+page.getStart()+","+page.getRows()+"  ";
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			if (!zhxxGuid.equals("")) {
				if (tn.equals("SYRZC")) {
				} else {
					if (!tn.equals("user")) {
						ps.setString(1, zhxxGuid);
					}

				}

			}
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
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

			// 得到总数
			String sqlCount = "select count(*) from " + tn + " where 1=1" + sqlWhere;
			ps = conn.prepareStatement(sqlCount);
			if (!zhxxGuid.equals("")) {
				if (tn.equals("SYRZC")) {
				} else {
					if (!tn.equals("user")) {
						ps.setString(1, zhxxGuid);
					}

				}
			}
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
		String roleid= session.getAttribute("roleid").toString();
		// 拿到guid,查询模型表表名
		list = new ArrayList<Map<String, Object>>();
		ResultSetMetaData md = null;
		String tn = null;
		int columnCount = 0;
		if (guidBmodel == null || guidBmodel.equals("null")) {
			if (guid.equals("null") || guid == null) {
				guidBmodel = "73c2efa3c34f4904ae0eee4ab31dfa79";
			} else {
				guidBmodel = guid;
			}
		}
		tn = Bmodel.findBmByGuId(guidBmodel);// 描述表
		// 获取描述表字段
		if(tn.equals("SYRZC")){
			if(roleid.equals("3")){
				
			}
			rs = PublicMethod.findBmodelField(tn, guidBmodel);
		}else{
			rs = PublicMethod.findBmodelField(tn, guidBmodel);
		}
		
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
	@RequestMapping("doc_doAdd")
	public void boc_doAdd(Model model, String guid, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		guid = request.getParameter("guid");
		String dataName = "";
		String destn = "";
		String dataTname = null;
		ResultSetMetaData md = null;
		int columnCount = 0;
		String name = null;
		Enumeration pNames = request.getParameterNames();
		dataName = Bmodel.findBmByGuId(guid);// 描述表
		dataTname = Bmodel.findBmcBybm(dataName);
		destn = dataName + "_des";

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
		if (destn.equals("user_des")) {
			sqlXs = "select zdm,types from " + destn + " where iskeep =1";
		} else {
			sqlXs = "select zdm,types from " + destn + " where xs =0";
		}
		ps = conn.prepareStatement(sqlXs);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		String valueXs = "";
		String sqlZdmcXs = "";
		columnCount = 0;
		if (rs.next()) {
			rs.beforeFirst();
			while (rs.next()) {
				String types = rs.getString("types");
				String zdm = rs.getString("zdm");

				valueXs += "," + zdm;
				System.out.println(zdm);
				System.out.println(types);
				switch (types) {
				case "datetime":
					sqlZdmcXs += ",NOW()";
					break;
				case "varchar":
					if (zdm.equals("MM")) {
						sqlZdmcXs += ",'E10ADC3949BA59ABBE56E057F20F883E'";
					} else if (zdm.equals("ZT")) {
						sqlZdmcXs += ",'通过'";
					} else {
						sqlZdmcXs += ",null";
					}

					break;
				case "int":
					sqlZdmcXs += ",1";
					break;
				case "date":
					sqlZdmcXs += ",CURDATE()";
					break;
				case "text":
					sqlZdmcXs += ",null";
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
							if (name.equals("parentMenu")) {
								ps.setInt(e, 0);
							} else {
								ps.setString(e, null);
							}
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
			request.getRequestDispatcher("/zhxx/public/public_Index.jsp?flag=" + flag + "&bmc=" + dataTname)
					.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			flag = "addError";
			request.getRequestDispatcher("/zhxx/public/public_add.jsp?flag=" + flag).forward(request, response);
		} finally {
			rs.close();
			ps.close();
			conn.close();
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
		request.getRequestDispatcher("/zhxx/public/public_edit.jsp?guid=" + guid + "&guidBmodel=" + guidBmodel + "&bmc=" + bmc)
				.forward(request, res);
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
						valueXs += "," + zdm + "=null";
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
}
