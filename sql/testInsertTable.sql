insert into student values('s11111', 's1', '11111', 's1@gmail.com', '경기도');
insert into student values('s22222', 's2', '22222', 's2@sm.ac.kr', '서울');
insert into student values('s33333', 's3', '33333', 's3@naver.com', '인천');
insert into student values('s44444', 's4', '44444', 's4@naver.com', '서울');
insert into student values('s44444', 's5', '55555', 's5@naver.com', '서울');



insert into course values('c1', 1, 'DB_Programming', 3);
insert into course values('c1', 2, 'DB_Programming', 3);
insert into course values('c1', 3, 'DB_Programming', 3);
insert into course values('c2', 1, '컴퓨터 과학의 이해', 3);
insert into course values('c3', 1, 'C Programming', 3);
insert into course values('c4', 1, 'AI', 3);
insert into course values('c4', 2, 'AI', 3);
insert into course values('c5', 1, 'Algorithm', 3);
insert into course values('c6', 1, '교양 수영', 2);
insert into course values('c6', 2, '교양 수영', 2);
insert into course values('c7', 1, '인공지능', 3);
insert into course values('c8', 1, '컴파일러', 3);
insert into course values('c9', 1, '자료구조', 3);

insert into course values('c10', 1, '23-1(1)', 2);
insert into course values('c11', 1, '23-1(2)', 1);
insert into course values('c12', 1, '23-1(3)', 2);
insert into course values('c13', 1, '22-2(1)', 2);
insert into course values('c13', 2, '22-2(1)', 2);
insert into course values('c14', 1, '22-2(2)', 2);


insert into professor values('p1111', 'p1', '11111', 'p1@gmail.com');
insert into professor values('p2222', 'p2', '22222', 'p2@gmail.com');
insert into professor values('p3333', 'p3', '33333', 'p3@gmail.com');
insert into professor values('p4444', 'p4', '44444', 'p4@gmail.com');
insert into professor values('p5555', 'p5', '55555', 'p5@gmail.com');


insert into teach values('1', 2023, 2, '월수/10:00~12:00', 3, '명신', 'c1', 1, 'p1111');
insert into teach values('2', 2023, 2, '화목/10:00~12:00', 3, '명신', 'c1', 2, 'p1111');
insert into teach values('3', 2023, 2, '화목/13:00~14:00', 3, '명신', 'c1', 3, 'p2222');
insert into teach values('4', 2023, 2, '월수/11:00~13:00', 3, '명신', 'c2', 1, 'p2222');
insert into teach values('5', 2023, 2, '금/10:00~12:00', 3, '명신', 'c3', 1, 'p3333');
insert into teach values('6', 2023, 2, '화목/13:30~15:00', 3, '명신', 'c4', 1, 'p4444');
insert into teach values('7', 2023, 2, '수/10:30~12:00', 3, '명신', 'c4', 2, 'p4444');
insert into teach values('8', 2023, 2, '월수/15:00~17:00', 3, '명신', 'c5', 1, 'p5555');
insert into teach values('9', 2023, 2, '금/14:00~16:00', 3, '명신', 'c6', 1, 'p5555');
insert into teach values('10', 2023, 2, '월수/15:00~17:00', 3, '명신', 'c6', 2, 'p3333');
insert into teach values('11', 2023, 2, '수/10:00~11:10', 3, '명신', 'c7', 1, 'p1111');
insert into teach values('12', 2023, 2, '토/10:00~12:00', 3, '명신', 'c8', 1, 'p2222');
insert into teach values('13', 2023, 2, '금/10:00~12:30', 3, '명신', 'c9', 1, 'p3333');

insert into teach values('14', 2023, 2, '토/10:30~12:00', 3, '명신', 'c13', 2, 'p3333');

insert into teach values('15', 2023, 1, '월수/10:00~12:00', 3, '명신', 'c10', 1, 'p1111');
insert into teach values('16', 2023, 1, '화목/10:00~12:00', 3, '명신', 'c11', 1, 'p2222');
insert into teach values('17', 2023, 1, '금/10:00~12:00', 3, '명신', 'c12', 1, 'p3333');
insert into teach values('18', 2022, 2, '화목/10:00~12:00', 3, '명신', 'c13', 1, 'p4444');
insert into teach values('19', 2022, 2, '화목/10:00~12:00', 3, '명신', 'c14', 1, 'p5555');


insert into enroll values('1', 2023, 2, 's11111', 'c1', 1);
insert into enroll values('2', 2023, 2, 's11111', 'c3', 1);
insert into enroll values('3', 2023, 2, 's11111', 'c4', 1);
insert into enroll values('4', 2023, 1, 's11111', 'c10', 1);
insert into enroll values('5', 2023, 1, 's11111', 'c11', 1);
insert into enroll values('6', 2022, 2, 's11111', 'c13', 1);
insert into enroll values('7', 2022, 2, 's11111', 'c14', 1);

insert into enroll values('8', 2023, 2, 's22222', 'c6', 2);
insert into enroll values('9', 2023, 2, 's33333', 'c2', 1);

insert into liked values('1', 2023, 2, 's11111', 'c1', 1);
insert into liked values('2', 2023, 2, 's22222', 'c2', 1);
insert into liked values('3', 2023, 1, 's33333', 'c3', 1);
insert into liked values('4', 2023, 1, 's11111', 'c4', 1);
insert into liked values('5', 2022, 2, 's22222', 'c5', 1);
insert into liked values('6', 2022, 2, 's33333', 'c6', 1);
