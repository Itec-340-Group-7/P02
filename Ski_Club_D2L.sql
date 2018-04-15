-- Database I - ITEC 340 Spring 2018
-- Ski Club Schema

SET ECHO ON;
set serveroutput on;
set linesize 100;
drop table Payment;
DROP TABLE Condo_Assign;
DROP TABLE Condo_Reservation;
DROP TABLE SkiTeam;
DROP TABLE Trip;
-- DROP TRIGGER overLimitTrigger;

CREATE TABLE Trip
(
	TID	NUMBER
,	Resort	VARCHAR2(25) not null
,	Sun_Date date
,	City varchar2(15)
,	State varchar2(15)
,   CONSTRAINT Trip_PK Primary Key (TID)
);

CREATE TABLE Condo_Reservation
(
	RID varchar(5)
,   TID NUMBER
,	Name	VARCHAR2(30) not null
,	Unit_NO NUMBER
,   Bldg NUMBER
,   Gender char(1) not null
,	CONSTRAINT RID_PK PRIMARY KEY(RID)
,	CONSTRAINT Trip_Res Foreign Key (TID) references Trip 
,   Constraint Gen_CK Check (Gender in ('M', 'F'))
);

CREATE TABLE SkiTeam
(
	MID			NUMBER
,	First        VARCHAR2(16) not null
,	Last   	    Varchar2(20) not null
,	Exp_Level   Char(1)
,   Gender      Char(1) not null
,	Balance_Owed decimal(5,2) 
,	CONSTRAINT  SkiClub_PK PRIMARY KEY(MID)
,	CONSTRAINT  ELevel_CK_Ski CHECK(Exp_Level in ('B', 'I', 'E'))
,   CONSTRAINT  Gen_SkiClub_CK Check (Gender in ('M', 'F'))
);

CREATE TABLE Condo_Assign
(
	MID NUMBER
,   RID varchar2(5)
,	Deposit decimal(5,2) 
,	CONSTRAINT  Condo_Assign_PK PRIMARY KEY(MID, RID)
,	CONSTRAINT  Condo_Res_FK FOREIGN KEY (RID) REFERENCES Condo_Reservation
,   CONSTRAINT  Ski_Mem_FK Foreign key (MID) references SkiTeam
);

CREATE TABLE Payment
(
	MID NUMBER
,   RID varchar2(5)
,   PaymentDate date
,	Payment decimal(5,2) 
,	CONSTRAINT  Payment_Ski_PK PRIMARY KEY(MID, RID, PaymentDate)
,	CONSTRAINT  Trip_Pay_FK FOREIGN KEY (MID, RID) REFERENCES Condo_Assign
,   CONSTRAINT  Ski_Mem_Pay_FK Foreign key (MID) references SkiTeam
);

commit;

create or replace 
	procedure addTrip 
	(
		P_TID Trip.TID%type
	  , P_Resort Trip.Resort%type
	  , P_Sun_Date Trip.Sun_Date%type
	  , P_City Trip.City%type
	  , P_State Trip.State%type
		)
	is 
	begin
	Insert into Trip Values (P_TID, P_Resort, P_Sun_Date, P_City, P_State);
	end addTrip;
	/

	create or replace 
	procedure addSkiTeam
	(
		P_MID SkiTeam.MID%type
	  , P_First SkiTeam.First%type
	  , P_Last SkiTeam.Last%type
	  , P_Exp_Level SkiTeam.Exp_Level%type
	  , P_Gender SkiTeam.Gender%type
	  , P_Balance_Owed SkiTeam.Balance_Owed%type
		)
	is 
	begin
	Insert into SkiTeam Values (P_MID, P_First, P_Last, P_Exp_Level, P_Gender, P_Balance_Owed);
	end addSkiTeam;
	/

	create or replace 
	procedure addCondo_Assign
	(
		P_MID Condo_Assign.MID%type
	  , P_RID Condo_Assign.RID%type
	  , P_Deposit Condo_Assign.Deposit%type 
	  ) is 
	Gender_Room_Check Condo_Reservation.Gender%type;
	Member_Gender_Check Condo_Assign.RID%type;
	Count_Chk Condo_Assign.MID%type;
	begin
	select Count(RID) into Count_Chk from Condo_Assign where RID = P_RID; 

	select Gender into Gender_Room_Check from Condo_Reservation 
	where Condo_Reservation.RID = P_RID;

	select Gender into Member_Gender_Check from SkiTeam 
	where SkiTeam.MID = P_MID;

    if Gender_Room_Check = Member_Gender_Check AND Count_Chk < 4 then
	Insert into Condo_Assign Values (P_MID, P_RID, P_Deposit);
	else 
	DBMS_OUTPUT.PUT_LINE('Invalid gender for this room');
	-- elsif Count_Chk >= 4 then
	-- DBMS_OUTPUT.PUT_LINE('To many people already assigned to this room');
	end if;
	end addCondo_Assign;
	/

	-- CREATE OR REPLACE TRIGGER overLimitTrigger 
	-- BEFORE Insert on Condo_Reservation
	-- FOR EACH ROW
	-- begin
	-- DECLARE Bal_Owed_Chk decimal(5,2);
	-- 	select Balance_Owed into Bal_Owed_Chk
	-- 	from SkiTeam
	-- 	where MID = :new.MID;
	-- 	if Bal_Owed_Chk > 150 then
	-- 	DBMS_OUTPUT.PUT_LINE('You have too much owed to join this trip');
	-- 	else 
	-- 	DBMS_OUTPUT.PUT_LINE('Congrats you have joined the trip');
	-- 	end if;
	-- end overLimitTrigger;
	-- /

execute addSkiTeam(100, 'John', 'Snyder', 'I', 'M', 50);

execute addSkiTeam(600, 'Sally', 'Treville', 'E', 'F', 50);

execute addSkiTeam(102, 'Gerald', 'Warner', 'I', 'M', 50);

execute addSkiTeam(104, 'Katie', 'Johnson', 'I', 'F', 50);

execute addSkiTeam(601, 'Matt', 'Kingston', 'E', 'M', 50);

execute addSkiTeam(108, 'Tom', 'Rivers', 'I', 'M', 50);

execute addSkiTeam(109, 'Tom', 'Singleton', 'E', 'M', 50);


execute addTrip(1, 'Copper Mtn', '21-Jan-18', 'Copper', 'CO');

execute addTrip(2, 'Heavenly Mtn', '28-Jan-18', 'Lake Tahoo', 'CA');

execute addTrip(3, 'Squaw Valley', '4-Feb-18', 'Lake Tahoo', 'CA');

execute addTrip(4, 'Taos Ski Valley', '11-Feb-18', 'Taos', 'NM');


INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R10', 1, 'Lewis Ranch', 320, 3, 'M');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R11', 1, 'Lewis Ranch', 321, 3, 'F');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R12', 2, 'Heavenly Village', 304, 2, 'M');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R13', 2, 'Heavenly Village', 284, 1, 'F');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R14', 3, 'South Shore', 262, 1, 'M');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R15', 3, 'South Shore', 263, 4, 'F');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R16', 4, 'Cozy Mtn', 301, 3, 'F');

INSERT INTO Condo_Reservation (RID, TID, Name, Unit_NO, Bldg, Gender)
VALUES ('R17', 4, 'Cozy Mtn', 302, 3, 'M');


execute addCondo_Assign(100, 'R10', 50);

execute addCondo_Assign(600, 'R11', 50);

execute addCondo_Assign(102, 'R10', 50);

execute addCondo_Assign(104, 'R11', 50);

execute addCondo_Assign(601, 'R10', 50);

execute addCondo_Assign(600, 'R13', 50);

execute addCondo_Assign(104, 'R13', 50);

execute addCondo_Assign(601, 'R12', 50);

execute addCondo_Assign(108, 'R12', 50);

execute addCondo_Assign(109, 'R13', 50);

execute addCondo_Assign(600, 'R15', 50);

execute addCondo_Assign(104, 'R15', 50);

execute addCondo_Assign(108, 'R14', 50);

execute addCondo_Assign(601, 'R14', 50);

execute addCondo_Assign(102, 'R14', 50);

execute addCondo_Assign(600, 'R16', 50);

execute addCondo_Assign(104, 'R16', 50);

execute addCondo_Assign(109, 'R16', 50);

execute addCondo_Assign(109, 'R16', 50);

execute addCondo_Assign(109, 'R16', 50);



Insert into Payment (MID, RID, PaymentDate, Payment)
Values(100, 'R10', '3-Jan-18', 100.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(600, 'R11', '4-Jan-18', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(600, 'R11', '10-Jan-18', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(102, 'R10', '28-Dec-17', 75.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(104, 'R11', '21-Dec-17', 75.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(104, 'R11', '28-Dec-17', 25.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(601, 'R10', '3-Jan-18', 75.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(600, 'R13', '15-Dec-17', 100.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(104, 'R13', '14-Dec-17', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(601, 'R12', '30-Dec-17', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(108, 'R12', '3-Dec-17', 75.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(109, 'R13', '24-Dec-17', 100.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(600, 'R15', '2-Jan-18', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(104, 'R15', '3-Jan-18', 75.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(108, 'R14', '8-Jan-18', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(601, 'R14', '2-Dec-17', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(102, 'R14', '8-Dec-17', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(600, 'R16', '5-Jan-18', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(104, 'R16', '8-Jan-18', 50.00);

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(109, 'R16', '30-Dec-17', 50.00);

COMMIT; 

select * from Trip;
select * from SkiTeam;
select * from Condo_Reservation;
select * from Condo_Assign;
select * from Payment;
