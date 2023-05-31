CREATE OR REPLACE PROCEDURE InsertLecture(
sCourseName IN VARCHAR2,
nCourseUnit IN NUMBER,
sProfessorId IN VARCHAR2,
sCourseId IN VARCHAR2,
nCourseIdNo IN NUMBER,
sTime IN VARCHAR2,
nYear IN NUMBER,
nSemester IN NUMBER,
sLOC IN VARCHAR2,
nMax IN NUMBER,
result OUT VARCHAR2)
IS
duplicate_time_professor EXCEPTION;
duplicate_location EXCEPTION;

check1 NUMBER;
check2 NUMBER;

BEGIN
result := '';

/* teach와 course 테이블에 수업 추가 */
INSERT INTO course
VALUES(sCourseId, nCourseIdNo, sCourseName, nCourseUnit);

INSERT INTO TEACH
VALUES(teach_seq.nextval, nYear, nSemester, sTime, nMax, sLoc, sCourseId, nCourseIdNo, sProfessorId);

COMMIT;
result := '수업을 추가하였습니다.';

EXCEPTION
WHEN duplicate_time_professor THEN
	result := '이미 등록된 과목 중 중복되는 강의가 존재합니다.';
WHEN duplicate_location THEN
	result := '해당 강의실에 이미 수업이 있습니다.';
WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
    
END;
/