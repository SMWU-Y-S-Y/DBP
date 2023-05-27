CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
RETURN NUMBER
IS
	v_year	NUMBER;
	v_month	char(3);
BEGIN
	select to_number(to_char(dDate, 'yyyy')), to_char(dDate, 'mm')
	into v_year, v_month
	from dual;
	
	if (v_month = '11' OR v_month = '12') then
		v_year := v_year + 1;
	end if;
	
	return v_year;
END;
/

CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
	v_sem	NUMBER;
	v_month	char(3);
BEGIN
	select to_char(dDate, 'mm')
	into v_month
	from dual;
	
	if (v_month >= '05' AND v_month <= '10') then
		v_sem := 2;
	else
		v_sem := 1;
	end if;
	
	return v_sem;
END;
/

