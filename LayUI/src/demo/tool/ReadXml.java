package demo.tool;

import org.w3c.dom.*;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.*;
import java.io.*;

public class ReadXml {
	// Document可以看作是XML在内存中的一个镜像,那么一旦获取这个Document 就意味着可以通过对
	// 内存的操作来实现对XML的操作,首先第一步获取XML相关的Document
	private Document doc = null;

	public void init(String xmlFile) throws Exception {
		// 很明显该类是一个单例,先获取产生DocumentBuilder工厂
		// 的工厂,在通过这个工厂产生一个DocumentBuilder,
		// DocumentBuilder就是用来产生Document的
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		// 这个Document就是一个XML文件在内存中的镜像
		doc = db.parse(new File(xmlFile));
	}

	// 该方法负责把XML文件的内容显示出来
	public String viewXML(String xmlFile) throws Exception {
		this.init(xmlFile);
		NodeList nodeList = doc.getElementsByTagName("person");
		Node fatherNode = nodeList.item(0);
		NodeList childNodes = fatherNode.getChildNodes();
		String URL = null;
		for (int j = 0; j < childNodes.getLength(); j++) {
			Node childNode = childNodes.item(j);
			// 如果这个节点属于Element ,再进行取值
			if (childNode instanceof Element) {
				URL = childNode.getFirstChild().getNodeValue();
			}
		}
		return URL;
	}
	public static String urlPath(HttpServletRequest request) throws Exception {
		ReadXml parse = new ReadXml();
		// 我的XML文件,放置在项目下
		String url = parse.viewXML(request.getRealPath("/url.xml"));
		return url;
	}
	
	public static void main(String[] args) throws Exception {
		ReadXml parse = new ReadXml();
		// 我的XML文件,放置在项目下
		String url = parse.viewXML("URL.xml");
		System.out.println(url);
	}
}
