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
    TID number(3) NOT NULL
  , Resort varchar2(30) 
  , Sun_Date Date
  , City varchar2(30)
  , State varchar2(2)
  --, Constraint PK_Trip Primary Key(TID)
  );

create table Condo_Reservation (
    RID varchar2(10) NOT NULL
  , TID number(3) NOT NULL
  , Name varchar2(30) 
  , Unit_NO number(7) 
  , Bldg number(2)
  , Gender char(1)
  , Constraint PK_Condo_Res Primary Key(RID, TID)
  --, Constraint FK_Condo_Res Foreign Key(TID) REFERENCES Trip(TID)
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
    MID number(5) NOT NULL
  , RID varchar2(10) NOT NULL
  , Constraint PK_Condo_Assign Primary Key (MID, RID)
 -- , Constraint FK_Condo_MID Foreign Key (MID) REFERENCES SkiClub(MID)
 -- , Constraint FK_Condo_RID Foreign Key (RID) REFERENCES Condo_Reservation(RID)
  );

create table Payment (
    MID number(5) NOT NULL
  , RID varchar2(10) NOT NULL
  , PaymentDate Date
  , Payment number(7,2)
 -- , Constraint PK_Payment Primary Key (MID, RID)
  );

--trip insert
INSERT INTO Trip VALUES(1, 'Copper Mtn',  TO_DATE('01/21/2018', 'MM/DD/YYYY'), 'Copper',  'CO');
INSERT INTO Trip VALUES(2, 'Heavenly Mtn',  TO_DATE('01/28/2018', 'MM/DD/YYYY'), 'Lake Tahoo',  'CA');
INSERT INTO Trip VALUES(3, 'Squaw Valley',  TO_DATE('02/04/2018', 'MM/DD/YYYY'),  'Lake Tahoo',  'CA');
INSERT INTO Trip VALUES(4, 'Taos Ski Valley', TO_DATE('02/11/2018', 'MM/DD/YYYY'), 'Taos',  'NM');


--Condo reservation insert
INSERT INTO Condo_Reservation VALUES('R10', 1,  'Lewis Ranch',  320,  3,  'M');
INSERT INTO Condo_Reservation VALUES('R11', 1,  'Lewis Ranch',  321,  3,  'F');
INSERT INTO Condo_Reservation VALUES('R12', 2,  'Heavenly Village', 304,  2,  'M');
INSERT INTO Condo_Reservation VALUES('R13', 2,  'Heavenly Village', 284,  1,  'F');
INSERT INTO Condo_Reservation VALUES('R14', 3,  'South Shore',  262,  1,  'M');
INSERT INTO Condo_Reservation VALUES('R15', 3,  'South Shore',  263,  4,  'F');
INSERT INTO Condo_Reservation VALUES('R16', 4,  'Cozy Mtn', 301,  3,  'F');
INSERT INTO Condo_Reservation VALUES('R17', 4,  'Cozy Mtn', 302,  3,  'M');

-- skiclub insert
INSERT INTO SkiClub VALUES(100, 'John', 'Snyder',  'I',  'M');
INSERT INTO SkiClub VALUES(600, 'Sally', 'Treville',  'E',  'F');
INSERT INTO SkiClub VALUES(102, 'Gerald', 'Warner',  'I',  'M');
INSERT INTO SkiClub VALUES(104, 'Katie', 'Johnson',  'I',  'F');
INSERT INTO SkiClub VALUES(601, 'Matt', 'Kingston',  'E',  'M');
INSERT INTO SkiClub VALUES(108, 'Tom', 'Rivers',  'I',  'M');
INSERT INTO SkiClub VALUES(109, 'Tom', 'Singleton',  'E',  'M');

--Condo rooms insert
INSERT INTO Condo_Assign VALUES(100, 'R10');
INSERT INTO Condo_Assign VALUES(600, 'R11');
INSERT INTO Condo_Assign VALUES(102, 'R10');
INSERT INTO Condo_Assign VALUES(104, 'R11');
INSERT INTO Condo_Assign VALUES(601, 'R10');
INSERT INTO Condo_Assign VALUES(600, 'R13');
INSERT INTO Condo_Assign VALUES(104, 'R13');
INSERT INTO Condo_Assign VALUES(601, 'R12');
INSERT INTO Condo_Assign VALUES(108, 'R12');
INSERT INTO Condo_Assign VALUES(109, 'R13');
INSERT INTO Condo_Assign VALUES(600, 'R15');
INSERT INTO Condo_Assign VALUES(104, 'R15');
INSERT INTO Condo_Assign VALUES(108, 'R14');
INSERT INTO Condo_Assign VALUES(601, 'R14');
INSERT INTO Condo_Assign VALUES(102, 'R14');
INSERT INTO Condo_Assign VALUES(600, 'R16');
INSERT INTO Condo_Assign VALUES(104, 'R16');
INSERT INTO Condo_Assign VALUES(109, 'R16');

--payment insert
INSERT INTO Payment VALUES(100, 'R10', TO_DATE('01/03/2018', 'MM/DD/YYYY'),  100.00);
INSERT INTO Payment VALUES(600, 'R11', TO_DATE('01/04/2018', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(600, 'R11', TO_DATE('01/10/2018', 'MM/DD/YYYY'), 50.00);
INSERT INTO Payment VALUES(102, 'R10', TO_DATE('12/28/2017', 'MM/DD/YYYY'),  75.00);
INSERT INTO Payment VALUES(104, 'R11', TO_DATE('12/21/2017', 'MM/DD/YYYY'),  75.00);
INSERT INTO Payment VALUES(104, 'R11', TO_DATE('12/29/2017', 'MM/DD/YYYY'),  25.00);
INSERT INTO Payment VALUES(601, 'R10', TO_DATE('01/03/2018', 'MM/DD/YYYY'),  75.00);
INSERT INTO Payment VALUES(600, 'R13', TO_DATE('12/15/2017', 'MM/DD/YYYY'),  100.00);
INSERT INTO Payment VALUES(104, 'R13', TO_DATE('12/14/2017', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(601, 'R12', TO_DATE('12/30/2017', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(108, 'R12', TO_DATE('12/03/2017', 'MM/DD/YYYY'), 75.00);
INSERT INTO Payment VALUES(109, 'R13', TO_DATE('12/24/2017', 'MM/DD/YYYY'),  100.00);
INSERT INTO Payment VALUES(600, 'R15', TO_DATE('01/02/2018', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(104, 'R15', TO_DATE('01/03/2018', 'MM/DD/YYYY'),  75.00);
INSERT INTO Payment VALUES(108, 'R14', TO_DATE('01/08/2018', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(601, 'R14', TO_DATE('12/02/2017', 'MM/DD/YYYY'), 50.00);
INSERT INTO Payment VALUES(102, 'R14', TO_DATE('12/08/2017', 'MM/DD/YYYY'), 50.00);
INSERT INTO Payment VALUES(600, 'R16', TO_DATE('01/05/2018', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(104, 'R16', TO_DATE('01/08/2018', 'MM/DD/YYYY'),  50.00);
INSERT INTO Payment VALUES(109, 'R16', TO_DATE('12/30/2017', 'MM/DD/YYYY'),  50.00);

SELECT * FROM Trip;
SELECT * FROM Condo_Reservation;
SELECT * FROM SkiClub;
SELECT * FROM Condo_Assign;
SELECT * FROM Payment;
