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
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.dao.Bmodel;
import demo.tool.LinkSql;
import demo.tool.PageUtils;
import demo.tool.PublicMethod;
import demo.tool.UUIDUtil;
import net.sf.json.JSONArray;
/**
 * 展会Controller
 * @author BLAME
 *
 */
@Controller
@RequestMapping(value = "zhxx")
public class ZhxxController {
	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private Connection connCreate;
	private List<Map<String, Object>> list;
	@RequestMapping(value = "findMenu")
	public void findMenu(HttpServletRequest request, HttpServletResponse res,String guid) throws Exception{
		request.getRequestDispatcher("zhxx/menu_Index.jsp?zhxxGuid="+ guid).forward(request, res);
	}
	
	@RequestMapping(value = "findDjsZhxx")
	@ResponseBody
	public List<Map<String, Object>> findDjsZhxx(HttpServletRequest request, HttpServletResponse res,String guid) throws Exception{
		list = new ArrayList<Map<String, Object>>();
		HttpSession session  = request.getSession();
		String zcbh = (String) session.getAttribute("ZCBH").toString().trim();
		ResultSetMetaData md = null;
		int columnCount = 0;
		String tn  = Bmodel.findBmByGuId("a65611e7bc194941a7050bb14000967d");
		conn = LinkSql.getConn();
		String sql="select guid,ZHMC from "+tn+" where 1=1 AND GSBH = '"+zcbh+"'";
		ps = conn.prepareStatement(sql);
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
		return list;
	}
	
	@RequestMapping(value = "findYbgzryZhxx")
	@ResponseBody
	public List<Map<String, Object>> findYbgzryZhxx(HttpServletRequest request, HttpServletResponse res,String guid) throws Exception{
		list = new ArrayList<Map<String, Object>>();
		HttpSession session  = request.getSession();
		String gs = (String) session.getAttribute("GS").toString().trim();
		ResultSetMetaData md = null;
		int columnCount = 0;
		String tn  = Bmodel.findBmByGuId("a65611e7bc194941a7050bb14000967d");
		conn = LinkSql.getConn();
		String sql="select guid,ZHMC from "+tn+" where 1=1 AND GSBH = '"+gs+"'";
		ps = conn.prepareStatement(sql);
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
		return list;
	}
	@RequestMapping(value = "findZcZhxx")
	@ResponseBody
	public List<Map<String, Object>> findZcZhxx(HttpServletRequest request, HttpServletResponse res,String guid) throws Exception{
		list = new ArrayList<Map<String, Object>>();
		HttpSession session  = request.getSession();
		
		String userGuid = (String)session.getAttribute("guid");//主场，一般，搭建商
		
		ResultSetMetaData md = null;
		int columnCount = 0;
		String tn  = Bmodel.findBmByGuId("a65611e7bc194941a7050bb14000967d");
		conn = LinkSql.getConn();
		String sql="select guid,ZHMC from "+tn+" where 1=1 AND GSBH = '"+userGuid+"'";
		ps = conn.prepareStatement(sql);
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
		return list;
	}
	/**
	 * 跳转到单个展会中的字段表
	 * 需要guid,bm,bmc
	 * @param request
	 * @param res
	 * @param guid
	 * @param bmc
	 * @param bm
	 * @throws Exception
	 */
	@RequestMapping(value = "findZhMenuList")
	public void findZhMenuList(HttpServletRequest request, HttpServletResponse res,String guid,String bmc,String bm) throws Exception{
		request.getRequestDispatcher("bzdk_Index.jsp?guid="+guid+"&bmc="+bmc+"&bm="+bm).forward(request, res);
	}

	/**
	 * 获取当前展会下的全部对应字段，得到是栏目_guid的表
	 * @param request
	 * @param res
	 * @param guid
	 * @param bmc
	 * @param bm
	 * @throws Exception
	 */
	@RequestMapping(value = "/findAllMenu", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String findAllMenu(HttpServletRequest request, HttpServletResponse res,Integer limit ,PageUtils page, String guid,String bmc,String bm) throws Exception{
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		List desList = new ArrayList();
		String bmDes=null;
		try {
			bmDes= bm+"_des_"+guid;
			if (limit==null) {
				limit=10;
			}
			page.setRows(limit);
			//查询分页信息
			
			String sqlJoint = " ORDER BY id desc limit ?,? ";
			String sqlWhere = "";
			String sql = "SELECT id,zdm,isform,guid,zdmc,formtypes,xs FROM "+bmDes+" WHERE 1=1 AND zdm NOT LIKE \"%_ZT\" AND zdm !=\"ZT\"  ";
			sql =sql+sqlWhere;
			sql =sql+sqlJoint;
			conn  =LinkSql.getConn();
			ps = LinkSql.Execute(conn,sql,role,bmDes);
			ps.setInt(1, page.getStart());
			ps.setInt(2, page.getRows());
			rs = ps.executeQuery();
	        ResultSetMetaData md = rs.getMetaData();
	        int columnCount = md.getColumnCount();
	        while (rs.next()) {
	            Map rowData = new HashMap();
	            for (int i = 1; i <= columnCount; i++) {
	            	if (md.getColumnName(i).equals("isform")) {
						if (Integer.parseInt(rs.getObject(i).toString())==1) {
							rowData.put(md.getColumnName(i), "必填项");
						}else{
							rowData.put(md.getColumnName(i), "非必填项");
						}
					}else{
						rowData.put(md.getColumnName(i), rs.getObject(i));
					}
	                
	            }
	            desList.add(rowData);
	        }
	        //计数
	        conn  =LinkSql.getConn();
			String sqlCountWhere = " AND zdm NOT LIKE \"%_ZT\" AND zdm !=\"ZT\"  ";
			String sqlCount = "SELECT count(id) FROM "+bmDes+" WHERE 1=1 "+sqlCountWhere;
			ps = LinkSql.Execute(conn,sqlCount,role,bmDes);
			rs = ps.executeQuery();
			md=null;
			columnCount=0;
			md = rs.getMetaData();
			String count =null;
	        columnCount = md.getColumnCount();
	        while (rs.next()) {
	            for (int i = 1; i <= columnCount; i++) {
	            	count = rs.getObject(i).toString();
	            }
	        }
			JSONArray json = JSONArray.fromObject(desList);
			String js = json.toString();
			String jso = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + js + "}";
			return jso;
		} catch (Exception e) {
			String jso = "{\"code\":404,\"msg\":\"\",\"count\":" + 0 + ",\"data\":" + null + "}";
			return jso;
		}
	}
	/**
	 * 添加某栏目字段
	 * @param model
	 * @param guid
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/doAdd")
	public void doAdd(HttpServletRequest request, HttpServletResponse res)
			throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		Enumeration pNames = request.getParameterNames();
		/**
		 * 前台参数
		 */
		String bm = request.getParameter("bm");
		String guid = request.getParameter("guid");
		String bmc = request.getParameter("bmc");
		String zdmc = request.getParameter("zdmc");
		String formtypes = request.getParameter("formtypes");
		String beizhu = request.getParameter("beizhu");
		int isform =Integer.parseInt(request.getParameter("isform"));
		String exam = request.getParameter("exam");//图片附件审核
		String newBmDes = bm+"_des_"+guid;
		String newBm = bm+"_"+guid;
		/**
		 * 获取当前表中字段名称
		 */
		String zdm = "";
		conn =LinkSql.getConn();
		String sqlByZdm ="select zdm from "+newBmDes+" ORDER BY id DESC LIMIT 1 ";
		ps = conn.prepareStatement(sqlByZdm);
		rs = ps.executeQuery();
		while(rs.next()){
			if (!rs.getObject("zdm").toString().equals("f1")) {
				zdm = "f1";
			}else{
				String zd = rs.getObject("zdm").toString();
				zd = zd.substring(1,zd.length());
				zdm =  "f"+(Integer.parseInt(zd)+1);
			}
		}
		//当需要审核时，存入表中一个状态字段；
		String examName = "";
		if (!exam.equals("不审核")) {
			conn.setAutoCommit(false);
			examName = zdm+"_ZT";
			
			String guidMenu = UUIDUtil.getUUID();
			String sql = "INSERT INTO " + newBmDes
					+ "(guid,zdm, beizhu,   "
					+ " types,zdmc,isform,formtypes,zlong,"
					+ "lisnum,xs,isshow,tips,initVal,isedit,"
					+ "width,jsdm,isselect,sqlrale,iskeep,"
					+ "fontfamilly,fontsize,marleft,martop,"
					+ " height, api,omit )VALUES(?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = LinkSql.Execute(conn,sql,role,newBmDes);
			String ztbmc = zdmc+"状态";
			ps.setString(1, guidMenu);
			ps.setString(2, examName);
			ps.setString(3, "");
			ps.setString(4, "varchar");
			ps.setString(5, ztbmc);
			ps.setInt(6, 1);
			ps.setString(7, "text");
			ps.setInt(8, 250);
			ps.setInt(9, 1);
			ps.setInt(10, 1);
			ps.setInt(11, 1);
			ps.setString(12, "请您输入");
			ps.setInt(13, 0);
			ps.setInt(14, 1);
			ps.setInt(15, 180);
			ps.setString(16, ".");
			ps.setInt(17, 0);
			ps.setString(18, "system,zcsystem,ybsystem");
			ps.setInt(19, 1);
			ps.setString(20, "宋体");
			ps.setInt(21, 10);
			ps.setInt(22, 1);
			ps.setInt(23, 1);
			ps.setInt(24, 1);
			ps.setString(25, ".");
			ps.setInt(26, 1);
			int flag = ps.executeUpdate();
			if (flag==1) {
				String sqlInsert = "ALTER TABLE  "+newBm+" add "+examName+" varchar(50) DEFAULT '未审核'";
				ps = conn.prepareStatement(sqlInsert);
				try {
					flag = ps.executeUpdate();
					conn.commit();
				} catch (Exception e) {
					flag = -404;// 列名已经存在
					request.getRequestDispatcher("bzdk_add.jsp?guid" + guid + "&flag=" + flag).forward(request, res);
					conn.rollback();
					connCreate.rollback();
				}
					
			}
		}
		
		
		String typesStr = null;
		switch (formtypes) {
		case "number":
			typesStr ="int";
			break;
		case "datetime":
			typesStr ="datetime";
			break;
		case "date":
			typesStr ="date";
			break;
	
		case "textarea":
			typesStr ="text";
			break;
		default:
			typesStr ="varchar";
			break;
		}
		String isformStr = null;
		int flag = 0;
		conn = LinkSql.getConn();
		connCreate = LinkSql.getConn();
		conn.setAutoCommit(false);
		connCreate.setAutoCommit(false);
		
		try{
			// 插入描述表
			String guidMenu = UUIDUtil.getUUID();
			String sql = "INSERT INTO " + newBmDes
					+ "(guid,zdmc,formtypes,isform,zdm,types,beizhu,    zlong,lisnum,xs,isshow,tips,initVal,isedit,width,jsdm,isselect,sqlrale,iskeep,fontfamilly,fontsize,marleft,martop, height, api,omit )VALUES(?, ?, ?, ?, ?, ?,?,    250, 1, 1, 1, '请您输入', 0, 1, 180, '.', 0, 'system,zcsystem,ybsystem', 1, '宋体', 10, 1, 1,  1, '.',1)";
			ps = LinkSql.Execute(conn,sql,role,newBmDes);
			ps.setString(1, guidMenu);
			ps.setString(2, zdmc);
			ps.setString(3, formtypes);
			ps.setInt(4, isform);
			ps.setString(5, zdm);
			ps.setString(6, typesStr);
			ps.setString(7, beizhu);
			flag = ps.executeUpdate();
			rs = conn.getMetaData().getTables(null, null, newBmDes, null);
			if (rs.next()) {
				int zlong = 250;
				switch (typesStr) {
				case "varchar":
					typesStr = typesStr + "(" + zlong + ")";
					break;
				case "int":
					typesStr = "int"+ "(" + zlong + ")";
					break;
				case "datetime":
					zlong = 0;
					break;
				case "text":
					zlong = 0;
					break;
				}
				if (isform == 1) {
					isformStr = " NOT NULL ";
				} else if (isform == 0) {
					isformStr = " ";
				}
				String sqlAdd = "ALTER TABLE " + newBm + " ADD " + zdm + " " + typesStr + isformStr + "";
				ps = LinkSql.Execute(connCreate,sqlAdd,role,newBm);
				flag = ps.executeUpdate();
				flag = 2;
				conn.commit();
				connCreate.commit();
				request.getRequestDispatcher("bzdk_Index.jsp?guid" + guid + "&flag=" + flag).forward(request, res);
			} else {
				conn.commit();
				request.getRequestDispatcher("toCreateTable").forward(request, res);
			}
		} catch (Exception e) {
			flag = -404;// 列名已经存在
			request.getRequestDispatcher("bzdk_add.jsp?guid" + guid + "&flag=" + flag).forward(request, res);
			conn.rollback();
			connCreate.rollback();
		}finally {
			ps.close();
			conn.close();
		}
	}
	/**
	 * 创建或修改描述表
	 * @param request
	 * @param res
	 * @param guid
	 * @throws Exception
	 */
	@RequestMapping("/toCreateTable")
	public void toCreateTable(HttpServletRequest request, HttpServletResponse res, String guid) throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		int flag = 0;
		String dataName = null;
		String zdm = null;
		int zlong = 0;
		int isform = 0;
		String isformStr = null;
		String types = null;
		String sqlJoint = "id INT AUTO_INCREMENT NOT NULL  PRIMARY KEY,guid varchar(128) NOT NULL,";
		String sqljoin = null;
		conn = LinkSql.getConn();
		dataName = Bmodel.findBmByGuId(guid);
		if (dataName.equals("bmodel")) {
			dataName = Bmodel.findSBmByGuId(guid);
		}
		String sql = "select zdm,types,zlong,isform"
				+ " from " + dataName + "_des" + " where guid= ?";
		ps =LinkSql.Execute(conn,sql,role,dataName + "_des");
		ps.setString(1, guid);
		rs = ps.executeQuery();
		while (rs.next()) {
			zdm = rs.getString(1);
			types = rs.getString(2);
			zlong = rs.getInt(3);
			isform = rs.getInt(4);
			switch (types) {
			case "varchar":
				types = types + "(" + zlong + ")";
				break;
			case "int":
				types = "char"+ "(" + zlong + ")";
				break;
			case "datetime":
				zlong = 0;
				break;
			case "text":
				zlong = 0;
				break;
			}
			if (isform == 1) {
				isformStr = " NOT NULL";
			} else {
				isformStr = " NULL ";
			}

			sqlJoint += "" + zdm + " " + types + isformStr + ",";
		}
		try {
			sqljoin = sqlJoint.substring(0, sqlJoint.length() - 1);
			StringBuilder insertSql = new StringBuilder("create table " + dataName + " (" + "" + sqljoin + "" + ")");
			conn = LinkSql.getConn();
			conn.setAutoCommit(false);
			ps = LinkSql.Execute(conn,insertSql.toString(),role,dataName);
			flag = ps.executeUpdate();
			conn.commit();
			flag=2;
			request.getRequestDispatcher("/bzdk_Index.jsp?guid" + guid + "&flag=" + flag).forward(request, res);
		} catch (Exception e) {
			conn.rollback();
			request.getRequestDispatcher("/bzdk_Index.jsp?guid" + guid + "&flag=" + flag).forward(request, res);
		}
	}
	
	/**
	 * 去修改页面，数据回显
	 * 字段表中回显修改表
	 * @param request
	 * @param res
	 * @param model
	 * @param zdm
	 * @param guid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toUpdate")
	public Object toUpdate(HttpServletRequest request, HttpServletResponse res,Integer zdId, String bm,String bmc, String guid)
			throws Exception {
		try {
			HttpSession session = request.getSession();
			String role = session.getAttribute("role").toString();
			String bmodelName = null;
			Map<String, Object> map = new TreeMap<String, Object>();
			conn = LinkSql.getConn();
			conn.setAutoCommit(false);
			String desName = bm + "_des_"+guid;
			String sqlUpdate = "SELECT * FROM " + desName + " WHERE id =?";
			ps =   LinkSql.Execute(conn,sqlUpdate,role,bmodelName);
			ps.setInt(1,zdId);
			rs = ps.executeQuery();
			ResultSetMetaData md = rs.getMetaData();
			int columnCount = md.getColumnCount();
			String zdm = null;
			while (rs.next()) {
			    for (int i = 1; i <= columnCount; i++) {
			    	zdm = rs.getObject("zdm").toString();
			        map.put(md.getColumnName(i), rs.getObject(i));
			    }
			}
			String sqlSerch  = "SELECT zdm FROM "+desName+" WHERE zdm = '"+zdm+"_ZT'";
			ps = conn.prepareStatement(sqlSerch);
			rs = ps.executeQuery();
			if (rs.next()) {
				 map.put("zdmzt", "true");
			}
			request.setAttribute("map", map);
		} catch (Exception e) {
			ps.close();
			conn.close();
		}
		return "bzdk_edit";
	}
	
	/**
	 * 做修改操作
	 * @param request
	 * @param res
	 * @param model
	 * @param zdm
	 * @param guid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doUpdate")
	@ResponseBody
	public Object doUpdate(HttpServletRequest request, HttpServletResponse res, Model model)
			throws Exception {
		try {
			HttpSession session = request.getSession();
			String role = session.getAttribute("role").toString();
			/**
			 * 前台参数
			 */
			String bm = request.getParameter("bm");
			String guid = request.getParameter("guid");
			Integer id = Integer.parseInt(request.getParameter("id"));
			String bmc = request.getParameter("bmc");
			String zdmc = request.getParameter("zdmc");
			String zdm =request.getParameter("zdm");
			String formtypes = request.getParameter("formtypes");
			int isform =Integer.parseInt(request.getParameter("isform"));
			String beizhu = request.getParameter("beizhu");
			String exam =request.getParameter("exam");//修改后的审核状态
			String zdmZT =request.getParameter("zdmZT");//修改之前的状态
			String newBmDes = bm+"_des_"+guid;
			String newBm= bm+"_"+guid;
			Integer flag=null;
			//判断当前状态是否需要审核
			if (!zdmZT.equals(exam)) {
				conn = LinkSql.getConn();
				conn.setAutoCommit(false);
				String zdmZt = zdm+"_ZT";
				if (exam.equals("审核")) {//如果修改前不等于修改后，判断修改后字段
					String sqlInsert = "ALTER TABLE  "+newBm+" add "+zdmZt+" varchar(50) DEFAULT '未审核'";
					ps = conn.prepareStatement(sqlInsert);
					flag = ps.executeUpdate();
					conn.commit();
					String guidMenu = UUIDUtil.getUUID();
					String sql = "INSERT INTO " + newBmDes
							+ "(guid,zdm, beizhu,   "
							+ " types,zdmc,isform,formtypes,zlong,"
							+ "lisnum,xs,isshow,tips,initVal,isedit,"
							+ "width,jsdm,isselect,sqlrale,iskeep,"
							+ "fontfamilly,fontsize,marleft,martop,"
							+ " height, api,omit )VALUES(?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					ps = LinkSql.Execute(conn,sql,role,newBmDes);
					String ztbmc = zdmc+"状态";
					ps.setString(1, guidMenu);
					ps.setString(2, zdmZt);
					ps.setString(3, "");
					ps.setString(4, "varchar");
					ps.setString(5, ztbmc);
					ps.setInt(6, 1);
					ps.setString(7, "text");
					ps.setInt(8, 250);
					ps.setInt(9, 1);
					ps.setInt(10, 1);
					ps.setInt(11, 1);
					ps.setString(12, "请您输入");
					ps.setInt(13, 0);
					ps.setInt(14, 1);
					ps.setInt(15, 180);
					ps.setString(16, ".");
					ps.setInt(17, 0);
					ps.setString(18, "system,zcsystem,ybsystem");
					ps.setInt(19, 1);
					ps.setString(20, "宋体");
					ps.setInt(21, 10);
					ps.setInt(22, 1);
					ps.setInt(23, 1);
					ps.setInt(24, 1);
					ps.setString(25, ".");
					ps.setInt(26, 1);
					flag = ps.executeUpdate();
					conn.commit();
				}else{//判断修改后为不审核
					String sqlDesDel = "ALTER TABLE "+newBm+" DROP COLUMN "+zdmZt+"";
					ps = conn.prepareStatement(sqlDesDel);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						conn.rollback();
					}
					String sqlDel = "delete from "+newBmDes+"  where zdm ='"+zdmZt+"'";
					ps = conn.prepareStatement(sqlDel);
					try {
						flag = ps.executeUpdate();
						conn.commit();
					} catch (Exception e) {
						conn.rollback();
					}
					
				}
			}
			
			String typesStr = null;
			switch (formtypes) {
			case "number":
				typesStr ="int";
				break;
			case "datetime":
				typesStr ="datetime";
				break;
			case "date":
				typesStr ="date";
				break;
		
			case "textarea":
				typesStr ="text";
				break;
			default:
				typesStr ="varchar";
				break;
			}
			conn = LinkSql.getConn();
			conn.setAutoCommit(false);
			// 修改描述表
			String sql = "UPDATE  " + newBmDes + " SET" 
					+ " zdmc=?,types=?,formtypes=?,isform=?,beizhu=? WHERE id = "+id;
			try {
				ps = LinkSql.Execute(conn,sql,role,newBmDes);
				ps.setString(1, zdmc);
				ps.setString(2, typesStr);
				ps.setString(3, formtypes);
				ps.setInt(4, isform);
				ps.setString(5, beizhu);
				flag = ps.executeUpdate();
				conn.commit();
				String sqlUpdate=null;
				//修改不为必填项 ALTER TABLE  bgxx_225f33663e0a4a7ba58d218d3a27368f MODIFY   f2 VARCHAR(200) DEFAULT NULL 
				if (isform==0) {
					sqlUpdate=" ALTER TABLE  "+newBm+" MODIFY   "+zdm+" VARCHAR(200) DEFAULT NULL";
				}else{
					sqlUpdate=" ALTER TABLE  "+newBm+" MODIFY   "+zdm+" VARCHAR(200)  NOT NULL";
				}
				ps = conn.prepareStatement(sqlUpdate);
				ps.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				e.printStackTrace();
				flag = 404;
				request.getRequestDispatcher("bzdk_Index.jsp?guid" + guid + "&flag=" + flag+"&bm="+bm+"&bmc"+bmc).forward(request, res);
				conn.rollback();
			}
			if (flag!=404) {
				request.getRequestDispatcher("bzdk_Index.jsp?guid" + guid + "&flag=" + flag+"&bm="+bm+"&bmc"+bmc).forward(request, res);
			}
		}catch(Exception e){
			System.out.println(e);
		}finally{
			rs.close();
			ps.close();
			conn.close();
		}
		return null;
	}
	/**
	 * 删除描述字段
	 * 前台：字段列表中进行删除
	 * @param model
	 * @param zdm
	 * @param guid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toDelete")
	@ResponseBody
	public Object toDelete(Model model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String role = session.getAttribute("role").toString();
		int flag = 0;
		String bm = request.getParameter("bm");
		String guid = request.getParameter("guid");
		String zdm = request.getParameter("zdm");
		String id = request.getParameter("id");
		String newBm =bm+"_"+guid;
		String newBmDes = bm+"_des_"+guid;
		conn = LinkSql.getConn();
		conn.setAutoCommit(false);
		String sql = "DELETE FROM " + newBmDes + " WHERE id= ?";
		ps = LinkSql.Execute(conn,sql,role,newBm);
		ps.setString(1, id);
		try {
			flag = ps.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			conn.rollback();
			flag = -404;
		}
		try {
			if (flag!=-404) {
				String sqlUpdate = "ALTER TABLE " + newBm + " DROP COLUMN " + zdm + "";
				conn = LinkSql.getConn();
				conn.setAutoCommit(false);
				ps = LinkSql.Execute(conn,sqlUpdate,role,newBmDes);
				flag = ps.executeUpdate();
				conn.commit();
				flag = 5;
			}
		} catch (Exception e) {
			flag = -404;
			conn.rollback();
		}
		
		String sqlSerch  = "SELECT zdm FROM "+newBmDes+" WHERE zdm = '"+zdm+"_ZT'";
		ps = conn.prepareStatement(sqlSerch);
		rs = ps.executeQuery();
		if (rs.next()) {
			String sqlDelZt = "DELETE FROM " + newBmDes + " WHERE zdm = '"+zdm+"_ZT'";
			ps = LinkSql.Execute(conn,sqlDelZt,role,newBm);
			try {
				flag = ps.executeUpdate();
				conn.commit();
				String sqlUpdate = "ALTER TABLE " + newBm + " DROP COLUMN " +zdm+"_ZT";
				conn = LinkSql.getConn();
				conn.setAutoCommit(false);
				ps = LinkSql.Execute(conn,sqlUpdate,role,newBmDes);
				flag = ps.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				flag = -404;
			}
		}
		
		
		return flag;
	}
}
