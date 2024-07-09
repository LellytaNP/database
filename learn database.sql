use latihan
--soal1
create table books (
bookid char(5) not null, 
booktitle varchar (50) not null,
bookauthor varchar (50) not null,
publicationyear varchar (5),
constraint pk_table_books primary key(bookid));
create table members (
memberid char(5) not null, 
membername varchar (50) not null,
memberphone varchar (15) not null,
memberaddress varchar (100) not null,
memberemail varchar (25) not null,
constraint pk_table_members primary key(memberid));
create table borrows (
borrowid char(5) not null, 
bookid char (5) not null,
memberid char (5) not null,
borrowdate date not null,
duedate date not null,
returndate date,
constraint pk_table_borrows primary key(borrowid),
foreign key (bookid) references books(bookid), 
foreign key (memberid) references members(memberid));

--soal2
alter table books add bookedition varchar(20);

--soal3
--table books
insert into books values('BK000','Algoritma dan Pemrograman','Alisa Carmelia','2020','Edisi Keempat');
insert into books values('BK001','Object-Oriented Programming','Budi Haryanto','2019','Edisi Ketiga');
insert into books values('BK002','Database System','Clarissa Gabriella Susanto','2021','Edisi Kedua');
insert into books values('BK003','Sistem Jaringan','Gian Regiansyah Ibrahim','2021','Edisi Kelima');
--table members
insert into members values('BM000','Sunny Larosa','081298764321','Sudirman Street No.26','sunnyrosa@email.com');
insert into members values('BM001','Michelle Belinda','088153467908','Beringin Street No.81','mbelinda@email.com');
insert into members values('BM002','Gilbert Christopher','085691283746','Palmerah Street No.57','gilbert.c@email.com');
insert into members values('BM003','Diarick Novaldo','081919452812','Grand Palem Street No.99','novaldo.diarick@email.com');
insert into members values('BM004','Timothy Julian','081261279485','Gading Street No.2','timothyjulian@email.com');
--table borrows
insert into borrows values('BW000','BK001','BM002','2021-07-11','2021-07-18','2021-07-17');
insert into borrows values('BW001','BK002','BM000','2021-07-11','2021-07-18','2021-07-21');
insert into borrows values('BW002','BK003','BM004','2021-07-12','2021-07-19','2021-07-16');
insert into borrows values('BW003','BK002','BM003','2021-07-12','2021-07-19','2021-07-25');
insert into borrows values('BW004','BK000','BM001','2021-07-14','2021-07-21','2021-07-19');

--soal4
UPDATE members SET memberphone = stuff (memberphone,1,1,'+62') WHERE memberid='BM000';
UPDATE members SET memberphone = stuff (memberphone,1,1,'+62') WHERE memberid='BM001';
UPDATE members SET memberphone = stuff (memberphone,1,1,'+62') WHERE memberid='BM002';
UPDATE members SET memberphone = stuff (memberphone,1,1,'+62') WHERE memberid='BM003';
UPDATE members SET memberphone = stuff (memberphone,1,1,'+62') WHERE memberid='BM004';

--soal5
--menghitung jumlah denda
select b.borrowid,a.membername,b.booktitle,b.duedate,b.returndate,'Rp.'+ cast(b.lamaterlambat*5000 as varchar) as fine from members as a join(
select y.booktitle,x.borrowid,x.memberid,x.bookid,x.duedate,x.returndate,DateDiff (Day,duedate,returndate) as lamaterlambat from borrows as x inner join books as y
on x.bookid=y.bookid)
as b on a.memberid=b.memberid
where b.lamaterlambat> 1;
select * from borrows;
select * from books;
select * from members;

--mencari nama member yang mengembalikan tepat waktu
select *,DateDiff (Day,duedate,returndate) from borrows;
select * from members where memberid in (
select memberid from borrows where DateDiff (Day,duedate,returndate)<1)

--mencari buku yang sering dipinjam
select * from books where bookid in(
select distinct bookid from borrows)