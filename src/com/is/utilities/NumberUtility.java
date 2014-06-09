package com.is.utilities;

public class NumberUtility{

	public static boolean isValidNumberDecimal(String given){
		boolean isValidNumber = true;
		if (given==null) {
			return false;
		}
		if (given.length()==0) {
			return false;
		}
		try {
			Double.parseDouble(given);
		}	 catch (NumberFormatException nfe) {
			isValidNumber = false;
		}
		return isValidNumber;
	}
  
}
