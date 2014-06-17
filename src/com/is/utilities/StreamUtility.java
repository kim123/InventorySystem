package com.is.utilities;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletResponse;

public class StreamUtility {

	public static void writeToBrowser(InputStream inputStream,HttpServletResponse response, String mimeType, String filename) {
		try {
			byte[] buffer = new byte[inputStream.available()];
			int bytesRead = 0;

			response.reset();
			response.setHeader("Content-disposition", "inline;filename="+ filename);
			response.setContentType(mimeType);

			while ((bytesRead = inputStream.read(buffer)) != -1) {
				response.getOutputStream().write(buffer, 0, bytesRead);
			}
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
