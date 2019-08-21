package demo.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import javax.annotation.Resource;
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
import demo.tool.UUIDUtil;
import net.sf.json.JSONArray;
/**
 * 首页Controller
 * @author BLAME
 *
 */
@Controller
public class IndexController {
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private Connection conn = null;
	private List<Map<String, Object>> list;
	
	/**
	 * 去index页面
	 * @param request
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toIndex")
	public String toIndex(HttpServletRequest request, HttpServletResponse res) throws Exception {
		HttpSession session = request.getSession();
		/*final String user = "zb123456";
		final String role = "ZB";
		session.setAttribute("user", user);
		session.setAttribute("role", role);
		return "index";*/
		if (session.getAttribute("NAME")==null) {
			return "redirect:login";
		}
		String user = session.getAttribute("NAME").toString();
		String role = session.getAttribute("roleName").toString();
		Integer roleId = Integer.parseInt(session.getAttribute("roleid").toString());
		session.setAttribute("user", user);
		session.setAttribute("role", role);
		
		String tn = Bmodel.findBmByGuId("acc0357dd46e42129f534f4820781a5a");//根据guid获取角色表名称
		String sqlWhere = " and id= ?";
		String sql = "SELECT guid FROM "+tn+" WHERE 1=1 ";
		sql =sql+sqlWhere;
		conn  =LinkSql.getConn();
		ps = LinkSql.Execute(conn,sql,role,tn);
		ps.setInt(1, roleId);
		rs = ps.executeQuery();
		String guid = null;
		while(rs.next()){
			guid = rs.getString(1);
		}
		if(guid.equals("a666df5383f345868cc5b46a257da351")){//当前角色为系统管理员(开发人员)
			return "index";
		}else if(guid.equals("97e115aba8124896833070694701d96b")){//主场管理员
			return "zhxx/adminIndex";
		}else if(guid.trim().equals("abf42d7f52cc48389702be4bfcde3e20")){
			return "DJ/djIndex";
		}else{
			return "zhxx/gzry_Index";
		}
	}
	@RequestMapping(value = "findZhxx")
	public void findZhxx(HttpServletRequest request, HttpServletResponse res) throws Exception{
		String guid = "a65611e7bc194941a7050bb14000967d";
		String tn = Bmodel.findBmByGuId(guid);
		String bmc = Bmodel.findBmcBybm(tn);
		request.getRequestDispatcher("/zhxxList.jsp?guid="+ guid+"&bmc="+bmc).forward(request, res);
	}
	
	@RequestMapping(value = "userInsert")
	@ResponseBody
	public Integer userInsert(HttpServletRequest request, HttpServletResponse res) throws Exception{
		Enumeration pNames = request.getParameterNames();
		HttpSession session = request.getSession();
		String zcbh = session.getAttribute("ZCBH").toString().trim();
		Integer flag =null;
		if(zcbh!=null&&!zcbh.equals("")){
			String bmodelName = null;
			String guid= "00c99009ec2d4cb883acc9ae24f73b6e";
			String[] v = new String[18];
			String name =null;
			conn = LinkSql.getConn();
			conn.setAutoCommit(false);
			bmodelName = Bmodel.findBmByGuId(guid);
			guid = UUIDUtil.getUUID();
			String sql = "INSERT INTO " + bmodelName + ""
					+ "(sj,mm,NAME,ZW,SFZ,WXH,EMAIL,YJDZ,SFZSMJ,GSMC,CZ,BGDZ,FRXM,FRSJH,FRSFZ,FRZJ,YYZZ,FRSFZZ,guid,ZT,roleName,roleid,SHRQ,RQ,GS)  "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,null,NOW(),'"+zcbh+"')";
			ps = conn.prepareStatement(sql);
			for (int e = 1; e <= v.length; e++) {
				while (pNames.hasMoreElements()) {
					name = (String) pNames.nextElement();
					if (name.equals("mm")) {
						String mm = MD5.GetMd5(request.getParameter(name));
						ps.setString(e, mm);
					}else if (request.getParameter(name)==null) {
						ps.setString(e, "");
					}else{
						ps.setString(e, request.getParameter(name));
					}
					
					break;
				}
			}
			ps.setString(19,guid );
			ps.setString(20, "未审核");
			ps.setString(21, "搭建商");
			ps.setString(22, "1");
			try {
				flag = ps.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				e.printStackTrace();
				conn.rollback();
				flag=-404;
			}
		}else{
			flag =-500;
			return flag;
		}
		
		return flag ;
	}
	
	
	
}
