spool tp1.log
set serveroutput on
linesize 500;

DROP TABLE Achats CASCADE CONSTRAINTS;
DROP TABLE Avis CASCADE CONSTRAINTS;
DROP TABLE Livres CASCADE CONSTRAINTS;
DROP TABLE Clients CASCADE CONSTRAINTS;
CREATE TABLE Clients(
    idcl NUMBER  NOT NULL,
    nom VARCHAR2(20),            
    pren VARCHAR2(15),
    adr VARCHAR2(30),
    tel VARCHAR2(12),
    PRIMARY KEY(idcl));

CREATE TABLE Livres(
    refl  VARCHAR2(10) NOT NULL,
    titre VARCHAR2(20),            
    auteur VARCHAR2(20),
    genre VARCHAR2(15),
    PRIMARY KEY(refl));

CREATE TABLE Achats(
    idcl NUMBER NOT NULL,
    refl  VARCHAR2(10) NOT NULL,           
    dateachat  DATE check(dateachat between to_date('01-jan-2008', 'DD-MON-YYYY') and to_date('31-dec-2013', 'DD-MON-YYYY')) NOT NULL,
    PRIMARY KEY(dateachat),
    FOREIGN KEY (idcl) REFERENCES Clients(idcl),
    FOREIGN KEY (refl) REFERENCES Livres(refl));
    
CREATE TABLE Avis(
    idcl NUMBER  NOT NULL,
    refl  VARCHAR2(10) NOT NULL,           
    note NUMBER(4,2),
    commentaire VARCHAR2(50),
    FOREIGN KEY (idcl) REFERENCES Clients(idcl),
    FOREIGN KEY (refl) REFERENCES Livres(refl));



INSERT INTO Clients VALUES
 (001, 'A', 'A', 'A', 061);
INSERT INTO Clients VALUES
 (002,'A', 'B', 'A', 062);
INSERT INTO Clients VALUES
 (003,'B', 'B', 'B', 063);
INSERT INTO Clients VALUES
 (004,'B', 'C', 'C', 064);
 
 
 INSERT INTO Livres VALUES
 ('001', 'x', 'A', 'u');
  INSERT INTO Livres VALUES
 ('002','y', 'B', 'v');
  INSERT INTO Livres VALUES
 ('003','z', 'B', 'w');
 
 
 INSERT INTO Achats VALUES
 (001, '001', '10-may-2013');
 INSERT INTO Achats VALUES
 (002, '001', '11-may-2013');
 INSERT INTO Achats VALUES
 (003, '001', '13-may-2013');
 INSERT INTO Achats VALUES
 (004, '001', '13-jun-2012');
  
 INSERT INTO Achats VALUES
 (001, '002', '14-may-2013');
 INSERT INTO Achats VALUES
 (002, '002', '15-may-2013');
 
  INSERT INTO Achats VALUES
 (003, '003', '10-jun-2012');

 INSERT INTO Avis VALUES
 (001, '001', 20, 'trop bon XD');
 INSERT INTO Avis VALUES
 (002, '001', 10, 'mouais');
 INSERT INTO Avis VALUES
 (003, '001', 0, 'nul');
 
  INSERT INTO Avis VALUES
 (001, '002', 18, 'pas mal');
 INSERT INTO Avis VALUES
 (002, '002', 16, 'bien');
 
  INSERT INTO Avis VALUES
 (003, '003', 18, null);


Alter table Livres
ADD note_moy number;


CREATE OR REPLACE PROCEDURE note_update as
	not_moyen number;
	pasLivre EXCEPTION;
	livrep Avis.refl%type;
	livre_recherche number;
	requete varchar2(400);	
	cursor curs_moy is SELECT refl as refer, avg(note) as note_moy
		from Avis
		group by refl;
	
	ligne curs_moy %rowtype;
	
BEGIN 		
	for ligne in curs_moy loop
		requete := 'UPDATE Livres set note_moy = :'||ligne.note_moy||' where refl = :'|| ligne.refer;
		dbms_output.put_line(' mise a jour des notes ');
		EXECUTE IMMEDIATE (requete) using ligne.note_moy, ligne.refer;
	end loop;
END note_update;
/


CREATE OR REPLACE TRIGGER livre_aft_ins_row_upd
	AFTER INSERT OR UPDATE
	ON Avis
	FOR EACH ROW
	DECLARE
	NEW_NOTE_MOYENNE number (3,2)
	BEGIN
	SELECT OLD(AVG(note),0) INTO NEW_NOTE_MOYENNE FROM Avis WHERE refl =: new.refl;
	UPDATE Livres SET note_moy = NEW_NOTE_MOYENNE WHERE refl =: new.refl;
END;		
/

--Fonctionne pas et c'est normal on a un probleme de table mutante, quand on met a jour la moyenne on modifie la moyenne qu'on calcule. 

       	    




