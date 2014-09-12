package com.is.utilities;

import java.math.BigDecimal;

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
	
	public static BigDecimal setBigDecimal(BigDecimal givenNumber){
		BigDecimal number = BigDecimal.ZERO;
		if (givenNumber!=null) {
			number = givenNumber;
		}
		return number;
	}
  
}
