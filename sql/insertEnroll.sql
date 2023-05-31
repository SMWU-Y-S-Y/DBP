drop procedure insertenroll;

create or replace procedure InsertEnroll(
	sStudentId 	in varchar2,
	sCourseId 	in varchar2,
	nCourseIdNo in number,
	result 		out varchar2)
is
	too_many_sumCourseUnit 	exception;
	duplicate_courses 		exception;
	too_many_students 		exception;
	duplicate_time 			exception;
	nYear 			number;
	nSemester 		number;
	nSumCourseUnit 	number;
	nCourseUnit 		number;
	nCnt 			number;
	nTeachMax 		number;
	
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
	
	cursor checkCursor is
	select t.t_time, t.t_year, t.t_semester
	from enroll e, teach t
	where e.s_id = sStudentId
		and e.c_id = t.c_id and e.c_id_no = t.c_id_no 
		and e.e_year = t.t_year and e.e_semester = t.t_semester; 
	
begin
	result := '';
	
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수강 등록을 요청하였습니다.');

	/* 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
	
	/* 에러 처리 1 : 최대학점 초과여부 */
	select SUM(c.c_unit)
	into nSumCourseUnit
	from course c, enroll e
	where e.s_id = sStudentId and e.e_year = nYear and e.e_semester = nSemester and e.c_id = c.c_id and e.c_id_no = c.c_id_no;
	
	select c_unit
	into nCourseUnit
	from course
	where c_id = sCourseId and c_id_no = nCourseIdNo;
	
	if (nSumCourseUnit + nCourseUnit > 18) then
		RAISE too_many_sumCourseUnit;
	end if;

	/* 에러 처리 2 : 동일한 과목 신청 여부 */
	select COUNT(*)
	into nCnt
	from enroll
	where s_id = sStudentId and c_id = sCourseId;
	
	if (nCnt > 0) then
		RAISE duplicate_courses;
	end if;
	
	/* 에러 처리 3 : 수강신청 인원 초과 여부 */
	select t_max /*해당 과목의 수강정원*/
	into nTeachMax
	from teach
	where t_year= nYear and t_semester = nSemester
	and c_id = sCourseId and c_id_no= nCourseIdNo;
	
	select COUNT(*)
	into nCnt
	from enroll
	where e_year = nYear and e_semester = nSemester
	and c_id = sCourseId and c_id_no = nCourseIdNo;
	
	if (nCnt >= nTeachMax) then
		RAISE too_many_students;
	end if;

	/* 에러 처리 4 : 신청한 과목들 시간 중복 여부 */
	select to_number(instr(t_time, '/'))
	into nIdx
	from teach
	where c_id = sCourseId and c_id_no = nCourseIdNo and t_year = nYear and t_semester = nSemester;
	
	select substr(t_time, 1, nIdx-1), to_number(substr(t_time, nIdx+1, 2)), to_number(substr(t_time, nIdx+4, 2)), 	to_number(substr(t_time, nIdx+7, 2)), to_number(substr(t_time, nIdx+10, 2))
	into sDay, nStartH, nStartM, nEndH, nEndM
	from teach
	where c_id = sCourseId and c_id_no = nCourseIdNo and t_year = nYear and t_semester = nSemester;

	for clist in checkCursor loop
		if (clist.t_year = nYear and clist.t_semester = nSemester) then
			/* 등록된 수강과목 시간 */
			nIdx := to_number(instr(clist.t_time, '/'));
			eDay := substr(clist.t_time, 1, nIdx-1);
			eStartH := to_number(substr(clist.t_time, nIdx+1, 2));
			eStartM := to_number(substr(clist.t_time, nIdx+4, 2));
			eEndH := to_number(substr(clist.t_time, nIdx+7, 2));
			eEndM := to_number(substr(clist.t_time, nIdx+10, 2));
			
			for i in 1..LENGTH(eDay) loop
				eTmp := concat(concat('%', substr(eDay, i, 1)), '%');
				
				if (sDay LIKE eTmp) then
					/* 시간 겹친다면 */
					if ((eEndH = nStartH and eEndM < nStartM) or (eEndH < nStartH)) then 
						DBMS_OUTPUT.put_line('#');
					elsif ((nEndH = eStartH and nEndM < eStartM) or (nEndH < eStartH)) then
						DBMS_OUTPUT.put_line('#');
					else 
						RAISE duplicate_time;
					end if;
				end if;
			end loop;
		end if;
	end loop;

	/* 수강 신청 등록 */
	INSERT INTO enroll(E_ID, S_ID,C_ID,C_ID_NO,E_YEAR,E_SEMESTER) 
	VALUES (enroll_seq.nextval, sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
	COMMIT;
	
	result := '수강신청 등록이 완료되었습니다.';
	
	EXCEPTION
	WHEN too_many_sumCourseUnit THEN
		result := '최대학점을 초과하였습니다';
	WHEN duplicate_courses THEN
		result := '이미 등록된 과목을 신청하였습니다';
	WHEN too_many_students THEN
		result := '수강신청 인원이 초과되어 등록이 불가능합니다';
	WHEN duplicate_time THEN
		result := '이미 등록된 과목 중 중복되는 시간이 존재합니다';
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;

END;
/