package com.is.model;

import java.util.ArrayList;
import java.util.List;

public class Operators {
	
	private String operator;
	private static List<Operators> operators;

	private Operators(String operator){
		this.setOperator(operator);
	}

	public static  List<Operators> getOperators(){
		operators = new ArrayList<Operators>();
		operators.add(new Operators("="));
		operators.add(new Operators("<"));
		operators.add(new Operators(">"));
		operators.add(new Operators("<="));
		operators.add(new Operators(">="));
		operators.add(new Operators("!="));
		
		return operators;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}
	

}
