package demo.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import demo.dao.Bmodel;
import demo.dao.DjMenu;
import demo.tool.LinkSql;
import demo.tool.PageUtils;
import demo.tool.UUIDUtil;
import net.sf.json.JSONObject;

/**
 * 展会Controller
 * 
 * @author BLAME
 *
 */
@Controller
@RequestMapping(value = "dj")
public class DjController {
	private PreparedStatement ps;
	private ResultSet rs;
	private Connection conn;
	private List<Map<String, Object>> list;

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
		String sqlFindRole = "select guid from role where id = ?";
		ps= null;
		ps = conn.prepareStatement(sqlFindRole);
		ps.setString(1, roleId);
		rs = ps.executeQuery();
		while (rs.next()) {
			roleGuid = rs.getString("guid");
		}
		String[] menuGuid = DjMenu.returnMenu(session, roleGuid, zhxxGuid);
		String tn = Bmodel.findBmByGuId("73c2efa3c34f4904ae0eee4ab31dfa79");
		String sql = "select guid,id,name,zhxx_menu,bmc,bm from " + tn + " where zhxx_menu = ? ";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, zhxxGuid);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			if(menuGuid!=null){
				for (int j = 0; j < menuGuid.length; j++) {
					if (!rs.getObject("guid").equals(menuGuid[j])) {
						
					}else{
						Map<String, Object> rowData = new HashMap<String, Object>();
						for (int i = 1; i <= columnCount; i++) {
							rowData.put(md.getColumnName(i), rs.getObject(i));
						}
						desList.add(rowData);
					}
					
				}
			}
			
		}
		return desList;
	}

	@RequestMapping(value = "findSonMenu")
	@ResponseBody
	public List<Map<String, Object>> findSonMenu(HttpServletRequest request, HttpServletResponse res,
			Integer parentMenu,String zhxxGuid) throws Exception {
		HttpSession session = request.getSession();
		String roleGuid = session.getAttribute("guid").toString();
		conn = LinkSql.getConn();
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		String tn = Bmodel.findBmByGuId("73c2efa3c34f4904ae0eee4ab31dfa79");
		String sql = "select guid,id,name,bmc,bm,zhxx_menu from " + tn + " where  parentMenu = ?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, parentMenu);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		
		String[] menuGuid =DjMenu.returnMenu(session, roleGuid, zhxxGuid);
		while (rs.next()) {
			for (int j = 0; j < menuGuid.length; j++) {
				if (!rs.getObject("guid").equals(menuGuid[j])) {
					
				}else{
					Map<String, Object> rowData = new HashMap<String, Object>();
					for (int i = 1; i <= columnCount; i++) {
						rowData.put(md.getColumnName(i), rs.getObject(i));
					}
					desList.add(rowData);
				}
				
			}
		}
		return desList;
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
	public Object findDoc(PageUtils page, HttpServletRequest request, HttpServletResponse res, String guid, Integer num,
			Integer limit) throws Exception {
		try {
			HttpSession session = request.getSession();
			final String user = (String) session.getAttribute("user");
			final String role = (String) session.getAttribute("role");
			list = new ArrayList<Map<String, Object>>();
			String tn = null;
			ResultSetMetaData md = null;
			int columnCount = 0;
			String destn = null;
			String sqlRale = null;
			tn = Bmodel.findBmByGuId(guid);// 描述表
			destn = tn + "_des";
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

	@RequestMapping(value = "SendSmsCaptchaForRegister")
	@ResponseBody
	public JSONObject SendSmsCaptchaForRegister(String phoneNumber) throws Exception {
		String sql = "SELECT ID FROM user WHERE SJ=?";
		conn = LinkSql.getConn();
		ps = conn.prepareStatement(sql);
		ps.setString(1, phoneNumber);
		rs = ps.executeQuery();
		JSONObject json = new JSONObject();
		if (rs.next()) {
			json.put("msg", "该手机号已经被注册");
			json.put("success", false);
			return json;
		} else {
			// 发送验证码，并记录
			Boolean result = SendSmsCaptcha(phoneNumber, "REG");
			if (result) {
				json.put("msg", "发送成功");
				json.put("success", true);
				return json;
			} else {
				json.put("msg", "发送失败");
				json.put("success", false);
				return json;

			}

		}
	}


	private Boolean SendSmsCaptcha(String phoneNumber, String CaptchaType) throws Exception {
		String smsCaptcha = RandomCode();
		String smsContent = String.format("您的验证码为 %s ，请在五分钟之内使用，该验证码不可重复使用。", smsCaptcha);
		String result = NewWebSmsUtil.send(phoneNumber, smsContent, "", "");
		int res = result.indexOf("<result>");
		char index = result.charAt(res + 8);

		if (Character.toString(index).equals("0")) {
			String sql = "SELECT ID FROM YZMK WHERE PHONE = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, phoneNumber);
			try {// alt+shift+z
				rs = ps.executeQuery();// 查找记录
			} catch (Exception e) {
				e.printStackTrace();
			}
			String id = null;
			if (rs.next()) {
				id = rs.getString("ID");
			}
			int falg = 0;
			if (id != null) {
				sql = "UPDATE YZMK SET YZM=?, SJ=now() WHERE PHONE=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, smsCaptcha);
				ps.setString(2, phoneNumber);
				try {
					falg = ps.executeUpdate();
				} catch (Exception e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			} else {
				String guid = UUIDUtil.getUUID();
				sql = "INSERT INTO YZMK (PHONE,YZM,SJ,guid) VALUES (?,?,now(),?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, phoneNumber);
				ps.setString(2, smsCaptcha);
				ps.setString(3, guid);
				falg = ps.executeUpdate();
			}
			if (falg == 1) {
				return true;
			} else {
				return false;
			}

		} else {
			return true;
		}

	}

	//判断验证码是不是正确
		@RequestMapping(value = "ForRegister")
		@ResponseBody
		public Object ForRegister(String phoneNumber,String phoneyzm) throws Exception {
			String flag="false";
			String sql = "SELECT sj FROM YZMK WHERE PHONE=?";
			conn = LinkSql.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1, phoneNumber);
			rs = ps.executeQuery();
			JSONObject json = new JSONObject();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			if (rs.next()) {					
				String sj = rs.getObject("sj").toString();			
		        //获取String类型的时间
		        String createdate = sdf.format(date);
				Date datanow = df.parse(createdate);  
				Date time = df.parse(sj);  
			    long diff = datanow.getTime() - time.getTime();
			    long days = diff / (1000 * 60 * 60 * 24); 
			    long hours = (diff-days*(1000 * 60 * 60 * 24))/(1000* 60 * 60);
				long minutes = (diff-days*(1000 * 60 * 60 * 24)-hours*(1000* 60 * 60))/(1000* 60); 
				System.out.println(diff);
				System.out.println(days);
				System.out.println(hours);
				System.out.println(minutes);
				if(minutes>10){
					json.put("msg", "验证码已超时，请重新发送!");
					json.put("success", false);
					return json;				
				}else{
					sql = "SELECT ID FROM YZMK WHERE PHONE=? AND YZM=?";
					conn = LinkSql.getConn();
					ps = conn.prepareStatement(sql);
					ps.setString(1, phoneNumber);
					ps.setString(2, phoneyzm);
					rs = ps.executeQuery();
					json = new JSONObject();
					if (rs.next()) {
						json.put("success", true);			
						return json;
					} else {						
						json.put("msg", "手机验证码不正确");
						json.put("success", false);
						return json;
					}
				}
				
			} else {						
				json.put("msg", "手机验证码不正确");
				json.put("success", false);
				return json;
			}					
		}
	
	public String RandomCode() {
		String code = String.valueOf((int) ((Math.random() * 9 + 1) * 100000));
		return code;
	}

	// 获取展馆
	@RequestMapping(value = "findZgh")
	@ResponseBody
	public List<Map<String, Object>> findZgh(String zhguid) throws Exception {
		conn = LinkSql.getConn();
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		String sql = "select * from zggl where zhguid = ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, zhguid);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i));
			}
			desList.add(rowData);
		}
		return desList;
	}

	// 获取展位
	@RequestMapping(value = "findZwh")
	@ResponseBody
	public List<Map<String, Object>> findZwh(String ghbh) throws Exception {
		conn = LinkSql.getConn();
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		String sql = "select * from zwgl where ghmc = ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, ghbh.trim());
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
	 * 查看当前搭建商是否存在报馆信息
	 * @param request
	 * @param res
	 * @param zhxxGuid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("findBgxxLen")
	@ResponseBody
	public String findBgxxLen(HttpServletRequest request, HttpServletResponse res, String zhxxGuid,String bm,String bmc)
			throws Exception {
			HttpSession session =request.getSession();
			String guid= (String) session.getAttribute("guid");
			String flag = "";
			conn = LinkSql.getConn();
			String tn  = bm+"_"+zhxxGuid;
			String sql ="select guid from "+tn+" where DJSBH='"+guid+"' ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = "exist";
			}else{
				flag = "notExist";
			}
			return flag;
		
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
	@RequestMapping("findXxtz")
	@ResponseBody
	public List<Map<String, Object>> findXxtz(HttpServletRequest request, HttpServletResponse res, String zhxxGuid)
			throws Exception {
		List<Map<String, Object>> desList;
		desList = new ArrayList<Map<String, Object>>();
		conn = LinkSql.getConn();
		String sql = " SELECT  id,NR,RQ FROM xxtz where zhGuid = ? ORDER BY RQ DESC LIMIT 1 ";
		conn = LinkSql.getConn();
		ps = LinkSql.Execute(conn, sql, "1", "xxtz");
		ps.setString(1, zhxxGuid);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				if (md.getColumnName(i).equals("RQ")) {
					rowData.put(md.getColumnName(i), rs.getDate(i).toString());
				} else {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
			}
			desList.add(rowData);
		}
		return desList;
	}

	/**
	 * 获取当前登录用户的个人及公司信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("findInfo")
	@ResponseBody
	public List<Map<String, Object>> findInfo(HttpServletRequest request, HttpServletResponse res, String zhxxGuid)
			throws Exception {
		List<Map<String, Object>> desList = new ArrayList<Map<String, Object>>();
		HttpSession session = request.getSession();
		String guid = session.getAttribute("guid").toString();
		conn = LinkSql.getConn();
		String sql = "select guid, NAME, SJ, EMAIL, MM, roleName, roleid, GSMC, BGDZ, ZT, ZW, WXH, YJDZ, SFZSMJ, CZ, FRXM, FRSJH, FRSFZ, FRZJ, YYZZ, FRSFZZ, SFZ, SHYJ, SHR, SHRQ from user where guid= ?";
		conn = LinkSql.getConn();
		ps = LinkSql.Execute(conn, sql, "1", "user");
		ps.setString(1, guid);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i));
			}
			desList.add(rowData);
		}
		return desList;
	}

	@RequestMapping("GetFybzMc")
	@ResponseBody
	public List<Map<String, Object>> GetFybzMc(HttpServletRequest request, HttpServletResponse res) throws Exception {
		List<Map<String, Object>> mcList = new ArrayList<Map<String, Object>>();
		conn = LinkSql.getConn();
		String tn = "FYBZ";
		String sql = "SELECT ID,XMMC FROM FYBZ";
		conn = LinkSql.getConn();
		ps = LinkSql.Execute(conn, sql, "1", tn);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i).toString().trim());
			}
			mcList.add(rowData);
		}
		return mcList;
	}

	@RequestMapping("GetXmDesByName")
	@ResponseBody
	public List<Map<String, Object>> GetXmDesByName(HttpServletRequest request, HttpServletResponse res, String xmmc)
			throws Exception {
		List<Map<String, Object>> msList = new ArrayList<Map<String, Object>>();
		conn = LinkSql.getConn();
		String tn = "FYBZ";
		String sql = "SELECT ID,XMMS,FY FROM FYBZ WHERE XMMC=?";
		conn = LinkSql.getConn();
		ps = LinkSql.Execute(conn, sql, "1", tn);
		ps.setString(1, xmmc);
		rs = ps.executeQuery();
		ResultSetMetaData md = rs.getMetaData();
		int columnCount = md.getColumnCount();
		while (rs.next()) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i).toString().trim());
			}
			msList.add(rowData);
		}
		return msList;
	}

}
