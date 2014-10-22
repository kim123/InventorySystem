package com.is.action;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.is.model.EloadDailyBalance;
import com.is.model.EloadDailySales;
import com.is.model.EloadPrices;
import com.is.model.Operators;
import com.is.model.Page;
import com.is.model.UserStatus;
import com.is.service.impl.EloadDailyServiceImpl;
import com.is.service.interfaze.ELoadDailyService;
import com.is.utilities.Constants;
import com.is.utilities.DateUtility;
import com.is.utilities.SessionUtility;

@SuppressWarnings("serial")
public class EloadDailyAction extends BaseAction{
	
	private static ELoadDailyService eloadDailyService;
	//private static UserService userService;
	
	static {
		if (eloadDailyService==null) {
			eloadDailyService = new EloadDailyServiceImpl();
		}
		//if (userService==null) {
		//	userService = new UserServiceImpl();
		//}
	}
	
	private String searchDate;
	private Page pageEloadBalance;
	private int balanceUpdateType;
	private String eloadType;
	private String additionalBalance;
	private int balanceId;
	private Page pageEloadSalesSmart;
	private Page pageEloadSalesGlobe;
	private Page pageEloadSalesSun;
	private String updatedBy; // for the Eload Daily Sales
	private Timestamp updatedDate; // for the Eload Daily Sales
	private int priceListType;
	private int priceId;
	private Page pageEloadPriceSmart;
	private Page pageEloadPriceGlobe;
	private Page pageEloadPriceSun;
	private int productId;
	private double smartTotal;
	private double globeTotal;
	private double sunTotal;
	private String operatorPriceStr;
	private String operatorRetailStr;
	private String operatorMarkupStr;
	private String priceStatus;
	private String price;
	private String retailPrice;
	private String markupPrice;
	private EloadPrices eloadPrice;
	
	// predefined quantity start
	private String quantity1;
	private String quantity2;
	private String quantity3;
	private String quantity4;
	private String quantity5;
	private String quantity6;
	private String quantity7;
	private String quantity8;
	private String quantity9;
	private String quantity10;
	private String quantity11;
	private String quantity12;
	private String quantity13;
	private String quantity14;
	private String quantity15;
	private String quantity16;
	private String quantity17;
	private String quantity18;
	private String quantity19;
	private String quantity20;
	private String quantity21;
	private String quantity22;
	private String quantity23;
	private String quantity24;
	private String quantity25;
	private String quantity26;
	private String quantity27;
	private String quantity28;
	private String quantity29;
	private String quantity30;
	private String quantity31;
	private String quantity32;
	private String quantity33;
	private String quantity34;
	private String quantity35;
	// predefined quantity end
	
	public List<EloadPrices> eloadProductIds = eloadDailyService.getEloadProductIds();
	public List<Operators> operatorsPrice = Operators.getOperators();
	public List<Operators> operatorsRetailPrice = Operators.getOperators();
	public List<Operators> operatorsMarkupPrice = Operators.getOperators();
	public List<UserStatus> userStatuses = UserStatus.getUserStatusList();
	
	public String searchEloadDailyBalances(){
		setMenuActive("9");
		if (StringUtils.isEmpty(searchDate)) {
			setSearchDate(DateUtility.getSimpleCurrentDateStr()); 
		}
		if (searchDate.equals(DateUtility.getSimpleCurrentDateStr())) {
			balanceUpdateType = 1;
		} else {
			balanceUpdateType = 0;
		}
		
		pageEloadBalance = eloadDailyService.viewEloadDailyBalanceLogs(searchDate);

		return SUCCESS;
	}
	
	public String updateEloadAdditionalBalance(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		EloadDailyBalance balance = new EloadDailyBalance();
		balance.setCreaetdBy(SessionUtility.getUser().getUserName());
		balance.setEloadDailyBalanceId(balanceId);
		balance.setAdditionalBalance(new BigDecimal(additionalBalance));
		String eloadType2 = "";
		if (eloadType.equals("SMART")) {
			eloadType2 = ELoadDailyService.SMART;
		} else if (eloadType.equals("GLOBE")) {
			eloadType2 = ELoadDailyService.GLOBE;
		} else if (eloadType.equals("SUN")) {
			eloadType2 = ELoadDailyService.SUN;
		}
		String result = eloadDailyService.updateEloadDailyBalance(eloadType2,balance);
		try {
			if (result==null) {
				json.put(Constants.SUCCESS, true);
			} else if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public String searchEloadDailySales(){
		setMenuActive("10");
		if (StringUtils.isEmpty(searchDate)) {
			setSearchDate(DateUtility.getSimpleCurrentDateStr()); 
		}

		if (searchDate.equals(DateUtility.getSimpleCurrentDateStr())) {
			priceListType = ELoadDailyService.ENABLED_PRICE_LIST_TYPE;
		} else {
			priceListType = ELoadDailyService.COMPLETE_PRICE_LIST_TYPE;
		}
		
		pageEloadSalesSmart = eloadDailyService.viewEloadDailySalesSmart(searchDate, priceListType);
		pageEloadSalesGlobe = eloadDailyService.viewEloadDailySalesGlobe(searchDate, priceListType);		
		pageEloadSalesSun = eloadDailyService.viewEloadDailySalesSun(searchDate, priceListType);
		
		List<EloadDailySales> temp = (List<EloadDailySales>) pageEloadSalesSmart.getContents();
		List<EloadDailySales> temp2 = (List<EloadDailySales>) pageEloadSalesGlobe.getContents();
		List<EloadDailySales> temp3 = (List<EloadDailySales>) pageEloadSalesSun.getContents();
		smartTotal = 0.0;
		globeTotal = 0.0;
		sunTotal = 0.0;
		
		for (EloadDailySales e : temp) {
			smartTotal = smartTotal + e.getTotal().doubleValue();
		}
		
		for (EloadDailySales e : temp2) {
			globeTotal = globeTotal + e.getTotal().doubleValue();
		}
		
		for (EloadDailySales e : temp3) {
			sunTotal = sunTotal + e.getTotal().doubleValue();
		}

		updatedBy = temp.get(0).getUpdatedBy();
		updatedDate = temp.get(0).getUpdatedDate();
		
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	public String addEloadDailySales(){
		searchEloadDailySales();
		List<String> quantityArray = getQuantityArray();
		List<EloadDailySales> temp = (List<EloadDailySales>) pageEloadSalesSmart.getContents();
		List<EloadDailySales> temp2 = (List<EloadDailySales>) pageEloadSalesGlobe.getContents();
		List<EloadDailySales> temp3 = (List<EloadDailySales>) pageEloadSalesSun.getContents();

		String[] tempQuantity = new String[temp.size()];
		for (int i = 0; i < tempQuantity.length; i++) {
			String q = quantityArray.get(i);
			quantityArray.remove(i);
			tempQuantity[i] = q;
		}
		
		for (int i = 0; i < temp.size(); i++) {
			if (StringUtils.isNotBlank(tempQuantity[i])) {
				EloadDailySales e = temp.get(i);
				eloadDailyService.addEloadDailySales(Constants.ELOAD_SMART_PRODUCT_ID, e.getPriceId(), Integer.parseInt(tempQuantity[i]), SessionUtility.getUser().getUserName());
			}
		}
		
		
		String[] temp2Quantity = new String[temp2.size()];
		for (int i = 0; i < temp2Quantity.length; i++) {
			String q = quantityArray.get(0);
			quantityArray.remove(0);
			temp2Quantity[i] = q;
		}
		
		for (int i = 0; i < temp2.size(); i++) {
			if (StringUtils.isNotBlank(temp2Quantity[i])) {
				EloadDailySales e = temp2.get(i);
				eloadDailyService.addEloadDailySales(Constants.ELOAD_GLOBE_PRODUCT_ID, e.getPriceId(), Integer.parseInt(tempQuantity[i]), SessionUtility.getUser().getUserName());
			}
		}

		
		String[] temp3Quantity = new String[temp3.size()];
		for (int i = 0; i < temp3Quantity.length; i++) {
			String q = quantityArray.get(0);
			quantityArray.remove(0);
			temp3Quantity[i] = q;
		}
		
		for (int i = 0; i < temp3.size(); i++) {
			if (StringUtils.isNotBlank(temp3Quantity[i])) {
				EloadDailySales e = temp3.get(i);eloadDailyService.addEloadDailySales(Constants.ELOAD_SUN_PRODUCT_ID, e.getPriceId(), Integer.parseInt(tempQuantity[i]), SessionUtility.getUser().getUserName());
			}
		}

		//setMessage("Smart Sales: "+resultAddSmartSales+". \nGlobe Sales: "+resultAddGlobeSales+". \nSun Sales: "+resultAddSunSales);
		
		return SUCCESS;
	}
	
	public String searchEloadPrice(){
		setMenuActive("11");
		
		Double priceDbl = null;
		Double retailDbl = null;
		Double markupDbl = null;
		String priceOperate = null;
		String retailOperate = null;
		String markupOperate = null;
		
		if (StringUtils.isNotEmpty(price) && StringUtils.isNotEmpty(operatorPriceStr)) {
			priceDbl = new Double(price);
			priceOperate = new String(operatorPriceStr);
		}
		if (StringUtils.isNotEmpty(retailPrice) && StringUtils.isNotEmpty(operatorRetailStr)) {
			retailDbl = new Double(retailPrice);
			retailOperate = new String(operatorRetailStr);
		}
		if (StringUtils.isNotEmpty(markupPrice) && StringUtils.isNotEmpty(operatorMarkupStr)) {
			markupDbl = new Double(markupPrice);
			markupOperate = new String(operatorMarkupStr);
		}	
		
		pageEloadPriceSmart = eloadDailyService.viewEloadPrices(ELoadDailyService.SMART, priceDbl, priceOperate, retailDbl, retailOperate, 
																	markupDbl, markupOperate, priceStatus);
		
		pageEloadPriceGlobe = eloadDailyService.viewEloadPrices(ELoadDailyService.GLOBE, priceDbl, priceOperate, retailDbl, retailOperate, 
																	markupDbl, markupOperate, priceStatus);
		pageEloadPriceSun = eloadDailyService.viewEloadPrices(ELoadDailyService.SUN, priceDbl, priceOperate, retailDbl, retailOperate, 
																	markupDbl, markupOperate, priceStatus);
		
		return SUCCESS;
	}
	
	public String addEloadPrice(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		eloadPrice.setUpdatedBy(SessionUtility.getUser().getUserName());
		String result = eloadDailyService.addEloadPrice(eloadPrice);
		try {
			if (result==null) {
				json.put(Constants.SUCCESS, true);
			} else if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}
	
	public String updateEloadPrice(){
		PrintWriter out = getPrintWriter();
		JSONObject json = new JSONObject();
		
		if (eloadPrice.getEnableStatus()==0) {
			eloadPrice.setEnableStatus(1);
		} else {
			eloadPrice.setEnableStatus(0);
		}
		eloadPrice.setUpdatedBy(SessionUtility.getUser().getUserName());
		String result = eloadDailyService.updateEloadPrice(eloadPrice);
		try {
			if (result==null) {
				json.put(Constants.SUCCESS, true);
			} else if (result.equals(Constants.SUCCESS)) {
				json.put(Constants.SUCCESS, true);
			} else {
				json.put(Constants.SUCCESS, false);
			}
			json.put("message", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		printJsonAndCloseWriter(out, json);
		
		return null;
	}
	
	public EloadPrices getEloadPrice() {
		return eloadPrice;
	}

	public void setEloadPrice(EloadPrices eloadPrice) {
		this.eloadPrice = eloadPrice;
	}

	public int getPriceListType() {
		return priceListType;
	}
	public void setPriceListType(int priceListType) {
		this.priceListType = priceListType;
	}
	public String getAdditionalBalance() {
		return additionalBalance;
	}
	public void setAdditionalBalance(String additionalBalance) {
		this.additionalBalance = additionalBalance;
	}
	public int getBalanceId() {
		return balanceId;
	}
	public void setBalanceId(int balanceId) {
		this.balanceId = balanceId;
	}
	public String getEloadType() {
		return eloadType;
	}
	public void setEloadType(String eloadType) {
		this.eloadType = eloadType;
	}
	public String getSearchDate() {
		return searchDate;
	}
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	public Page getPageEloadBalance() {
		return pageEloadBalance;
	}
	public void setPageEloadBalance(Page pageEloadBalance) {
		this.pageEloadBalance = pageEloadBalance;
	}
	public Page getPageEloadSalesSmart() {
		return pageEloadSalesSmart;
	}
	public void setPageEloadSalesSmart(Page pageEloadSalesSmart) {
		this.pageEloadSalesSmart = pageEloadSalesSmart;
	}
	public Page getPageEloadSalesGlobe() {
		return pageEloadSalesGlobe;
	}
	public void setPageEloadSalesGlobe(Page pageEloadSalesGlobe) {
		this.pageEloadSalesGlobe = pageEloadSalesGlobe;
	}
	public Page getPageEloadSalesSun() {
		return pageEloadSalesSun;
	}
	public void setPageEloadSalesSun(Page pageEloadSalesSun) {
		this.pageEloadSalesSun = pageEloadSalesSun;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	public Timestamp getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
	public int getPriceId() {
		return priceId;
	}
	public void setPriceId(int priceId) {
		this.priceId = priceId;
	}
	public Page getPageEloadPriceSmart() {
		return pageEloadPriceSmart;
	}
	public void setPageEloadPriceSmart(Page pageEloadPriceSmart) {
		this.pageEloadPriceSmart = pageEloadPriceSmart;
	}
	public Page getPageEloadPriceGlobe() {
		return pageEloadPriceGlobe;
	}
	public void setPageEloadPriceGlobe(Page pageEloadPriceGlobe) {
		this.pageEloadPriceGlobe = pageEloadPriceGlobe;
	}
	public Page getPageEloadPriceSun() {
		return pageEloadPriceSun;
	}
	public void setPageEloadPriceSun(Page pageEloadPriceSun) {
		this.pageEloadPriceSun = pageEloadPriceSun;
	}
	public int getBalanceUpdateType() {
		return balanceUpdateType;
	}
	public void setBalanceUpdateType(int balanceUpdateType) {
		this.balanceUpdateType = balanceUpdateType;
	}

	public String getQuantity1() {
		return quantity1;
	}
	
	@SuppressWarnings("unchecked")
	private List<String> getQuantityArray(){
		List<String> quantityArray = new ArrayList<String>();
		quantityArray.add(quantity1);
		quantityArray.add(quantity2);
		quantityArray.add(quantity3);
		quantityArray.add(quantity4);
		quantityArray.add(quantity5);
		quantityArray.add(quantity6);
		quantityArray.add(quantity7);
		quantityArray.add(quantity8);
		quantityArray.add(quantity9);
		quantityArray.add(quantity10);
		quantityArray.add(quantity11);
		quantityArray.add(quantity12);
		quantityArray.add(quantity13);
		quantityArray.add(quantity14);
		quantityArray.add(quantity15);
		quantityArray.add(quantity16);
		quantityArray.add(quantity17);
		quantityArray.add(quantity18);
		quantityArray.add(quantity19);
		quantityArray.add(quantity20);
		quantityArray.add(quantity21);
		quantityArray.add(quantity22);
		quantityArray.add(quantity23);
		quantityArray.add(quantity24);
		quantityArray.add(quantity25);
		quantityArray.add(quantity26);
		quantityArray.add(quantity27);
		quantityArray.add(quantity28);
		quantityArray.add(quantity29);
		quantityArray.add(quantity30);
		quantityArray.add(quantity31);
		quantityArray.add(quantity32);
		quantityArray.add(quantity33);
		quantityArray.add(quantity34);
		quantityArray.add(quantity35);
		
		List<EloadDailySales> temp = (List<EloadDailySales>) pageEloadSalesSmart.getContents();
		List<EloadDailySales> temp2 = (List<EloadDailySales>) pageEloadSalesGlobe.getContents();
		List<EloadDailySales> temp3 = (List<EloadDailySales>) pageEloadSalesSun.getContents();
		int totalContents = temp.size()+temp2.size()+temp3.size();
		List<String> quantityArray2 = new ArrayList<String>();
		for (int i = 0; i<totalContents; i++) {
			quantityArray2.add(quantityArray.get(i));
		}
		
		return quantityArray2;
	}
	
	public double getSmartTotal() {
		return smartTotal;
	}

	public void setSmartTotal(double smartTotal) {
		this.smartTotal = smartTotal;
	}

	public double getGlobeTotal() {
		return globeTotal;
	}

	public void setGlobeTotal(double globeTotal) {
		this.globeTotal = globeTotal;
	}

	public double getSunTotal() {
		return sunTotal;
	}

	public void setSunTotal(double sunTotal) {
		this.sunTotal = sunTotal;
	}
	
	public String getOperatorPriceStr() {
		return operatorPriceStr;
	}

	public void setOperatorPriceStr(String operatorPriceStr) {
		this.operatorPriceStr = operatorPriceStr;
	}

	public String getOperatorRetailStr() {
		return operatorRetailStr;
	}

	public void setOperatorRetailStr(String operatorRetailStr) {
		this.operatorRetailStr = operatorRetailStr;
	}

	public String getOperatorMarkupStr() {
		return operatorMarkupStr;
	}

	public void setOperatorMarkupStr(String operatorMarkupStr) {
		this.operatorMarkupStr = operatorMarkupStr;
	}

	public String getPriceStatus() {
		return priceStatus;
	}

	public void setPriceStatus(String priceStatus) {
		this.priceStatus = priceStatus;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRetailPrice() {
		return retailPrice;
	}

	public void setRetailPrice(String retailPrice) {
		this.retailPrice = retailPrice;
	}

	public String getMarkupPrice() {
		return markupPrice;
	}

	public void setMarkupPrice(String markupPrice) {
		this.markupPrice = markupPrice;
	}
	
	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public void setQuantity1(String quantity1) {
		this.quantity1 = quantity1;
	}

	public String getQuantity2() {
		return quantity2;
	}

	public void setQuantity2(String quantity2) {
		this.quantity2 = quantity2;
	}

	public String getQuantity3() {
		return quantity3;
	}

	public void setQuantity3(String quantity3) {
		this.quantity3 = quantity3;
	}

	public String getQuantity4() {
		return quantity4;
	}

	public void setQuantity4(String quantity4) {
		this.quantity4 = quantity4;
	}

	public String getQuantity5() {
		return quantity5;
	}

	public void setQuantity5(String quantity5) {
		this.quantity5 = quantity5;
	}

	public String getQuantity6() {
		return quantity6;
	}

	public void setQuantity6(String quantity6) {
		this.quantity6 = quantity6;
	}

	public String getQuantity7() {
		return quantity7;
	}

	public void setQuantity7(String quantity7) {
		this.quantity7 = quantity7;
	}

	public String getQuantity8() {
		return quantity8;
	}

	public void setQuantity8(String quantity8) {
		this.quantity8 = quantity8;
	}

	public String getQuantity9() {
		return quantity9;
	}

	public void setQuantity9(String quantity9) {
		this.quantity9 = quantity9;
	}

	public String getQuantity10() {
		return quantity10;
	}

	public void setQuantity10(String quantity10) {
		this.quantity10 = quantity10;
	}

	public String getQuantity11() {
		return quantity11;
	}

	public void setQuantity11(String quantity11) {
		this.quantity11 = quantity11;
	}

	public String getQuantity12() {
		return quantity12;
	}

	public void setQuantity12(String quantity12) {
		this.quantity12 = quantity12;
	}

	public String getQuantity13() {
		return quantity13;
	}

	public void setQuantity13(String quantity13) {
		this.quantity13 = quantity13;
	}

	public String getQuantity14() {
		return quantity14;
	}

	public void setQuantity14(String quantity14) {
		this.quantity14 = quantity14;
	}

	public String getQuantity15() {
		return quantity15;
	}

	public void setQuantity15(String quantity15) {
		this.quantity15 = quantity15;
	}

	public String getQuantity16() {
		return quantity16;
	}

	public void setQuantity16(String quantity16) {
		this.quantity16 = quantity16;
	}

	public String getQuantity17() {
		return quantity17;
	}

	public void setQuantity17(String quantity17) {
		this.quantity17 = quantity17;
	}

	public String getQuantity18() {
		return quantity18;
	}

	public void setQuantity18(String quantity18) {
		this.quantity18 = quantity18;
	}

	public String getQuantity19() {
		return quantity19;
	}

	public void setQuantity19(String quantity19) {
		this.quantity19 = quantity19;
	}

	public String getQuantity20() {
		return quantity20;
	}

	public void setQuantity20(String quantity20) {
		this.quantity20 = quantity20;
	}

	public String getQuantity21() {
		return quantity21;
	}

	public void setQuantity21(String quantity21) {
		this.quantity21 = quantity21;
	}

	public String getQuantity22() {
		return quantity22;
	}

	public void setQuantity22(String quantity22) {
		this.quantity22 = quantity22;
	}

	public String getQuantity23() {
		return quantity23;
	}

	public void setQuantity23(String quantity23) {
		this.quantity23 = quantity23;
	}

	public String getQuantity24() {
		return quantity24;
	}

	public void setQuantity24(String quantity24) {
		this.quantity24 = quantity24;
	}

	public String getQuantity25() {
		return quantity25;
	}

	public void setQuantity25(String quantity25) {
		this.quantity25 = quantity25;
	}

	public String getQuantity26() {
		return quantity26;
	}

	public void setQuantity26(String quantity26) {
		this.quantity26 = quantity26;
	}

	public String getQuantity27() {
		return quantity27;
	}

	public void setQuantity27(String quantity27) {
		this.quantity27 = quantity27;
	}

	public String getQuantity28() {
		return quantity28;
	}

	public void setQuantity28(String quantity28) {
		this.quantity28 = quantity28;
	}

	public String getQuantity29() {
		return quantity29;
	}

	public void setQuantity29(String quantity29) {
		this.quantity29 = quantity29;
	}

	public String getQuantity30() {
		return quantity30;
	}

	public void setQuantity30(String quantity30) {
		this.quantity30 = quantity30;
	}

	public String getQuantity31() {
		return quantity31;
	}

	public void setQuantity31(String quantity31) {
		this.quantity31 = quantity31;
	}

	public String getQuantity32() {
		return quantity32;
	}

	public void setQuantity32(String quantity32) {
		this.quantity32 = quantity32;
	}

	public String getQuantity33() {
		return quantity33;
	}

	public void setQuantity33(String quantity33) {
		this.quantity33 = quantity33;
	}

	public String getQuantity34() {
		return quantity34;
	}

	public void setQuantity34(String quantity34) {
		this.quantity34 = quantity34;
	}

	public String getQuantity35() {
		return quantity35;
	}

	public void setQuantity35(String quantity35) {
		this.quantity35 = quantity35;
	}
	
}
