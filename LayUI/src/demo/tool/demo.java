package demo.tool;

import javax.servlet.http.HttpServletRequest;

public class demo {
	public static void main(String[] args, HttpServletRequest request) {
		String basePath = request.getSession().getServletContext().getRealPath("/");
		System.out.println(basePath);
	}
}
