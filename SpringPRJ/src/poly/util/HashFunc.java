package poly.util;

import java.security.NoSuchAlgorithmException;

public class HashFunc {
	
	public String doHash(String inputData) throws NoSuchAlgorithmException {
		String data = inputData;
		String hashType = "SHA-256";
		java.security.MessageDigest md;
		 
		md = java.security.MessageDigest.getInstance(hashType);
		byte[] hashData = md.digest(data.getBytes());
		 
		StringBuffer result = new StringBuffer();
		 
		for ( byte b : hashData )
			result.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
		
		String hashedResult = String.valueOf(result);
		
		return hashedResult;
	}
}
