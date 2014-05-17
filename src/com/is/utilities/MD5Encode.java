package com.is.utilities;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Encode {
	
	public static String encodeMD5(String word){
		StringBuilder encodedStr = new StringBuilder("");
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(word.getBytes());
			byte[] bytes = md.digest();
			for (int i=0; i<bytes.length; i++) {
				encodedStr.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return encodedStr.toString();
	}
	
	public static void main(String[] args){
		String test = "4297f44b13955235245b2497399d7a93";
		String password = "123123";
		String encodedPassword = "";
		
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			byte[] bytes = md.digest();
			StringBuilder convertStr = new StringBuilder();
			for (int i=0; i<bytes.length; i++) {
				convertStr.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
			}
			encodedPassword = convertStr.toString();
			System.out.println("encodedPassword: "+encodedPassword);
			if (encodedPassword.equals(test)) {
				System.out.println("equal");
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		
	}

}
