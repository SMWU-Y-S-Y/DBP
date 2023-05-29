CREATE OR REPLACE PROCEDURE LikedEnroll(sStudentId IN VARCHAR2,
		sCourseId IN VARCHAR2,
		nCourseIdNo IN NUMBER,
		result OUT VARCHAR2)
IS
	nYear NUMBER;
	nSemester NUMBER;

BEGIN
	result := '낫띵';

	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수업을 찜하였습니다.');
	
	/* 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
	
	INSERT INTO liked(L_ID,L_YEAR,L_SEMESTER,S_ID,C_ID,C_ID_NO) VALUES (enroll_seq.nextval,nYear, nSemester,sStudentId, sCourseId, nCourseIdNo);

	COMMIT;
	result := '찜하기가 완료되었습니다.';

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
END;
/