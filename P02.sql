  -- Database I - ITEC 340 Spring 2018
  -- Ski Club Schema
  --Austin Crockett 1/3 of the SP and half the trigger
  --Steven Horton 1/3 of the SP and half of the trigger
  --Colin Ryan 1/3 of the SP and the DML to test all procedures and triggers
  --We were able to complete every part of the assignment except for stopping the insertion
  --on the condo assign and payment tables. We thought the application errors would hault it
  --but were ultimately unable to figure it out.


  SET ECHO ON;
  set serveroutput on;
  Set linesize 100;
  DROP table ReserveError;
  drop table Payment;
  DROP TABLE Condo_Assign;
  DROP TABLE SkiClub;
  DROP TABLE Condo_Reservation;
  DROP TABLE Trip;
  DROP SEQUENCE error_seq;
  DROP TRIGGER balance_ck_trigger;

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
    Seq NUMBER
  , MID NUMBER
  , RID varchar2(5)
  , errorDate date
  , errorCode NUMBER(12)
  , errorMsg varchar2(50)
  , Constraint Error_PK Primary Key (Seq)
  , Constraint MID_FK FOREIGN Key (MID) references SkiClub
  , Constraint RID_FK FOREIGN Key (RID) references Condo_Reservation
  );

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

    execute addTrip(5, 'Radford Mtn', SYSDATE, 'Radford', 'VA');

    create or replace 
    procedure addCondo
    (
      P_RID Condo_Reservation.RID%type
      , P_TID Condo_Reservation.TID%type
      , P_Name Condo_Reservation.Name%type
      , P_Unit_NO Condo_Reservation.Unit_NO%type
      , P_Bldg Condo_Reservation.Bldg%type
      , P_Gender Condo_Reservation.Gender%type
      )
    is 
    Duplicate_Condo_Check NUMBER;
    begin
    select Count(RID) into Duplicate_Condo_Check from Condo_Reservation 
    where RID = P_RID AND Unit_NO = P_Unit_NO AND Bldg = P_Bldg;
    if Duplicate_Condo_Check > 0 then
    DBMS_OUTPUT.PUT_LINE('This is already a condo in the club');
    else
    Insert into Condo_Reservation Values (P_RID, P_TID, P_Name, P_Unit_NO, P_Bldg, P_Gender);
    end if;
    end addCondo;
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

    execute addSkiClub(666, 'Austin', 'Crockett', 'B', 'M');
     execute addSkiClub(777, 'Colin', 'Ryan', 'B', 'M');
      execute addSkiClub(888, 'Steven', 'Horton', 'B', 'M');

    create or replace 
    procedure addCondo_Assign
    (
      P_MID Condo_Assign.MID%type
      , P_RID Condo_Assign.RID%type
      ) is 
    begin
    Insert into Condo_Assign Values (P_MID, P_RID);
    INSERT into payment values(P_MID, P_RID, SYSDATE, 50.00);
    end addCondo_Assign;
    /

    create sequence error_seq start with 1 increment by 1;

     create or replace Trigger balance_ck_trigger
  Before Insert on Payment
  FOR EACH ROW
  Declare 
  paidAmount number;
  totalOwed number;
  roomCount number;
  Gender_Room_Check Condo_Reservation.Gender%type;
  Member_Gender_Check Condo_Reservation.Gender%type;
  Gender_Error VARCHAR2 (50) := 'Invalid gender for this room';
  Count_Error VARCHAR2 (50) := 'To many people already assigned to this room';
  Balance_Error varchar(50) := 'You owe over 150 dollars';
  Balance_Number NUMBER := -20000;
  Gender_Number NUMBER := -20001;
  Count_Number NUMBER := -20002;
  begin

  select sum(p.payment)
  into paidAmount
  from Payment p
  where p.MID = :NEW.MID ;

 select count (p.rid)
 into roomCount
 from Payment p
 where p.rid = :NEW.RID;

 select count(ca.MID)
 into totalOwed
 from Condo_Assign ca
 where ca.MID = :NEW.MID;

 select Gender into Gender_Room_Check from Condo_Reservation 
 where Condo_Reservation.RID = :new.RID;

 select Gender into Member_Gender_Check from SkiClub 
 where SkiClub.MID = :new.MID;

  if ((totalOwed * 100)-(paidAmount + :New.Payment) > 150) 
    then
    DBMS_OUTPUT.PUT_LINE(Balance_Error);
      insert into ReserveError(SEQ, MID, RID, errorDate, errorCode, errorMsg) values (error_seq.nextval, :NEW.MID, :New.RID, SYSDATE, Balance_Number, Balance_Error);
     RAISE_APPLICATION_ERROR(Balance_Number, Balance_Error);
 end if;

  if Gender_Room_Check != Member_Gender_Check then 
      DBMS_OUTPUT.PUT_LINE(Gender_Error);
      INSERT INTO ReserveError VALUES (error_seq.nextVal, :new.MID, :new.RID, SYSDATE, Gender_Number, Gender_Error);
      RAISE_APPLICATION_ERROR(Gender_Number, Gender_Error);
  end if;

  if (roomCount > 3)
    then
    DBMS_OUTPUT.PUT_LINE(Count_Error);
      insert into ReserveError(SEQ, MID, RID, errorDate, errorCode, errorMsg) values (error_seq.nextval, :NEW.MID, :New.RID, SYSDATE, Count_Number, Count_Error);
      RAISE_APPLICATION_ERROR(Count_Number, Count_Error);
  end if;

  exception when others then null;
  end;
  /


  execute addCondo_Assign(666, 'R10');
  execute addCondo_Assign(666, 'R12');
  execute addCondo_Assign(100, 'R14');
  execute addCondo_Assign(100, 'R17');
  execute addCondo_Assign(102, 'R17');
  execute addCondo_Assign(601, 'R17');
  execute addCondo_Assign(108, 'R17');

  execute addCondo_Assign(109, 'R17'); 

  execute addCondo_Assign(100, 'R11'); 

  execute addCondo('R10', 1, 'Lewis Ranch', 320, 3, 'M');
  execute addCondo('R18', 4, 'Cozy Mtn', 330, 4, 'F');

  select * from Trip;
  select * from SkiClub;
  select * from Condo_Reservation;
  select * from Condo_Assign;
  select * from Payment;
  select * from ReserveError;

  ROLLBACK;
