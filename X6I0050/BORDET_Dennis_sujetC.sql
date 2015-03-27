﻿-- @solution_groupC
set pagesize 100
set linesize 100

spool solution_sujetC.log

prompt 601A
prompt DENNIS BORDET
prompt L3_2
prompt
prompt Suppression des tables car ce script sera réexécuté plusieurs fois

DROP TABLE VolsTP CASCADE CONSTRAINTS;
DROP TABLE ReservationsTP CASCADE CONSTRAINTS;
DROP TABLE TrajetsTP CASCADE CONSTRAINTS;

-- création tables

prompt Creation table VolsTP 

-- table VolsTP
CREATE TABLE VolsTP (
	id_vol          NUMBER(5),
	nom_compagnie	VARCHAR2(15),
	type_avion	VARCHAR2(10),
	destination	VARCHAR2(10),
	date_depart     DATE
);

prompt Creation table ReservationsTP 

-- table ReservationsTP
CREATE TABLE ReservationsTP (
	id_reserv       NUMBER(4),
	id_vol	        NUMBER(5),
	nom_reserv	VARCHAR2(20),
	prix_reserv     NUMBER(5),
    date_reserv     DATE
);

prompt Creation table TrajetsTP 

-- table TrajetsTP
CREATE TABLE TrajetsTP (
	destination	VARCHAR2(10),
	id_compagnie	VARCHAR2(15),
	type_classe	VARCHAR2(1),
	type_vol 	VARCHAR2(1),
	prix_billet	NUMBER(5)
);

prompt Population des tables VolsTP, ReservationsTP et TrajetsTP
-- population tables

INSERT INTO VolsTP VALUES (00001,'airFrance','boeing','Berlin',to_date('2015/10/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00002,'aeagean','airbus','Paris',to_date('2015/10/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00003,'luftansa','boeing','Moscow',to_date('2015/10/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00004,'airFrance','boeing','London',to_date('2015/10/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00005,'lufthansa','boeing','London',to_date('2015/11/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00006,'lufthansa','airbus','Rome',to_date('2015/11/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00007,'aeagean','boeing','London',to_date('2015/12/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00008,'airFrance','boeing','London',to_date('2015/12/03','yyyy/mm/dd'));
INSERT INTO VolsTP VALUES (00009,'airFrance','boeing','Rome',to_date('2015/12/03','yyyy/mm/dd'));

SELECT * FROM VolsTP;

INSERT INTO TrajetsTP VALUES ('paris','aeagean','B','L',788);
INSERT INTO TrajetsTP VALUES ('paris','luftansa','A','R',1205);
INSERT INTO TrajetsTP VALUES ('paris','luftansa','B','R',620);
INSERT INTO TrajetsTP VALUES ('paris','airFrance','B','L',580);
INSERT INTO TrajetsTP VALUES ('paris','airFrance','A','R',1430);
INSERT INTO TrajetsTP VALUES ('Berlin','luftansa','B','L',810);
INSERT INTO TrajetsTP VALUES ('Berlin','aeagean','A','R',1120);
INSERT INTO TrajetsTP VALUES ('Berlin','aeagean','B','R',670);
INSERT INTO TrajetsTP VALUES ('Berlin','airFrance','B','L',510);
INSERT INTO TrajetsTP VALUES ('Berlin','airFrance','A','R',1290);
INSERT INTO TrajetsTP VALUES ('Moscow','luftansa','B','L',710);
INSERT INTO TrajetsTP VALUES ('Moscow','aeagean','A','R',1900);
INSERT INTO TrajetsTP VALUES ('Moscow','aeagean','B','R',612);
INSERT INTO TrajetsTP VALUES ('Moscow','airFrance','B','L',519);
INSERT INTO TrajetsTP VALUES ('Rome','airFrance','A','R',1810);
INSERT INTO TrajetsTP VALUES ('Rome','airFrance','B','R',600);
INSERT INTO TrajetsTP VALUES ('Rome','luftansa','B','L',501);
INSERT INTO TrajetsTP VALUES ('London','luftansa','B','R',777);
INSERT INTO TrajetsTP VALUES ('London','airFrance','A','R',1025);
INSERT INTO TrajetsTP VALUES ('London','airFrance','B','R',607);
INSERT INTO TrajetsTP VALUES ('London','aeagean','A','R',1211);
INSERT INTO TrajetsTP VALUES ('London','luftansa','A','R',1671);

SELECT * FROM TrajetsTP;

INSERT INTO ReservationsTP VALUES (0001,00006,'JohnSmith',502,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0002,00001,'NicolMenza',510,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0003,00009,'LuceDickinson',1810,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0004,00002,'MariaLohan',788,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0005,00009,'GeorgesMicheal',600,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0006,00001,'JamesHeitfield',1290,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0007,00008,'DaveMustaine',1025,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0008,00002,'EfiKuriakou',788,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0009,00003,'ALexandraStan',710,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0010,00004,'InnaLazopoulou',1025,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0011,00004,'NikosAliagas',1025,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0012,00002,'NikitaAlexis',788,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0013,00006,'JamesIvory',500,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0014,00001,'ParisAparis',510,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0015,00008,'NicolaAnelka',628,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0016,00001,'YannisAyiannis',1290,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0017,00007,'CaptainHaddock',1211,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0018,00009,'BiancaChastaphiore',600,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0019,00001,'ChrisBroderick',510,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0020,00003,'SteveHarris',710,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0021,00001,'SerjTankian',510,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0022,00007,'NicolSmith',1211,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0023,00002,'JackSparrow',788,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0024,00004,'NicolMenza',607,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0025,00009,'JacobJackson',1810,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0026,00001,'JackNicolson',510,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0027,00001,'LebronJames',1290,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0028,00003,'PolyPapakostopoulou',710,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0029,00004,'SaraParker',628,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0030,00005,'JoyTribiani',1671,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0031,00001,'LucyKalas',510,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0032,00005,'JohnSmith',777,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0033,00001,'JamesIvory',1290,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0034,00002,'NickChastaphiore',788,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0035,00001,'LuckyLook',1290,to_date('2015/04/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0036,00005,'RantaPlan',1671,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0037,00009,'BoyGeorges',1810,to_date('2015/07/02','yyyy/mm/dd'));
INSERT INTO ReservationsTP VALUES (0038,00006,'NicolMarrow',501,to_date('2015/04/02','yyyy/mm/dd'));

SELECT * FROM ReservationsTP;

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 1 *****************************
prompt *************************************************************
prompt Tests des contraintes sur les tables

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 2*****************************
prompt *************************************************************
prompt Requêtes

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 3*****************************
prompt *************************************************************
prompt Modification de la table ReservationsTP

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 4*****************************
prompt *************************************************************
prompt Création du trigger

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 5*****************************
prompt *************************************************************
prompt Creation d un role et affectations des droits

prompt
prompt
prompt *************************************************************
prompt ********************BONUS QUESTION 6*****************************
prompt *************************************************************
prompt Ameliorations des performances & Plan d execution d une requete

spool off