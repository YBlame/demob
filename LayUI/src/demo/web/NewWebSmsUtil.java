package demo.web;

import java.net.URL;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import org.codehaus.xfire.client.Client;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class NewWebSmsUtil {

	// ############################此部分参数需要修改############################
	public static String userName = "21732"; // 用户名
	public static String password = "HR)GEm5$"; // 密码
	public static String phone = "17600236100"; // 要发送的手机号码
	public static String content = "您好，您的验证码为123456"; // 短信内容
	public static String sign = "【慧展软件】"; // 短信内容
	public static String subcode ="";
	public static String sendtime ="";
	public static String url = "http://new.yxuntong.com/emmpdata/services/sms?wsdl";
	
	
	public static Client client = null;
	// ############################此部分参数需要修改############################
	
	static{
		try {
			client = new Client(new URL(url));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		try{
			String resp = null;
			System.out.println("*************发送短信*************");
			Date d = new Date();
		     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		     String TimeStr=sdf.format(d);
			resp = send(phone,content,subcode,"");// new Date());
			System.out.println(resp);
			
			/*System.out.println("*************获取状态报告*************");
			resp = getReport(userName, password);
			System.out.println(resp);
			
			System.out.println("*************获取上行*************");
			resp = getSms(userName,password);
			System.out.println(resp);
			
			System.out.println("*************获取金额*************");
			resp = getBalance(userName,password);
			System.out.println(resp);
			*/
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
		 * 方法描述
		 * 发送短信方法使用document 对象方法封装XML字符串
		 * @param userName
		 * @param password
		 * @param phones
		 * @param content
		 * @param sign
		 * @param subcode
		 * @param sendtime
		 * @throws Exception 
	 */
	public static String send(String phones,String content,String subcode,String sendtime) throws Exception {
		Map<String, String> params = new LinkedHashMap<String, String>();
		String message=DocXml(userName, MD5Encode(password),phones,content,sign,subcode,sendtime);
		params.put("message", message);
		Object[] objects = client.invoke("submit",new Object[] {message,"",""});  
		return objects[0].toString();
	}

	/**
		 * 方法描述
		 * 状态报告
		 * @throws Exception 
	 */
	public static String getReport(String userName,String password) throws Exception {
		Map<String, String> params = new LinkedHashMap<String, String>();
		String message = "<?xml version='1.0' encoding='UTF-8'?><message>"
				+ "<account>" + userName + "</account>" + "<password>"
				+ MD5Encode(password) + "</password>"
				+ "<msgid></msgid><phone></phone></message>";
		params.put("message", message);
		Object[] objects = client.invoke("report",new Object[] {message,"","",""});  
		return objects[0].toString();
	}

	/**
		 * 方法描述
		 * 查询余额
		 * @throws Exception 
	 */
	public static String getBalance(String userName,String password) throws Exception {
		Map<String, String> params = new LinkedHashMap<String, String>();
		String message = "<?xml version='1.0' encoding='UTF-8'?><message><account>"
				+ userName
				+ "</account>"
				+ "<password>"
				+ MD5Encode(password)
				+ "</password></message>";
		params.put("message", message);
		Object[] objects = client.invoke("balance",new Object[] {message,"",""});  
		return objects[0].toString();
	}

	/**
		 * 方法描述
		 * 获取上行
		 * @throws Exception 
	 */
	public static String getSms(String userName,String password) throws Exception {
		Map<String, String> params = new LinkedHashMap<String, String>();
		String message = "<?xml version='1.0' encoding='UTF-8'?><message><account>"
				+ userName
				+ "</account>"
				+ "<password>"
				+ MD5Encode(password)
				+ "</password></message>";
		params.put("message", message);
		Object[] objects = client.invoke("deliver",new Object[] {message,"","",""});  
		return objects[0].toString();
	}
	
	public static String getKeyword() throws Exception {
		Object[] objects = client.invoke("keyword",new Object[] {});  
		return objects[0].toString();
	}
	
	/**
	 * 使用document 对象封装XML
	 * @param userName
	 * @param pwd
	 * @param id
	 * @param phone
	 * @param contents
	 * @param sign
	 * @param subcode
	 * @param sendtime
	 * @return
	 */
	private static String DocXml(String userName,String pwd,String  phone,String contents,String msgid,String subcode,String sendtime) {
		Document doc = DocumentHelper.createDocument();
		doc.setXMLEncoding("UTF-8");
		Element message = doc.addElement("response");
		Element account = message.addElement("account");
		account.setText(userName);
		Element password = message.addElement("password");
		password.setText(pwd);
		Element phones = message.addElement("phones");
		phones.setText(phone);
		Element content = message.addElement("content");
		content.setText(contents);
		Element sign1 = message.addElement("sign");
		sign1.setText(sign);
		Element subcode1 = message.addElement("subcode");
		subcode1.setText(subcode);
		Element sendtime1 = message.addElement("sendtime");
		sendtime1.setText(sendtime);
		return message.asXML();
	}
	
	// MD5加密函数
	public static String MD5Encode(String sourceString) {
		String resultString = null;
		try {
			resultString = new String(sourceString);
			MessageDigest md = MessageDigest.getInstance("MD5");
			resultString = byte2hexString(md.digest(resultString.getBytes()));
		} catch (Exception ex) {
		}
		return resultString;
	}

	private static final String byte2hexString(byte[] bytes) {
		StringBuffer bf = new StringBuffer(bytes.length * 2);
		for (int i = 0; i < bytes.length; i++) {
			if ((bytes[i] & 0xff) < 0x10) {
				bf.append("0");
			}
			bf.append(Long.toString(bytes[i] & 0xff, 16));
		}
		return bf.toString();
	}
}
