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


DECLARE 
	not_moyen number;
	pasLivre EXCEPTION;
	livrep Avis.refl%type;
	livre_recherche number;
	
	
BEGIN 	
	-- entree utilisateur
	livrep := &enter_book_think_about_quotes;
	
	-- recherche dans la table
	select avg(note) into not_moyen 
	from Avis
	where refl = livrep;
	-- affichage 
	dbms_output.put_line('Note moyenne '||not_moyen || '  ~~ c=====3');
	
	select count(refl) into livre_recherche
	from Avis
	where refl = livrep;
	
	if (livre_recherche = 0) then
		raise pasLivre;
	else 
	-- ajout de la note moyenne
	EXECUTE IMMEDIATE ('Update Livres set note_moy = :not_moyenne where refl = :livrep ') using not_moyen,  livrep;
	end if;
	
EXCEPTION 
	when pasLivre Then 
	RAISE_APPLICATION_ERROR(-20001, 'Livre non present');
	

END;	
/
	


