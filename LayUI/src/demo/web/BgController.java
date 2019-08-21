package demo.web;

import demo.dao.Bmodel;
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
 * 展会Controller
 * 
 * @author BLAME
 *
 */
@Controller
@RequestMapping(value = "bg")
public class BgController {
	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private Connection connCreate;
	private List<Map<String, Object>> list;

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
	@RequestMapping(value = "findBgTable", produces = "text/html;charset=utf-8")
	@ResponseBody
	// 获取表头、表数据
	public Object findBgTable(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid,
			String postData, Integer num, Integer limit, String type,String bm) throws Exception {
		HttpSession session = request.getSession();
		final String userGuid = (String) session.getAttribute("guid");
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
			if (bm!=null) {
				tn = bm + "_" + zhxxDj;
				destn = bm + "_des_" + zhxxDj;
				session.setAttribute("bmDj", bm);
			}else{
				tn = bmDj + "_" + zhxxDj;
				destn = bmDj + "_des_" + zhxxDj;
			}
			
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
		String sqlzdm = "select zdm from " + destn +"  order by id desc";
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
			String sqlWhereZt = "";
			if (type!=null) {
				 sqlWhereZt += " AND ZT = ? ";
			}
			if(userGuid!=null){
				sqlWhereZt += " AND DJSBH = ? ";
			}
			String sqlData = null;
			sqlData = "select " + sqlZdmc + ",guid from " + tn + " where 1=1 " + sqlWhere+ sqlWhereZt  +"    order by id desc";
			ps = null;
			ps = LinkSql.Execute(conn, sqlData, role, tn);
			if (type!=null) {
				 ps.setString(1, type.trim());
				 ps.setString(2, userGuid.trim());
			}else{
				ps.setString(1, userGuid.trim());
			}
			
			rs = ps.executeQuery();
			md = rs.getMetaData();
			columnCount = md.getColumnCount();
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				List listSh = new ArrayList();
				
				Integer index = 0;
				for(int j = 1; j <= columnCount; j++){
					if(md.getColumnName(j).contains("_ZT")){
						listSh.add(index, md.getColumnName(j));
						index++;
					}					
				}
				
				//获取guid
				String guids="";
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) != null) {
						if(md.getColumnName(i).equals("guid")){
							guids=rs.getObject(i).toString();							
						}
					} 
				}
				for (int i = 1; i <= columnCount; i++) {
					if (rs.getObject(i) == null) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					} else {
						System.out.println(md.getColumnName(i));
						System.out.println(md.getColumnName(i).equals(guid));
												
						String flag="false";
						String ztStr ="";
						String zt="";
						for (int k = 0; k < listSh.size(); k++) {
							ztStr = listSh.get(k).toString();
							zt = rs.getObject(listSh.get(k).toString()).toString();
							if(md.getColumnName(i).equals(ztStr.substring(0,ztStr.length()-3))){								
								flag="true";
								break;
							}																																				
						}
						
						if(flag.equals("true")){
							System.out.println(rs.getObject(i).toString());
							String mc=md.getColumnName(i);
							System.out.println(mc);
							// statics/imgs/1565593168033.jpg 
							///DJ/BGXX_EDIT.jsp?bgGuid=59262794cd964e74a8ed80865baab801
							String wtg="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/ch.png' style='margin-top:4px;'></a></div><div>";
							String wsh="<div><div style='text-align: center;'><a  href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/yt.png' style='margin-top:4px;'></a></div><div>";
							String tg="<div><div style='text-align: center;'><a    href='DJ/BGXX_EDIT.jsp?bgGuid="+guids+"' class='layui-table-link'><img src='statics/icon/dh.png' style='margin-top:4px;'></a></div><div>";
							
							if(zt.equals("未通过")){//未通过
							
								rowData.put(ztStr.substring(0, ztStr.length()-3), wtg);
																
							}else if(zt.equals("未审核")){//未审核
								
								rowData.put(ztStr.substring(0, ztStr.length()-3), wsh);
								
							}else if(zt.equals("通过")){//通过
								
								rowData.put(ztStr.substring(0, ztStr.length()-3), tg);									
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
	
	/**
	 * 
	 * 
	 * @param model
	 * @param request
	 * @param res
	 * @param guid
	 * @param guidBmodel
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toUpdateData")
	@ResponseBody
	public Object toUpdateData(Model model, HttpServletRequest request, HttpServletResponse res, String bm,
			String bmDes) throws Exception {
		// 拿到guid,查询模型表表名
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		conn = LinkSql.getConn();
		list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new TreeMap<String, Object>();
		ResultSetMetaData md = null;
		String tn = null;
		int columnCount = 0;
		String sqlZdmc = "";
		String destn = bmDes;
		// 获取表名

		rs = PublicMethod.findBmodelByZdm(destn);
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		// 循环出字段名
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				sqlZdmc = sqlZdmc + rs.getObject(i) + ",";
			}
		}
		sqlZdmc = sqlZdmc.substring(0, sqlZdmc.length() - 1);
		String sqlData = "select " + sqlZdmc + ",guid from " + bm + " order by id desc ";
		ps = LinkSql.Execute(conn, sqlData, role, bm);
		rs = ps.executeQuery();
		md = rs.getMetaData();
		columnCount = md.getColumnCount();
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				map.put(md.getColumnName(i).trim(), rs.getObject(i).toString().trim());
			}
		}
		rs.close();
		ps.close();
		conn.close();
		System.out.println(map);
		return map;
	}

	/**
	 * 获取其他字段回显到数据
	 * 
	 * @param model
	 * @param request
	 * @param res
	 * @param guid
	 * @param guidBmodel
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("returnZdmList")
	@ResponseBody
	public Object returnZdmList(Model model, HttpServletRequest request, HttpServletResponse res, String bm,
			String bmDes) throws Exception {
		// 获取描述表字段
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		list = new ArrayList<Map<String, Object>>();
		ResultSetMetaData md = null;
		int columnCount = 0;
		conn = LinkSql.getConn();
		String sqlSelect = "SELECT zdm,zdmc,isform,isedit,xs,width,tips,beizhu,formtypes,initval,jsdm,api,guid FROM " + bmDes
				+ " WHERE  xs = 1 and id>23  AND  zdm NOT LIKE '%_ZT'  ORDER BY lisnum asc , id desc";
		ps = conn.prepareStatement(sqlSelect);
		rs = ps.executeQuery();
		md = rs.getMetaData(); // 获得结果集结构信息,元数据
		columnCount = md.getColumnCount(); // 获得列数
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i).toString().trim());
			}
			list.add(rowData);
		}
		rs.close();
		ps.close();
		conn.close();
		return list;
	}

	/**
	 * 提交报馆信息
	 * 
	 * @param model
	 * @param request
	 * @param res
	 * @param guid
	 * @param guidBmodel
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("submitBgxx")
	@ResponseBody
	public Object submitBgxx(Model model, HttpServletRequest request, HttpServletResponse res) throws Exception {
		// 获取描述表字段
		HttpSession session = request.getSession();
		String userGuid = (String) session.getAttribute("guid");
		Enumeration pNames = request.getParameterNames();
		JSONObject json = new JSONObject();
		String name = null;
		String sqlSet = "";
		String sqlVal = "";
		String zhxxGuid = null;
		while (pNames.hasMoreElements()) {
			name = (String) pNames.nextElement();
			if (name.equals("zhxxGuid")) {
				zhxxGuid = request.getParameter(name).trim();
			} else {
				sqlSet += name.trim() + ",";
				sqlVal += "'" + request.getParameter(name).trim() + "',";
			}
		}
		sqlSet = sqlSet.substring(0, sqlSet.length() - 1);
		sqlVal = sqlVal.substring(0, sqlVal.length() - 1);
		System.out.println(zhxxGuid);
		conn = LinkSql.getConn();
		conn.setAutoCommit(false);
		String tn = "bgxx_" + zhxxGuid;
		String sqlSelect = "INSERT INTO " + tn + " (guid, ZWTZ_ZT, ZWJGT_ZT, GCSZZZS_ZT, ZT, RQ," + sqlSet
				+ ") values (?,?,?,?,?,now()," + sqlVal + ") ";
		ps = conn.prepareStatement(sqlSelect);
		ps.setString(1, UUIDUtil.getUUID());
		ps.setString(2, "未审核");
		ps.setString(3, "未审核");
		ps.setString(4, "未审核");
		ps.setString(5, "未提交");
		try {
			ps.executeUpdate();
			conn.commit();
			json.put("msg", "提交报馆成功，等待工作人员审核");
			json.put("success", true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			conn.rollback();
			e.printStackTrace();
			json.put("msg", "提交报馆失败，请重试");
			json.put("success", false);
			return json;
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return json;
	}
	
	@RequestMapping("findBgxxInfo")
	@ResponseBody
	public List<Map<String, Object>> findBgxxInfo(HttpServletRequest request, HttpServletResponse res, String zhxxGuid,String bgGuid)
			throws Exception {
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		conn = LinkSql.getConn();
		String tn = "BGXX_"+zhxxGuid;
		String sql = "select * from "+tn+" where guid= ? order by id desc";
		conn = LinkSql.getConn();
		ps = LinkSql.Execute(conn, sql, "1", tn);
		ps.setString(1, bgGuid.trim());
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i).toString().trim());
			}
			desList.add(rowData);
		}
		return desList;
	}
	@RequestMapping("GetShjlByGuid")
	@ResponseBody
	public List<Map<String, Object>> GetShjlByGuid(HttpServletRequest request, HttpServletResponse res,String bgGuid)
			throws Exception {
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		conn = LinkSql.getConn();
		String	tn="BGSHJL";
		String sql = "select SHYJ,MAX( SHSJ) AS SHSJ,SHXM from BGSHJL where SHDXBH= ? GROUP BY shxm ";
		conn = LinkSql.getConn();
		ps = LinkSql.Execute(conn, sql, "1", tn);
		ps.setString(1, bgGuid);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i).toString().trim());
			}
			desList.add(rowData);
		}
		return desList;
	}
	/**
	 * 提交报馆信息
	 * 
	 * @param model
	 * @param request
	 * @param res
	 * @param guid
	 * @param guidBmodel
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("updateBgxx")
	@ResponseBody
	public Object UpdateBgxx(Model model, HttpServletRequest request, HttpServletResponse res) throws Exception {
		// 获取描述表字段
		HttpSession session = request.getSession();
		String userGuid = (String) session.getAttribute("guid");
		Enumeration pNames = request.getParameterNames();
		JSONObject json = new JSONObject();
		String name = null;
		String sqlSet = "";
		String zhxxGuid = null;
		String bgGuid = null;
		String djsshdx = null;
		while (pNames.hasMoreElements()) {
			name = (String) pNames.nextElement();
			if (name.equals("zhxxGuid")) {
				zhxxGuid = request.getParameter(name).trim();
			}else if(name.equals("bgGuid")){
				bgGuid =request.getParameter(name);
			}else if(name.equals("djsshdx")){//拿到审核失败之后修改的状态名称
				djsshdx = request.getParameter(name);
			} else {
				sqlSet += name.trim() + "='"+request.getParameter(name).trim()+"',";
			}
		}
		sqlSet = sqlSet.substring(0, sqlSet.length()-1);
		djsshdx = djsshdx.substring(0,djsshdx.length()-1);
		String[] shdx =null;
		shdx =djsshdx.split(",");
		Integer len = shdx.length;
		String sql = "";
		for (int i = 0; i < shdx.length; i++) {
			sql +=" ,"+shdx[i]+"_ZT=? ";
		}
		sql.substring(0, sql.length()-1);
		conn = LinkSql.getConn();
		conn.setAutoCommit(false);
		String tn = "bgxx_" + zhxxGuid;
		String sqlSelect = "UPDATE "+tn+" SET "+sqlSet+sql+" where guid = ?";
		ps = conn.prepareStatement(sqlSelect);
		for (int j = 1; j <= len; j++) {
			ps.setString(j, "未审核");
		}
		ps.setString(len+1, bgGuid);
		try {
			ps.executeUpdate();
			conn.commit();
			json.put("msg", "报馆重提交成功，等待工作人员审核");
			json.put("success", false);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			conn.rollback();
			e.printStackTrace();
			json.put("msg", "提交报馆失败，请重试");
			json.put("success", false);
			return json;
		} finally {
			rs.close();
			ps.close();
			conn.close();
		}
		return json;
	}
	
	 
}