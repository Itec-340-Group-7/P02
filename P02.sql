-- Database I - ITEC 340 Spring 2018
-- Ski Club Schema
--Austin Crockett
--Steven Horton
--Colin Ryan

SET ECHO ON;
set serveroutput on;

DROP table ReserveError;
drop table Payment;
DROP TABLE Condo_Assign;
DROP TABLE SkiClub;
DROP TABLE Condo_Reservation;
DROP TABLE Trip;

CREATE TABLE Trip
(
  TID NUMBER
, Resort  VARCHAR2(25) not null
, Sun_Date date
, City varchar2(15)
, State varchar2(15)
,   CONSTRAINT Trip_PK Primary Key (TID)
);

CREATE TABLE Condo_Reservation
(
  RID varchar(5)
,   TID NUMBER
, Name  VARCHAR2(30) not null
, Unit_NO NUMBER
,   Bldg NUMBER
,   Gender char(1) not null
, CONSTRAINT RID_PK PRIMARY KEY(RID)
, CONSTRAINT Trip_Res Foreign Key (TID) references Trip 
,   Constraint Gen_CK Check (Gender in ('M', 'F'))
);

CREATE TABLE SkiClub
(
  MID     NUMBER
, First        VARCHAR2(16) not null
, Last        Varchar2(20) not null
, Exp_Level   Char(1)
,   Gender      Char(1) not null
, CONSTRAINT  SkiClub_PK PRIMARY KEY(MID)
, CONSTRAINT  Level_Chk CHECK(Exp_Level in ('B', 'I', 'E'))
,   CONSTRAINT  Gender_Chk Check (Gender in ('M', 'F'))
);

CREATE TABLE Condo_Assign
(
  MID NUMBER
,   RID varchar2(5)
, CONSTRAINT  Condo_Assign_PK PRIMARY KEY(MID, RID)
, CONSTRAINT  Condo_Res_FK FOREIGN KEY (RID) REFERENCES Condo_Reservation
,   CONSTRAINT  Ski_Mem_FK Foreign key (MID) references SkiClub
);

CREATE TABLE Payment
(
  MID NUMBER
,   RID varchar2(5)
,   PaymentDate date
, Payment decimal(5,2) 
, CONSTRAINT  Payment_Ski_PK PRIMARY KEY(MID, RID, PaymentDate)
, CONSTRAINT  Trip_Pay_FK FOREIGN KEY (MID, RID) REFERENCES Condo_Assign
,   CONSTRAINT  Ski_Mem_Pay_FK Foreign key (MID) references SkiClub
);

CREATE TABLE ReserveError
(
  MID NUMBER
, RID varchar2(5)
, errorDate date
, errorCode NUMBER(12)
, errorMsg varchar2(50)
, Constraint Error_PK Primary Key (MID, RID, errorDate)
, Constraint Error_FK FOREIGN Key (MID,RID) references Condo_Assign
);

  -- procedure addPayment 
  -- (
  --   P_MID Payment.MID%type
  --   , P_RID Payment.RID%type
  --   , P_Date Payment.PaymentDate%type
  --   , P_Payment Payment.Payment%type
  --   )
  -- is 
  -- Amount_Count NUMBER;
  -- Amount_Debt decimal (5, 2);
  -- Amount_Owed decimal(5, 2);
  -- Payments_Made decimal(5, 2);
  -- begin
  -- Insert into Payment Values (P_MID, P_RID, P_Date, P_Payment);
  -- select Count(MID) into Amount_Count from Payment where MID = P_MID;
  -- Amount_Debt := 100 * Amount_Count;
  -- select sum(payment) into Payments_Made from Payment where MID = P_MID;
  -- Amount_Owed := Amount_Debt - Payments_Made; 
  -- if Amount_Owed
  -- end addPayment;
  -- /

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (100, 'John', 'Snyder', 'I', 'M');

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (600, 'Sally', 'Treville', 'E', 'F');

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (102, 'Gerald', 'Warner', 'I', 'M');

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (104, 'Katie', 'Johnson', 'I', 'F');

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (601, 'Matt', 'Kingston', 'E', 'M');

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (108, 'Tom', 'Rivers', 'I', 'M');

INSERT INTO SkiClub (MID, First, Last, Exp_Level, Gender)
VALUES (109, 'Tom', 'Singleton', 'E', 'M');


INSERT INTO Trip (TID, Resort, Sun_Date, City, State)
VALUES (1, 'Copper Mtn', '21-Jan-18', 'Copper', 'CO');

INSERT INTO Trip (TID, Resort, Sun_Date, City, State)
VALUES (2, 'Heavenly Mtn', '28-Jan-18', 'Lake Tahoo', 'CA');

INSERT INTO Trip (TID, Resort, Sun_Date, City, State)
VALUES (3, 'Squaw Valley', '4-Feb-18', 'Lake Tahoo', 'CA');

INSERT INTO Trip (TID, Resort, Sun_Date, City, State)
VALUES (4, 'Taos Ski Valley', '11-Feb-18', 'Taos', 'NM');


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


INSERT INTO Condo_Assign (MID, RID)
VALUES (100, 'R10');

INSERT INTO Condo_Assign (MID, RID)
VALUES (600, 'R11');

INSERT INTO Condo_Assign (MID, RID)
VALUES (102, 'R10');

INSERT INTO Condo_Assign (MID, RID)
VALUES (104, 'R11');

INSERT INTO Condo_Assign (MID, RID)
VALUES (601, 'R10');

INSERT INTO Condo_Assign (MID, RID)
VALUES (600, 'R13');

INSERT INTO Condo_Assign (MID, RID)
VALUES (104, 'R13');

INSERT INTO Condo_Assign (MID, RID)
VALUES (601, 'R12');

INSERT INTO Condo_Assign (MID, RID)
VALUES (108, 'R12');

INSERT INTO Condo_Assign (MID, RID)
VALUES (109, 'R13');

INSERT INTO Condo_Assign (MID, RID)
VALUES (600, 'R15');

INSERT INTO Condo_Assign (MID, RID)
VALUES (104, 'R15');

INSERT INTO Condo_Assign (MID, RID)
VALUES (108, 'R14');

INSERT INTO Condo_Assign (MID, RID)
VALUES (601, 'R14');

INSERT INTO Condo_Assign (MID, RID)
VALUES (102, 'R14');

INSERT INTO Condo_Assign (MID, RID)
VALUES (600, 'R16');

INSERT INTO Condo_Assign (MID, RID)
VALUES (104, 'R16');

INSERT INTO Condo_Assign (MID, RID)
VALUES (109, 'R16');

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

commit;


select * from Trip;
select * from SkiClub;
select * from Condo_Reservation;
select * from Condo_Assign;
select * from Payment;

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
  procedure addSkiClub
  (
    P_MID SkiClub.MID%type
    , P_First SkiClub.First%type
    , P_Last SkiClub.Last%type
    , P_Exp_Level SkiClub.Exp_Level%type
    , P_Gender SkiClub.Gender%type
    )
  is 
  begin
  Insert into SkiClub Values (P_MID, P_First, P_Last, P_Exp_Level, P_Gender);
  end addSkiClub;
  / 

  create or replace 
  procedure addCondo_Assign
  (
    P_MID Condo_Assign.MID%type
    , P_RID Condo_Assign.RID%type
    ) is 
  Gender_Room_Check Condo_Reservation.Gender%type;
  Member_Gender_Check Condo_Assign.RID%type;
  Count_Chk Condo_Assign.MID%type;
  Gender_Error VARCHAR2 (50) := 'Invalid gender for this room';
  Count_Error VARCHAR2 (50) := 'To many people already assigned to this room';
  begin
  select Count(RID) into Count_Chk from Condo_Assign where RID = P_RID; 

  select Gender into Gender_Room_Check from Condo_Reservation 
  where Condo_Reservation.RID = P_RID;

  select Gender into Member_Gender_Check from SkiClub 
  where SkiClub.MID = P_MID;

    if Gender_Room_Check = Member_Gender_Check AND Count_Chk < 4 then
  Insert into Condo_Assign Values (P_MID, P_RID);
  elsif Count_Chk >= 4 then
   DBMS_OUTPUT.PUT_LINE(Count_Error);
  -- INSERT INTO ReserveError VALUES (P_MID, P_RID, SYSDATE, 1, Count_Error);
  elsif Gender_Room_Check != Member_Gender_Check then 
  DBMS_OUTPUT.PUT_LINE(Gender_Error);
  --INSERT INTO ReserveError VALUES (P_MID, P_RID, SYSDATE, 2, Gender_Error);
  end if;
  end addCondo_Assign;
  /

  DROP balance_ck_trigger; 
  create or replace Trigger balance_ck_trigger
  Before Insert on Payment
  FOR EACH ROW
  Declare 
  sumBalance number;
  begin
  select sum(p.payment)
    into sumBalance
  from Payment p
  where p.MID = :NEW.MID;
 -- DBMS_OUTPUT.PUT_LINE(sumBalance + :New.Payment);
  if sumBalance < -150 then
  DBMS_OUTPUT.PUT_LINE(sumBalance + :New.Payment);
  end if;
  end;
  /

Insert into Payment (MID, RID, PaymentDate, Payment)
Values(109, 'R16', '30-Dec-18', -350.00);


execute addCondo_Assign(100, 'R14');
execute addCondo_Assign(100, 'R17');
execute addCondo_Assign(102, 'R17');
execute addCondo_Assign(601, 'R17');
execute addCondo_Assign(108, 'R17');

execute addCondo_Assign(109, 'R17'); 

execute addCondo_Assign(100, 'R11'); 

ROLLBACK;

select * from Trip;
select * from SkiClub;
select * from Condo_Reservation;
select * from Condo_Assign;
select * from Payment;
select * from ReserveError; 
