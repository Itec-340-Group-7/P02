--Austin Crockett 
--Steven Horton
-- Colin Ryan
--ITEC 340

SET Echo ON;
set serveroutput ON;
drop table Enroll;
drop table Class;
drop table Student;
drop table Instructor;
create table Trip (
	TID number(1) NOT NULL
  , Resort varchar2(30) 
  , Sun_Date Date
  , City varchar2(30)
  , State varchar2(2)
  , Constraint PK_Trip Primary Key(TID)
  );
create table Condo_Reservation (
	RID varchar2(10) NOT NULL
  , TID varchar2(30) NOT NULL
  , Name varchar2(30) 
  , Unit_NO number(7) 
  , Bldg number(2)
  , Gender char(1)
  , Constraint PK_Condo_Res Primary Key(RID)
  , Constraint FK_Condo_Res Foreign Key(TID) REFERENCES Trip(TID)
  );
create table SkiClub (
	MID number(5) NOT NULL
  , First varchar2(15)
  , Last varchar2(20)
  , Exp_Level char(1)
  , Gender char(1)
  , Constraint PK_Class Primary Key(MID)
  );
create table Condo_Assign (
  MID number(5) 
  , RID varchar2(10)
  );
create table Payment (
   MID number(5) 
  , RID varchar2(10)
  , PaymentDate Date
  , Payment number(7,2)
  );

--Done by Steven
--INSERT INTO Trip VALUES();

--INSERT INTO Condo_Reservation VALUES();

--INSERT INTO SkiClub VALUES();

--INSERT INTO Condo_Assign VALUES();

--INSERT INTO Payment VALUES();
