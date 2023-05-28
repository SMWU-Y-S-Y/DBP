ALTER TABLE student DROP PRIMARY KEY CASCADE;
DROP TABLE student CASCADE CONSTRAINTS;
ALTER TABLE course DROP PRIMARY KEY CASCADE;
DROP TABLE course CASCADE CONSTRAINTS;
ALTER TABLE teach DROP PRIMARY KEY CASCADE;
DROP TABLE teach CASCADE CONSTRAINTS;
drop table enroll purge;
drop table professor purge;
drop table liked purge;

create table student(
	s_id 		varchar2(100),
	s_name 		varchar2(100),
	s_pwd 		varchar2(200),
	s_email		varchar2(200),
	s_address 	varchar2(200),
	s_unit		number,
	s_cnt		number,
	CONSTRAINT student_pk PRIMARY KEY(s_id)
);

create table course(
	c_id	varchar2(100),
	c_id_no	number,
	c_name	varchar2(200),
	c_unit	number,
	CONSTRAINT course_pk PRIMARY KEY(c_id, c_id_no)
);

create table professor(
	p_id	varchar2(100),
	p_name	varchar2(200),
	p_pwd	varchar2(200),
	p_email	varchar2(200),
	CONSTRAINT professor_pk PRIMARY KEY(p_id)
);

create table teach(
	t_id		varchar2(100),
	t_year		number,
	t_semester	number,
	t_time		varchar2(200),
	t_max		number,
	t_location	varchar2(200),
	c_id		varchar2(100),
	c_id_no		number,
	p_id		varchar2(100),
	CONSTRAINT teach_pk PRIMARY KEY(t_id),
	CONSTRAINT teach_fk1 FOREIGN KEY(c_id, c_id_no) REFERENCES course(c_id, c_id_no) ON DELETE CASCADE,
	CONSTRAINT teach_fk2 FOREIGN KEY(p_id) REFERENCES professor(p_id) ON DELETE CASCADE
);

create table enroll(
	e_id		varchar2(100),
	e_year		number,
	e_semester	number,
	s_id		varchar2(100),
	c_id		varchar2(100),
	c_id_no		number,
	CONSTRAINT enroll_pk PRIMARY KEY(e_id),
	CONSTRAINT enroll_fk1 FOREIGN KEY(s_id) REFERENCES student(s_id) ON DELETE CASCADE,
	CONSTRAINT enroll_fk2 FOREIGN KEY(c_id, c_id_no) REFERENCES course(c_id, c_id_no) ON DELETE CASCADE
);

create table liked(
	l_id 		varchar2(100),
	l_year		number,
	l_semester	number,
	s_id		varchar2(100),
	c_id		varchar2(100),
	c_id_no		number,
	CONSTRAINT liked_pk PRIMARY KEY(l_id),
	CONSTRAINT liked_fk1 FOREIGN KEY(s_id) REFERENCES student(s_id) ON DELETE CASCADE,
	CONSTRAINT liked_fk2 FOREIGN KEY(c_id, c_id_no) REFERENCES course(c_id, c_id_no) ON DELETE CASCADE
);