package com.kh.know_how.admin.common;

public class AdminXssDefencePolicy {
	
	/**
	 * XSS 공격 방지용 공통 코드 메소드
	 * @param originText => <> 등이 담겨있는 원본 문자열
	 * @return => <> 등을 다 안전하게 치환해둔 결과 문자열
	 */
	public static String defence(String originText) {
		
		if((originText == null) || originText.isBlank()) {
			throw new IllegalArgumentException("입력값이 비어있습니다.");
		}
		
		
		String changeText = originText.trim();
		
		changeText = changeText.replace("<", "&lt;");
		changeText = changeText.replace(">", "&gt;");
		changeText = changeText.replace("\"", "&quot;");
		changeText = changeText.replace("'", "&apos;");
		
		
		return changeText;
	}
	
}
