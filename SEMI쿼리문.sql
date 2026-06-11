
-- 로그인용 쿼리문
SELECT *
  FROM MEMBER
 WHERE USER_ID = ?
   AND USER_PWD = ?
   AND STATUS = 'ACTIVE'
   
-- 회원가입용 쿼리문
INSERT INTO MEMBER(USER_NO
                 , USER_ID
                 , USER_PWD
                 , USER_NAME
                 , PHONE
                 , EMAIL
                 , ADDRESS)
            VALUES(SEQ_USER_NO.NEXTVAL
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?)
                 
-- 회원 정보 변경용 쿼리문
-- 아이디 (고정, 식별자 역할), 
-- 비밀번호, 이름, 전화번호, 이메일, 주소, 수정일변경
UPDATE MEMBER
   SET USER_NAME = ?
     , USER_PWD = ?
     , PHONE = ?
     , EMAIL = ?
     , ADDRESS = ?
     , UPDATED_AT = SYSDATE
 WHERE USER_ID = ?
   AND STATUS = 'ACTIVE'

-- 회원 탈퇴용 쿼리문
UPDATE MEMBER
   SET STATUS = 'INACTIVE'
     , UPDATED_AT = SYSDATE
 WHERE USER_ID = ?
   AND STATUS = 'ACTIVE' 
   
--  아이디찾기용 쿼리문 
SELECT *
  FROM MEMBER
 WHERE EMAIL  = ?
   AND USER_NAME = ?
   AND STATUS = 'ACTIVE'   
	
--  비밀번호찾기용 쿼리문 
SELECT *
  FROM MEMBER
 WHERE USER_ID = ?
   AND USER_NAME = ?
   AND EMAIL = ?
   AND STATUS = 'ACTIVE'   
	              
-- 아이디 중복 체크용 쿼리문
SELECT COUNT(*)
  FROM MEMBER
 WHERE USER_ID = ?
 
-- 이메일 중복 체크용 쿼리문
SELECT COUNT(*)
  FROM MEMBER
 WHERE EMAIL = ? 
 
 
----------------------------------------------------------------------------
 -- 계정잠금 로그인용 쿼리문
SELECT *
  FROM MEMBER_LOCK
  LEFT JOIN MEMBER M
    ON USER_ID = M.USER_ID
 WHERE USER_NO = ?
   AND IS_LOCKED = 'N'
   
-- 회원가입시 잠금데이터용 쿼리문
INSERT INTO MEMBER_LOCK(USER_NO
                      , FAIL_COUNT
                      , IS_LOCKED
                      , LOCKED_AT
                      , LAST_FAIL_AT)
                 VALUES(?
                      , ?
                      , ?
                      , ?
                      , ?)
                      
-- 로그인실패시 실패횟수증가 쿼리문 -->
UPDATE MEMBER_LOCK
   SET FAIL_COUNT = ? 
     , LAST_FAIL_AT = SYSDATE
 WHERE USER_NO = ?
	
	
-- 5회 이상이면 계점잠금 쿼리문 -->
UPDATE MEMBER_LOCK
   SET IS_LOCKED = 'Y'
     , LOCKED_AT = SYSDATE
 WHERE USER_NO = ?


-- 로그인성공시 실패횟수 초기화 -->
UPDATE MEMBER_LOCK
   SET FAIL_COUNT = 0
     , IS_LOCKED = 'N'
 WHERE USER_NO = ?
		   
 
 
 