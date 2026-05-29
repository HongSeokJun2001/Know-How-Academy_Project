
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
            VALUES(SEQ_USER_NO
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?)    
                   
 