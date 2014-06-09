package com.is.service.interfaze;

public interface EmployeeService{
  
	String checkIn(String userId);
	String checkOut(String userId);
	String recordJournal(String userId, StringBuilder journalEntry);
  
}
