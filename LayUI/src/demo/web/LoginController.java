package demo.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.dao.Bmodel;
import demo.tool.LinkSql;
import demo.tool.MD5;
import demo.tool.UUIDUtil;

/**
 * 登录页面
 * 
 * @author BLAME
 *
 */
@Controller
public class LoginController {

	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private List<Map<String, Object>> list;

	/**
	 * 去login页面
	 * 
	 * @param request
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/login")
	public String toLogin(HttpServletRequest request, HttpServletResponse res, String guid) throws Exception {
		System.out.println(guid);
		HttpSession session = request.getSession();
		session.setAttribute("ZCBH", guid);
		return "logins";
	}

	/**
	 * 去login页面
	 * 
	 * @param request
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin")
	public String srylogin(HttpServletRequest request, HttpServletResponse res) throws Exception {
		return "loginsSyr";
	}

	/**
	 * 用户登录方法， 以手机号和密码登录 判断其当前角色进入不同页面
	 * 
	 * @param request
	 * @param res
	 * @param phone
	 * @param password
	 * @throws Exception
	 */
	@RequestMapping(value = "loginIn")
	@ResponseBody
	public String loginIn(HttpServletRequest request, HttpServletResponse res, String sj, String mm) throws Exception {
		ResultSetMetaData md = null;
		HttpSession session =request.getSession();
		Object zcbh = session .getAttribute("ZCBH");
		list = new ArrayList<Map<String, Object>>();
		String returnVal = null;
		int columnCount = 0;
		conn = LinkSql.getConn();
		if(zcbh!=null&&!zcbh.equals("")){
			String role = "system";// 当前角色为开发者
			String tn = Bmodel.findBmByGuId("00c99009ec2d4cb883acc9ae24f73b6e");// 根据模型表中guid判断当前表名
			String pwd = MD5.GetMd5(mm);// MD5加密进行数据库判断
			String sqlWhere = " and sj=? and mm=? ";
			String sql = "select id, guid, NAME, SJ, EMAIL, MM, roleName, roleid, GSMC, BGDZ, ZT, ZW, WXH, YJDZ, SFZSMJ, CZ, FRXM, FRSJH, FRSFZ, FRZJ, YYZZ, FRSFZZ, SFZ  from "
					+ tn + " where 1=1  " + sqlWhere;
			try {
				ps = LinkSql.Execute(conn, sql, role, tn);
				ps.setString(1, sj);
				ps.setString(2, pwd);
				rs = ps.executeQuery();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			rs.last();
			int row = rs.getRow();
			if (row == 0) {
				returnVal = "loginLose";// 当登录失败
			} else {
				rs.previous();
				md = rs.getMetaData(); // 获得结果集结构信息,元数据
				columnCount = md.getColumnCount(); // 获得列数
				String ZT = null;
				String roleid = null;
				while (rs.next()) {
					Map<String, Object> rowData = new HashMap<String, Object>();
					ZT = rs.getObject("ZT").toString();
					roleid = rs.getObject("roleid").toString();
					if (!ZT.equals("通过")) {
						if (roleid.equals("1")) {
							returnVal = "loginStop";
						} else {
							for (int i = 1; i <= columnCount; i++) {
								rowData.put(md.getColumnName(i), rs.getObject(i));
								session.setAttribute(md.getColumnName(i), rs.getObject(i));
							}
							list.add(rowData);
							returnVal = "loginfinish";
						}

					} else {
						for (int i = 1; i <= columnCount; i++) {
							rowData.put(md.getColumnName(i), rs.getObject(i));
							session.setAttribute(md.getColumnName(i), rs.getObject(i));
						}
						list.add(rowData);
						returnVal = "loginfinish";
					}
				}
			}
		}else{
			returnVal = "isNot";
		}
		
		return returnVal;
	}

	/**
	 * 用户登录方法， 以手机号和密码登录 判断其当前角色进入不同页面
	 * 
	 * @param request
	 * @param res
	 * @param phone
	 * @param password
	 * @throws Exception
	 */
	@RequestMapping(value = "syrloginIn")
	@ResponseBody
	public String syrloginIn(HttpServletRequest request, HttpServletResponse res, String sj, String mm)
			throws Exception {
		ResultSetMetaData md = null;
		String returnVal = null;
		int columnCount = 0;
		conn = LinkSql.getConn();
		String role = "system";// 当前角色为开发者
		String tn = "syrzc";// 根据模型表中guid判断当前表名
		String pwd = MD5.GetMd5(mm);// MD5加密进行数据库判断
		String sqlWhere = " and sj=? and mm=? ";
		String sql = "select id, guid, NAME, SJ, EMAIL, MM, roleName, roleid, GSMC,GS  from " + tn + " where 1=1  "
				+ sqlWhere;
		try {
			ps = LinkSql.Execute(conn, sql, role, tn);
			ps.setString(1, sj);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rs.last();
		int row = rs.getRow();
		if (row == 0) {
			returnVal = "loginLose";// 当登录失败
		} else {
			rs.previous();
			md = rs.getMetaData(); // 获得结果集结构信息,元数据
			columnCount = md.getColumnCount(); // 获得列数
			HttpSession session = request.getSession();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					session.setAttribute(md.getColumnName(i), rs.getObject(i));
				}
				returnVal = "loginfinish";
			}
		}
		return returnVal;
	}

	@RequestMapping(value = "userOut")
	public String userOut(HttpServletRequest request, HttpServletResponse res) throws Exception {
		HttpSession session = request.getSession();
		Object role = session.getAttribute("roleid");
		String zcbh = (String) session.getAttribute("ZCBH");
		if (role == null) {
			return "redirect:login";
		}
		session.invalidate();
		System.out.println(role);
		if (role.toString().trim().equals("1")) {
			return "redirect:login?guid="+zcbh;
		} else {
			return "redirect:admin";
		}

	}

	// 搭建商注册
	@RequestMapping(value = "regBuilder")
	@ResponseBody
	public int regBuilder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int flag = 0;
		try {
			String guid = UUIDUtil.getUUID();
			String roleName = "搭建商";
			String lxr = request.getParameter("LXR");
			String sj = request.getParameter("SJ");
			String yx = request.getParameter("EMAIL");
			String dwmc = request.getParameter("DWMC");
			String dwdz = request.getParameter("DWDZ");
			String sqlAdd = "INSERT INTO USER (guid,name,sj,email,roleName,roleid,GSMC,BGDZ,ZT) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ? );";
			conn = LinkSql.getConn();
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sqlAdd);
			ps.setString(1, guid);
			ps.setString(2, lxr);
			ps.setString(3, sj);
			ps.setString(4, yx);
			ps.setString(5, roleName);
			ps.setString(6, "1");
			ps.setString(7, dwmc);
			ps.setString(8, dwdz);
			ps.setString(9, "未审核");
			flag = ps.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
		}
		return flag;

	}

}
