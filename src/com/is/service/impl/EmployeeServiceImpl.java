package com.is.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.is.model.CheckInDetail;
import com.is.model.EmployeeOnDuty;
import com.is.service.interfaze.EmployeeService;
import com.is.utilities.Constants;
import com.is.utilities.DateUtility;
import com.is.utilities.SessionUtility;

public class EmployeeServiceImpl extends BaseServiceImpl implements EmployeeService{

	public String checkIn(Map<String, Object> params) {
		String hql = "CALL CheckIn(:userid, :startingcash, :startingglobeeload, :startingsmarteload, :startingsuneload)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("userid", params.get(USER_ID));
		query.setParameter("startingcash", params.get(STARTING_CASH));
		query.setParameter("startingglobeeload", params.get(STARTING_GLOBE_ELOAD));
		query.setParameter("startingsmarteload", params.get(STARTING_SMART_ELOAD));
		query.setParameter("startingsuneload", params.get(STARTING_SUN_ELOAD));
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		if (result.equals(Constants.SUCCESS)) {
			setEmployeeOnDutySession((Integer)params.get(USER_ID));
		}
		
		return result;
	}
	
	private void setEmployeeOnDutySession(int userId){
		StringBuilder hql = new StringBuilder("SELECT d.on_duty_id,d.duty_status,d.login_date,e.daily_balance_id ")
												.append("FROM on_duty d JOIN eload_daily_balances e ON e.created_by=d.user_id ")
												.append("WHERE d.user_id=:userid AND DATE(d.login_date)=:currentdate ");
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("userid", userId);
		query.setParameter("currentdate", DateUtility.getSimpleCurrentDateStr());
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		EmployeeOnDuty employeeOnDuty = new EmployeeOnDuty();
		employeeOnDuty.setUserId(userId);
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			employeeOnDuty.setOnDutyId((Integer)object[0]);
			employeeOnDuty.setOnDutyStatus((Integer)object[1]);
			employeeOnDuty.setLoginDate((Timestamp)object[2]);
			employeeOnDuty.setEloadDailyBalanceId((Integer)object[3]);
		}
		SessionUtility.setEmployeeOnDutySession(employeeOnDuty);
	}

	public String checkOut(Map<String, Object> params) {
		String hql = "Call CheckOut(:ondutyid, :eloadDailyBalanceid, :userid, :totalcash, :handovercash, :endingbalglobe, :endingbalsmart, :endingbalsun, :journalentry)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("ondutyid", params.get(ON_DUTY_ID));
		query.setParameter("eloadDailyBalanceid", params.get(ELOAD_DAILY_BAL_ID)); 
		query.setParameter("userid", params.get(USER_ID));
		query.setParameter("totalcash", params.get(TOTAL_CASH));
		query.setParameter("handovercash", params.get(CASH_HAND_OVER));
		query.setParameter("endingbalglobe", params.get(ENDING_BAL_GLOBE));
		query.setParameter("endingbalsmart", params.get(ENDING_BAL_SMART));
		query.setParameter("endingbalsun", params.get(ENDING_BAL_SUN));
		query.setParameter("journalentry", params.get(JOURNAL_ENTRY));
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		if (result.equals(Constants.SUCCESS)) {
			SessionUtility.invalidateEmployeeOnDutySession();
		}
		
		return result;
	}

	/*public String recordJournal(int userId, String journalEntry) {
		String hql = "CALL RecordJournalEntry(:userid, :journalEntry, :currentdate)";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("userid", userId);
		query.setParameter("journalEntry", journalEntry);
		query.setParameter("currentdate", DateUtility.getSimpleCurrentDateStr());
		
		List<?> list = query.list();
		String result = (String) list.get(0);
		
		return result;
	}*/

	public CheckInDetail getCheckInDetail(int userId) {
		StringBuilder hql = new StringBuilder("SELECT d.starting_cash,e.starting_eload_smart,e.starting_eload_globe,e.starting_eload_sun,d.duty_status ");
		hql.append("FROM on_duty d JOIN eload_daily_balances e ON e.created_date ");
		hql.append("WHERE d.user_id=:userid AND DATE(d.login_date)=:currentdate ");
		Query query = getSession().createSQLQuery(hql.toString());
		query.setParameter("userid", userId);
		query.setParameter("currentdate", DateUtility.getSimpleCurrentDateStr());
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		CheckInDetail checkInDetail = null;
		while (iter.hasNext()) {
			Object[] object = (Object[]) iter.next();
			checkInDetail = new CheckInDetail();
			checkInDetail.setStartingCash((BigDecimal)object[0]);
			checkInDetail.setStartingSmartEload((BigDecimal)object[1]);
			checkInDetail.setStartingGlobeEload((BigDecimal)object[2]);
			checkInDetail.setStartingSunEload((BigDecimal)object[3]);
			checkInDetail.setOnDutyStatus((Integer)object[4]);
		}
		
		if (checkInDetail!=null) {
			setEmployeeOnDutySession(userId);
		}
		
		return checkInDetail;
	}

	public Date getCheckOutDate(int userId) {
		String hql = "SELECT logout_date FROM on_duty WHERE user_id=:userid AND DATE(login_date)=:currentdate ";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("userid", userId);
		query.setParameter("currentdate", DateUtility.getSimpleCurrentDateStr());
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		Date checkOutDate = null;
		while (iter.hasNext()) {
			checkOutDate = (Date) iter.next();
		}
		
		return checkOutDate;
	}

	public String getJournalEntry(int userId) {
		String hql = "SELECT journal_entry FROM on_duty WHERE user_id=:userid AND DATE(login_date)=:currentdate ";
		Query query = getSession().createSQLQuery(hql);
		query.setParameter("userid", userId);
		query.setParameter("currentdate", DateUtility.getSimpleCurrentDateStr());
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		String journalEntry = null;
		while (iter.hasNext()) {
			journalEntry = (String) iter.next();
		}
		
		return journalEntry;
	}

	public BigDecimal getYesterdayPrevCashEnding() {
		String hql = "select ending_cash from on_duty order by on_duty_id desc limit 1";
		Query query = getSession().createSQLQuery(hql);
		
		List<?> list = query.list();
		Iterator<?> iter = list.iterator();
		BigDecimal cashEnding = null;
		while (iter.hasNext()) {
			cashEnding = (BigDecimal) iter.next();
		}
		
		return cashEnding;
	}



}
