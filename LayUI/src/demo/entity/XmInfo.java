package demo.entity;

public class XmInfo {

	public String XMMC_DATA;// 项目名称

	public String XMDES_DATA;// 项目描述

	public Integer DJ;// 单价

	public Integer SL;// 数量

	public Integer HXJ;// 行小计

	public String getXMMC_DATA() {
		return XMMC_DATA;
	}

	public void setXMMC_DATA(String xMMC_DATA) {
		XMMC_DATA = xMMC_DATA;
	}

	public String getXMDES_DATA() {
		return XMDES_DATA;
	}

	public void setXMDES_DATA(String xMDES_DATA) {
		XMDES_DATA = xMDES_DATA;
	}

	public Integer getDJ() {
		return DJ;
	}

	public void setDJ(Integer dJ) {
		DJ = dJ;
	}

	public Integer getSL() {
		return SL;
	}

	public void setSL(Integer sL) {
		SL = sL;
	}

	public Integer getHXJ() {
		return HXJ;
	}

	public void setHXJ(Integer hXJ) {
		HXJ = hXJ;
	}

	public XmInfo(String xMMC_DATA, String xMDES_DATA, Integer dJ, Integer sL, Integer hXJ) {
		super();
		XMMC_DATA = xMMC_DATA;
		XMDES_DATA = xMDES_DATA;
		DJ = dJ;
		SL = sL;
		HXJ = hXJ;
	}

	public XmInfo() {
		super();
	}

}