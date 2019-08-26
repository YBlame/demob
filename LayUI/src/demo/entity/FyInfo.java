package demo.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * @author BLAME
 *
 */
public class FyInfo {

	public String zhxx;// 展会信息

	public String zgh;// 展馆号

	public String zwh;// 展位号

	public Integer ZJ;// 总计

	public Integer ZNJ;// 滞纳金

	public Integer XJ;// 小计

	public List<XmInfo> xm ;// 项目详情
	
	public String FYXX;
	
	public Integer SGYJJE;//施工押金
	

	public String getFYXX() {
		return FYXX;
	}

	public void setFYXX(String fYXX) {
		FYXX = fYXX;
	}

	public String getZhxx() {
		return zhxx;
	}

	public void setZhxx(String zhxx) {
		this.zhxx = zhxx;
	}

	public String getZgh() {
		return zgh;
	}

	public void setZgh(String zgh) {
		this.zgh = zgh;
	}

	public String getZwh() {
		return zwh;
	}

	public void setZwh(String zwh) {
		this.zwh = zwh;
	}


	public Integer getZNJ() {
		return ZNJ;
	}

	public void setZNJ(Integer zNJ) {
		ZNJ = zNJ;
	}

	
	public List<XmInfo> getXm() {
		return xm;
	}

	public void setXm(List<XmInfo> xm) {
		this.xm = xm;
	}


	public FyInfo() {
		super();
	}

	public Integer getSGYJJE() {
		return SGYJJE;
	}

	public void setSGYJJE(Integer sGYJJE) {
		SGYJJE = sGYJJE;
	}

	public Integer getZJ() {
		return ZJ;
	}

	public void setZJ(Integer zJ) {
		ZJ = zJ;
	}

	public Integer getXJ() {
		return XJ;
	}

	public void setXJ(Integer xJ) {
		XJ = xJ;
	}

	public FyInfo(String zhxx, String zgh, String zwh, Integer zJ, Integer zNJ, Integer xJ, List<XmInfo> xm,
			String fYXX, Integer sGYJJE) {
		super();
		this.zhxx = zhxx;
		this.zgh = zgh;
		this.zwh = zwh;
		ZJ = zJ;
		ZNJ = zNJ;
		XJ = xJ;
		this.xm = xm;
		FYXX = fYXX;
		SGYJJE = sGYJJE;
	}


	


}
