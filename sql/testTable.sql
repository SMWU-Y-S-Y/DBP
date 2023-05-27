drop table student purge;
drop table course purge;
drop table teach purge;
drop table enroll purge;

create table student(
	s_id number,
	s_name varchar2(100),
	s_pwd varchar2(100),
	s_email	varchar2(200),
	s_address varchar2(200)
);

create table course(
	c_id number,
	c_id_no	number
);

create table teach(
	t_id	number,
	t_year	number,
	t_semester	varchar2(100),
	t_time	varchar2(200),
	t_max	number,
	t_location	varchar2(200),
	c_id	number,
	c_id_no	number
);

create table enroll(
	e_id	number,
	e_year	number,
	e_semester	number,
	s_id	number,
	c_id	number,
	c_id_no	number
);


insert into student values(12345, '최예헌1', '12345', 'choi@gmail.com', '경기도');
insert into student values(54321, '최예헌2', '54321', 'yeye@sookmyung.ac.kr', '서울');
insert into student values(12121, '최예헌3', '00000', 'hoho@naver.com', '인천');

