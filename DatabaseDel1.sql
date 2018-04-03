--Austin Crockett 
--Steven Horton
-- Colin Ryan
--ITEC 340

SET Echo ON;
SET serveroutput ON;
SET Linesize 100;

drop table Trip;
drop table Condo_Reservation;
drop table SkiClub;
drop table Condo_Assign;
drop table Payment;
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
--trip insert
INSERT INTO Trip VALUES(1, 'Copper Mtn',  TO_DATE('01/21/2018', 'MM/DD/YYYY'), 'Copper',  'CO');
INSERT INTO Trip VALUES(2, 'Heavenly Mtn',  TO_DATE('01/28/2018', 'MM/DD/YYYY'), 'Lake Tahoo',  'CA');
INSERT INTO Trip VALUES(3, 'Squaw Valley',  TO_DATE('02/04/2018', 'MM/DD/YYYY'),  'Lake Tahoo',  'CA');
INSERT INTO Trip VALUES(4, 'Taos Ski Valley', TO_DATE('02/11/2018', 'MM/DD/YYYY'), 'Taos',  'NM');


--INSERT INTO Condo_Reservation VALUES();

--INSERT INTO SkiClub VALUES();

--INSERT INTO Condo_Assign VALUES();

--INSERT INTO Payment VALUES();
SELECT * FROM Trip;
