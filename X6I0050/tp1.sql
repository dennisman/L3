spool tp1.log
set serveroutput on


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


begin

	dbms_output.put_line('***************CLIENTS**************');
end;
/

 SELECT * FROM CLIENTS;
 
 begin

	dbms_output.put_line('***************LIVRES**************');
end;
/
 
 SELECT * FROM Livres;
 begin

	dbms_output.put_line('***************ACHATS**************');
end;
/
 SELECT * FROM Achats;
 begin

	dbms_output.put_line('***************AVIS**************');
end;
/
 SELECT * FROM Avis;

begin
	dbms_output.put_line('***************Q1**************');
end;
/

SELECT titre, auteur, genre FROM Livres NATURAL JOIN Achats 
	GROUP BY refl, titre, auteur, genre
	HAVING COUNT(refl)>2;/* ou 10 000 mais ca fait beaucoup */
	
begin
	dbms_output.put_line('***************Q2**************');
end;
/	

	SELECT refl,titre,avg(note) FROM Livres NATURAL JOIN Avis 
	GROUP BY refl, titre
    	HAVING avg(note)>=16;

begin
	dbms_output.put_line('***************Q3**************');
end;
/    	
	SELECT idcl, pren, nom, titre, note FROM Clients NATURAL JOIN Avis NATURAL JOIN Livres
	WHERE commentaire is null ;
    	
set serveroutput off
spool off


