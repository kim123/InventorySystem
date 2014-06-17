package com.is.utilities;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtility {
	
	private static SimpleDateFormat sdf;
	
	public static String getSimpleCurrentDateStr(){
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(new Date());
	}

}
