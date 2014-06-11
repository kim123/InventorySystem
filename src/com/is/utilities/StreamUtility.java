package com.is.utilities;

public class StreamUtility{

    public static void writeToBrowser(InputStream inputStream, HttpServletResponse response, String mimeType, String filename){
      
        byte[] buffer = new byte[inputStream.available()];
        int bytesRead = 0;
        
        response.reset();
        response.setHeader("Content-disposition","inline;filename="+filename);
        response.setContentType(mimeType);
        
        while ((bytes = inputStream.read(buffer)) != -1) {
            response.getOutputStream().write(buffer, 0, bytesRead);
        }
        
        response.getOutputStream().flush();
        response.getOutputStream().close();
      
    }

}
