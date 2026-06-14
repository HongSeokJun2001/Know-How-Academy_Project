--게시글 전체조회 쿼리문
SELECT
		B.POST_NO, <!-- 게시글번호 -->
		B.CATEGORY, <!-- 카테고리 -->
		B.TITLE, <!-- 제목 -->
		M.USER_NAME, <!-- 작성자명 -->
		B.VIEW_COUNT, <!-- 조회수 -->
		B.CREATED_AT <!-- 작성일 -->
		FROM BOARD_POST B <!-- 약칭 -->
		JOIN MEMBER M ON (B.WRITER_NO = M.USER_NO)
		<!-- 연관된 데이터 B와 (약칭)M과 조인하여 작성자명(USER_NAME) 가져오기 -->
		WHERE B.STATUS = 'Y'<!-- Y=노출/N 숨김처리 -->
		AND B.POST_TYPE = 'POST'
		ORDER BY B.POST_NO DESC <!-- 오름차순?이엿나 -->


	<!-- 게시글 총갯수 쿼리문 -->
		SELECT COUNT(*)
		FROM BOARD_POST
		WHERE POST_TYPE = 'POST'
		AND STATUS = 'Y'


	<!-- 검색결과의 갯수를 세오는 쿼리문 -->
		SELECT COUNT(*)
		FROM BOARD_POST B
		JOIN MEMBER M ON (B.WRITER_NO = M.USER_NO)
		WHERE BOARD_TYPE = 'POST'
		AND B.STATUS = 'Y'
		<if test="condition1 == 'writer'">
			AND M.USER_NAME LIKE '%' || #{keyword} || '%'
		</if>
		<if test="condition1 == 'title'">
			AND B.TITLE LIKE '%' || #{keyword} || '%'
		</if>
		<if test="condition1 == 'content'">
			AND B.CONTNET LIKE '%' || #{keyword} || '%'
		</if>
		<if test="condition2 == 'admission'">
			AND B.CATEGORY = '입학상담'
		</if>
		<if test="condition2 == 'employment'">
			AND B.CATEGORY = '취업상담'
		</if>


	<!-- 일반 게시글 조회수증가용 쿼리문 -->
		UPDATE BOARD_POST
		SET VIEW_COUNT = VIEW_COUNT +1
		WHERE POST_NO = #{postNo}
		AND STATUS = 'Y'


	<!-- 일반게시글 상세조회용 쿼리문 -->
		resultMap="boardResultSet">
		SELECT B.POST_NO,
		B.TITLE,
		M.USER_NAME,
		B.CREATED_AT,
		B.CONTENT
		FROM BOARD_POST B
		JOIN MEMBER M ON (B.WRITER_NO = M.USER_NO)
		WHERE POST_NO = #{postNo}
		AND B.STATUS = 'Y'


	<!-- 일반(A)게시글 등록용 쿼리문 -->
		INSERT INTO BOARD_POST(POST_NO,
		POST_TYPE,
		TITLE,
		CONTENT,
		WRITER_NO,
		VIEW_COUNT,
		CREATED_AT,
		CATEGORY,
		STATUS)
		VALUES(SEQ_BNO.NEXTVAL,
		'POST',
		#{title},
		#{content},
		#{writerNo},
		#{viewCount},
		SYSDATE,
		'일반',
		'Y')
	

	<!-- 첨부파일 등록용 쿼리문 -->
		INSERT INTO FILE_ATTACHMENT(FILE_NO,
		TARGET_NO,
		TARGET_TYPE,
		ORIGIN_NAME,
		SAVE_NAME,
		FILE_PATH)
		VALUES(SEQ_FNO.NEXTVAL,
		SEQ_BNO.CURRVAL,
		'POST',
		#{originName},
		#{saveName},
		#{filePath})

    --게시글 첨부파일등록
	<select id="selectAttachment" parameterType="_int"
		resultMap="fileAttachmentResultSet">
		SELECT FILE_NO, 
				TARGET_NO, 
				TARGET_TYPE, 
				ORIGIN_NAME, 
				SAVE_NAME, 
				FILE_PATH,
				CREATED_AT, 
				UPDATED_AT, 
				STATUS, 
				FILE_LEVEL
		FROM FILE_ATTACHMENT
		WHERE TARGET_NO = #{postNo}
		AND STATUS = 'Y'

-- 특정카테고리 전체조회용 쿼리문  
-- 공지사항, 자유, 수강생
SELECT *
FROM BOARD_POST
WHERE POST_TYPE = #{postType}
--WHERE POST_TYPE = 'NOTICE'
--WHERE POST_TYPE = 'STUDENT'
AND STATUS = 'Y'
ORDER BY POST_NO DESC

--특정 게시글 수정용 쿼리문
--공지사항, 자유, 수강생
UPDATE BOARD_POST
SET TITLE = #{title},
    CONTENT = #{content}
WHERE POST_NO = #{postNo}    
AND POST_TYPE = #{postType}
AND STATUS = 'Y'

--게시글 첨부파일 수정용 쿼리문
UPDATE FILE_ATTACHMENT
SET ORIGIN_NAME = #{originName},
    SAVE_NAME = #{saveName},
    UPDATED_AT = SYSDATE
WHERE FILE_NO = #{fileNo}    

--게시글 첨부파일 수정시 새 첨부파일로 등록하는 쿼리문
INSERT INTO FILE_ATTACHMENT(FILE_NO,
                            TARGET_NO,
                            TARGET_TYPE,
                            ORIGIN_NAME,
                            SAVE_NAME,
                            FILE_PATH,
                            CREATED_AT,
                            STATUS)
                    VALUES(SEQ_FNO.NEXTVAL,
                            #{targetNo},
                            #{targetType},
                            #{originName},
                            #{saveName},
                            #{filePath},
                            SYSDATE,
                            Y)

--게시글 삭제용 쿼리문
UPDATE BOARD_POST
SET STATUS = "N'
WHERE POST_NO = #{postNo}
AND STATUS = 'Y'