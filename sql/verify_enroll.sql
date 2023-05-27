CREATE OR REPLACE PROCEDURE SelectTimeTable(
	sStudentId 	IN VARCHAR2,
	nYear 		IN NUMBER,
	nSemester 	IN NUMBER,
)


BEGIN
	
	
	

END;
/

/*
 * 명시적 커서를 이용한 프로시저 실습
 * IN 패러미터 : 학번, 년도, 학기
 * 결과
 * - 패러미터로 입력한 학번, 년도, 학기에 해당하는 수강신청 시간표 보여줌
 * - 시간표 정보로 교시, 과목번호, 과목명, 분반, 학점, 장소 보여줌
 * - 총 신청 과목수와 총 학점 보여줌
 */
