
/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board
(
	num number primary key,
	title varchar2(200) NOT NULL,
	content varchar2(2000) NOT NULL,
	id varchar2(10) NOT NULL,
	postdate date default sysdate NOT NULL,
	visitcount number(6)
);


CREATE TABLE member
(
	id varchar2(10) NOT NULL,
	pass varchar2(10) NOT NULL,
	name varchar2(30) NOT NULL,
	regidate date default sysdate NOT NULL
	primary key (id)
);


alter table board
	add constraint board_mem_fk 
	foreign key (id)
	references member (id);


