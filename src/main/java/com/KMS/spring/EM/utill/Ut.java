package com.KMS.spring.EM.utill;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

public class Ut {
	
	/**
	 * 입력값이 비어있는지 확인
	 * 비어있으면 true
	 * @param obj
	 * @return boolean
	 */
	public static boolean empty(Object obj) {
		if(obj == null) {
			return true;
		}
		if(obj instanceof String == false) {
			return true;
		}
		String str = (String) obj;
		return str.trim().length() == 0;
	}
	
	/**
	 * 변수 포함하는 문자열 출력
	 * @param format
	 * @param args
	 * @return String
	 */
    public static String f(String format, Object... args){
        return String.format(format,args);
    }
    
    /**
     * 메세지 경고 띄우고 뒤로가기
     * @param msg
     * @return String
     */
	public static String jsHistoryBack(String msg) {

		if (msg == null) {
			msg = "";
		}
		return Ut.f("""
				<script>
				const msg = '%s'.trim();
				if (msg.length > 0){
					alert(msg);
				}
				history.back();
				</script>
				""", msg);
	}
	/**
	 * 메세지와 주소 받아서 메세지 경고 띄우고 받은 주소로 이동
	 * @param msg
	 * @param uri
	 * @return String
	 */
	public static String jsReplace(String msg, String uri) {
		if (msg == null) {
			msg = "";
		}
		if (uri == null) {
			uri = "";
		}
		return Ut.f("""
				<script>
				const msg = '%s'.trim();
				if (msg.length > 0){
					alert(msg);
				}
				location.replace('%s')
				</script>
				""", msg, uri);
	}
	
	/**
	 * uri 아스키코드 변환
	 * @param str
	 * @return String
	 */
	public static String getUriEncoded(String str) {
		try {
			return URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return str;
		}
	}
	
	/**
	 * 현재시간에서 +1초 반환
	 * @param seconds
	 * @return String
	 */
	public static String getDateStrLater(long seconds) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateStr = format.format(System.currentTimeMillis() + seconds * 1000);
		return dateStr;
	}
	/**
	 * 무작위 인증코드 생성
	 * @param length
	 * @return String
	 */
	public static String getTempPassword(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f',
				'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}

		return sb.toString();
	}
	
	/**
	 * 파라미터 가져오기
	 * @param request
	 * @return Map<String, String>
	 */
	public static Map<String, String> getParamMap(HttpServletRequest request) {
		Map<String, String> param = new HashMap<>();

		Enumeration<String> parameterNames = request.getParameterNames();

		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			param.put(paramName, paramValue);
		}

		return param;
	}

	
	public static String getAttr(Map map, String attrName, String defaultValue) {
		if (map.containsKey(attrName)) {
			return (String) map.get(attrName);
		}
		return defaultValue;
	}

}
