CREATE OR REPLACE PROCEDURE LikedEnroll(sStudentId IN VARCHAR2,
		sCourseId IN VARCHAR2,
		nCourseIdNo IN NUMBER,
		result OUT VARCHAR2)
IS
	nYear NUMBER;
	nSemester NUMBER;
	duplicate_courses EXCEPTION;
	nCnt NUMBER;

BEGIN
	result := '낫띵';

	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수업을 찜하였습니다.');
	
	/* 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
	
	/* 에러 처리 : 이미 찜한 과목 */
	SELECT COUNT(*)
	INTO nCnt
	FROM liked
	WHERE s_id = sStudentId and c_id = sCourseId and c_id_no = nCourseIdNo;
	IF (nCnt > 0) THEN
		RAISE duplicate_courses;
	END IF;

	
	INSERT INTO liked(L_ID,L_YEAR,L_SEMESTER,S_ID,C_ID,C_ID_NO) VALUES (enroll_seq.nextval,nYear, nSemester,sStudentId, sCourseId, nCourseIdNo);

	COMMIT;
	result := '찜하기가 완료되었습니다.';

EXCEPTION
	WHEN duplicate_courses THEN
		result := '이미 찜한 과목입니다';
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
END;
/