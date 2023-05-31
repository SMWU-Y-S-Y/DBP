drop procedure InsertLecture;

CREATE OR REPLACE PROCEDURE InsertLecture(
	sCourseName 	IN VARCHAR2,
	nCourseUnit 	IN NUMBER,
	sProfessorId 	IN VARCHAR2,
	sCourseId 		IN VARCHAR2,
	nCourseIdNo 	IN NUMBER,
	sTime 		IN VARCHAR2,
	nYear 		IN NUMBER,
	nSemester 	IN NUMBER,
	sLOC 		IN VARCHAR2,
	nMax 		IN NUMBER,
	result 		OUT VARCHAR2)
IS
	duplicate_time_professor EXCEPTION;
	duplicate_location EXCEPTION;
	
	nIdx				number;
	sDay				varchar2(100);
	nStartH 			number;
	nStartM			number;
	nEndH			number;
	nEndM			number;
	
	eDay				varchar2(100);
	eStartH 			number;
	eStartM			number;
	eEndH			number;
	eEndM			number;
	eTmp				varchar2(100);
	
	cursor checkTime is
	select t.t_time
	from teach t, professor p
	where t.p_id = sProfessorId and t.p_id = p.p_id and t.t_year = nYear and t.t_semester = nSemester;
	
	cursor checkLoc is
	select  t_time, t_location
	from teach t
	where t.t_year = nYear and t.t_semester = nSemester;
	
BEGIN
	result := '';

	nIdx := to_number(instr(sTime, '/'));
	sDay := substr(sTime, 1, nIdx-1);
	nStartH := to_number(substr(sTime, nIdx+1, 2));
	nStartM := to_number(substr(sTime, nIdx+4, 2));
	nEndH := to_number(substr(sTime, nIdx+7, 2));
	nEndM := to_number(substr(sTime, nIdx+10, 2));
	
	/* 예외처리 1 : 등록된 강의들과의 시간 중복 여부 */
	for clist1 in checkTime loop
		nIdx := to_number(instr(clist1.t_time, '/'));
		eDay := substr(clist1.t_time, 1, nIdx-1);
		eStartH := to_number(substr(clist1.t_time, nIdx+1, 2));
		eStartM := to_number(substr(clist1.t_time, nIdx+4, 2));
		eEndH := to_number(substr(clist1.t_time, nIdx+7, 2));
		eEndM := to_number(substr(clist1.t_time, nIdx+10, 2));
		
		for i in 1..LENGTH(eDay) loop
			eTmp := concat(concat('%', substr(eDay, i, 1)), '%');
			if (sDay LIKE eTmp) then
				/* 시간 겹친다면 */
				if ((eEndH = nStartH and eEndM < nStartM) or (eEndH < nStartH)) then 
					DBMS_OUTPUT.put_line('#');
				elsif ((nEndH = eStartH and nEndM < eStartM) or (nEndH < eStartH)) then
					DBMS_OUTPUT.put_line('#');
				else 
					RAISE duplicate_time_professor;
				end if;
			end if;
		end loop;
	end loop;
	
	/* 예외처리 2 : 다른 강의들과의 강의실 중복 여부 */
	for clist2 in checkLoc loop
		nIdx := to_number(instr(clist2.t_time, '/'));
		eDay := substr(clist2.t_time, 1, nIdx-1);
		eStartH := to_number(substr(clist2.t_time, nIdx+1, 2));
		eStartM := to_number(substr(clist2.t_time, nIdx+4, 2));
		eEndH := to_number(substr(clist2.t_time, nIdx+7, 2));
		eEndM := to_number(substr(clist2.t_time, nIdx+10, 2));
		
		for i in 1..LENGTH(eDay) loop
			eTmp := concat(concat('%', substr(eDay, i, 1)), '%');
			if (sDay LIKE eTmp) then
				/* 시간 겹친다면 */
				if ((eEndH = nStartH and eEndM < nStartM) or (eEndH < nStartH)) then 
					DBMS_OUTPUT.put_line('#');
				elsif ((nEndH = eStartH and nEndM < eStartM) or (nEndH < eStartH)) then
					DBMS_OUTPUT.put_line('#');
				else 
					if (sLOC = clist2.t_location) then
						RAISE duplicate_location;
					end if;
				end if;
			end if;
		end loop;
	end loop;
	
	/* teach와 course 테이블에 수업 추가 */
	INSERT INTO course
	VALUES(sCourseId, nCourseIdNo, sCourseName, nCourseUnit);
	
	INSERT INTO TEACH
	VALUES(teach_seq.nextval, nYear, nSemester, sTime, nMax, sLoc, sCourseId, nCourseIdNo, sProfessorId);
	
	COMMIT;
	result := '수업을 추가하였습니다.';
	
	EXCEPTION
	WHEN duplicate_time_professor THEN
		result := '이미 등록된 과목 중 중복되는 시간이 존재합니다.';
	WHEN duplicate_location THEN
		result := '해당 강의실에 이미 수업이 있습니다.';
	WHEN OTHERS THEN
	    ROLLBACK;
	    result := SQLCODE;
    
END;
/
