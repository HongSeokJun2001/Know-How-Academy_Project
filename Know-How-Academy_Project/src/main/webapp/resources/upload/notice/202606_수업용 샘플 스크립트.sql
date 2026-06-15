-- 스크립트 파일 작성하기
-- 한 계정 내에 내가 만들고싶은 테이블, 시퀀스 등을 "순차적" 으로 SQL문을 나열하여 작성한다.

-- 스크립트 작성 시 주의할 점
-- 1. 항상 상단에 DROP 구문을 먼저 작성한다.
-- 추후에 만들어질 테이블 또는 시퀀스 등의 이름이 중복되서 스크립트 실행 중간에 오류가 터질 확률을 줄여줌!!
-- 이 때, 자식테이블 --> 부모테이블 순서대로 DROP 구문을 기술한다. (외래키 제약조건 때문)
-- 2. 항상 테이블 CREATE 구문 작성 순서는 부모테이블 --> 자식테이블 순서로 기술한다!! (외래키 제약조건 때문)

-- 이 계정 내에서 만들 테이블을 미리 DROP (이름 중복 방지)
DROP TABLE MEMBER;

-- 테이블 본격 생성
CREATE TABLE MEMBER (
    USERNO NUMBER PRIMARY KEY,
    USERID VARCHAR2(15) NOT NULL UNIQUE,
    USERPWD VARCHAR2(20) NOT NULL,
    USERNAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
    AGE NUMBER, 
    EMAIL VARCHAR2(30),
    PHONE CHAR(11),
    ADDRESS VARCHAR2(100),
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL
);

-- 이 계정 내에서 만들 시퀀스를 미리 DROP (이름 중복 방지)
DROP SEQUENCE SEQ_USERNO;

-- 시퀀스 본격 생성
CREATE SEQUENCE SEQ_USERNO
NOCACHE;

-- 개발 단계에서는 만들어진 테이블에 샘플 데이터를 몇개 넣어두고 테스트하면서 개발하는게 제일 좋다!!
--> 샘플 데이터 == 더미 데이터

-- 샘플 데이터 삽입하기 (2건 정도)
INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL
                        , 'admin'
                        , '1234'
                        , '관리자'
                        , 'M'
                        , 45
                        , 'admin@naver.com'
                        , '01012345678'
                        , '서울시 마포구'
                        , '2021/01/25');

INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL
                        , 'user01'
                        , 'pass01'
                        , '홍길녀'
                        , 'F'
                        , 23
                        , NULL
                        , '01067891234'
                        , NULL
                        , '2021/07/12');

-- 항상 스크립트 파일의 구문의 끝에는 COMMIT 명령문을 써야 한다!!
COMMIT;

--> 이렇게 다 만들어진 스크립트 파일을 전체 실행해서 DB 를 구축한다!!

--------------------------------------------------------------------------------

-- 위에서 생성한 MEMBER 테이블 조회해보기
SELECT * FROM MEMBER;

--------------------------------------------------------------------------------

-- 여기에 작성하면 안됨!! 필기 상 작성해보자!!

-- 1. 회원 추가용 쿼리문
INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL
                        , 'XXX'
                        , 'XXXXXX'
                        , 'XXX'
                        , 'X'
                        , XX
                        , 'XXXXXXX'
                        , 'XXXXXXX'
                        , 'XXXXXXXXXX'
                        , DEFAULT);

-- 2. 회원 전체 조회용 쿼리문
SELECT * FROM MEMBER;

-- 3. 회원 아이디 검색용 쿼리문
SELECT *
  FROM MEMBER
 WHERE USERID = 'XXX';
 
-- 4. 회원 이름 키워드 검색용 쿼리문
SELECT *
  FROM MEMBER
 WHERE USERNAME LIKE '%XXX%';

-- 5. 회원 정보 수정용 쿼리문
UPDATE MEMBER
   SET USERPWD = 'XXXX'
     , EMAIL = 'XXXXX@XXX.XXX'
     , PHONE = 'XXXXXXXXXX'
     , ADDRESS = 'XXX XXX XXX'
 WHERE USERID = 'XXX';
 
-- 6. 회원 탈퇴용 쿼리문
DELETE
  FROM MEMBER
 WHERE USERID = 'XXXX';








