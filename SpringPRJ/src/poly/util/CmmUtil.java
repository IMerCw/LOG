package poly.util;

public class CmmUtil {

	public static int isInteger(String str, int def_int) {
		int res = 0;
		
		if(str == null || "".equals(str.trim())) {
			return def_int;
		}
		
		try {
			res = Integer.parseInt(str);
		}catch(NumberFormatException ne) {
			res = def_int;
		}catch(Exception e) {
			e.printStackTrace();
			res = def_int;
		}
		
		return res;
	}
	
	public static int isInteger(String str) {
		return isInteger(str, 0);
	}
	
	
	public static String nvl(String str, String chg_str) {
		String res;

		if (str == null) {
			res = chg_str;
		} else if (str.equals("")) {
			res = chg_str;
		} else {
			res = str;
		}
		return res;
	}
	
	public static String nvl(String str){
		return nvl(str,"");
	}
	
	public static String checked(String str, String com_str){
		if(str.equals(com_str)){
			return " checked";
		}else{
			return "";
		}
	}
	
	public static String checked(String[] str, String com_str){
		for(int i=0;i<str.length;i++){
			if(str[i].equals(com_str))
				return " checked";
		}
		return "";
	}
	
	public static String select(String str,String com_str){
		if(str.equals(com_str)){
			return " selected";
		}else{
			return "";
		}
	}
}
