spool exo.log
set serveroutput on

drop table Achats;
drop table Avis;
drop table Clients;
drop table Livres;

CREATE TABLE Clients(idcl NUMBER (10), 
				nom VARCHAR2 (20), 
				pren VARCHAR2 (15), 
				adr VARCHAR2 (30), 
				tel VARCHAR2 (12), 
				PRIMARY KEY (idcl)
				);

CREATE TABLE Livres(refl varchar2 (10), 
				titre varchar2 (20), 
				auteur varchar2 (20), 
				genre varchar2(15), 
				PRIMARY KEY (refl)
				);
				
CREATE TABLE Achats(idcl number, 
				refl varchar2(10), 
				dateachat date, 
				PRIMARY KEY (dateachat),
				CONSTRAINT idcl_FK FOREIGN KEY(idcl) REFERENCES Clients(idcl),
				CONSTRAINT refl_FK2 FOREIGN KEY(refl) REFERENCES Livres(refl)
				);

CREATE TABLE Avis(idcl number, 
				refl varchar2(10), 
				note number(4,2), 
				commentaire varchar2(50), 
				CONSTRAINT idcl_FK3 FOREIGN KEY(idcl) REFERENCES Clients(idcl), 
				CONSTRAINT refl_FK4 FOREIGN KEY(refl) REFERENCES Livres(refl)
				);

INSERT ALL
  INTO Clients (idcl, nom, pren, adr, tel) VALUES (00000, 'Merlet', 'Corentin', 'osef', '0654988765')
  INTO Clients (idcl, nom, pren, adr, tel) VALUES (00001, 'Blf', 'Thibault', 'du', '0655927675')
  INTO Clients (idcl, nom, pren, adr, tel) VALUES (00002, 'Bordet', 'Dennis', 'numero', '0654935565')
  INTO Clients (idcl, nom, pren, adr, tel) VALUES (00003, 'Ouisse', 'Arthur', 'delarue', '0864476237')
SELECT * FROM dual;

INSERT ALL
   INTO Livres (refl, titre, auteur, genre) VALUES ('AAA000', 'les trois gros porcs', 'Jose', 'Enfance')
   INTO Livres (refl, titre, auteur, genre) VALUES ('BBB111', 'Sentez moi', 'Alphonse', 'Roman')
   INTO Livres (refl, titre, auteur, genre) VALUES ('CCC222', 'Mein Kampf', 'Adolf', 'Etranger')
   INTO Livres (refl, titre, auteur, genre) VALUES ('DDD333', 'La Bible', 'Jesus', 'Religion')
SELECT * FROM dual;

INSERT ALL
   INTO Avis (idcl, refl, note, commentaire) VALUES (00001, 'AAA000', 12, 'Un tres bon roman')
   INTO Avis (idcl, refl, note, commentaire) VALUES (00001, 'CCC222', 09, 'C''est super raciste')
   INTO Avis (idcl, refl, note, commentaire) VALUES (00000, 'CCC222', 06, 'Je croyais que c''etait un livre de cuisine')
   INTO Avis (idcl, refl, note, commentaire) VALUES (00003, 'BBB111', 20, 'Mon documentaire prefere !')
   INTO Avis (idcl, refl, note, commentaire) VALUES (00002, 'DDD333', 16, 'Quel homme, ce Jesus !')
   INTO Avis (idcl, refl, note, commentaire) VALUES (00001, 'DDD333', 12, '')
SELECT * FROM dual;

INSERT ALL
   INTO Achats (idcl, refl, dateachat) VALUES (00001, 'AAA000', to_date('23-11-1995', 'DD-MM-YYYY'))
   INTO Achats (idcl, refl, dateachat) VALUES (00001, 'CCC222', to_date('16-05-2004', 'DD-MM-YYYY'))
   INTO Achats (idcl, refl, dateachat) VALUES (00000, 'CCC222', to_date('08-07-1996', 'DD-MM-YYYY'))
   INTO Achats (idcl, refl, dateachat) VALUES (00003, 'BBB111', to_date('15-01-1994', 'DD-MM-YYYY'))
   INTO Achats (idcl, refl, dateachat) VALUES (00002, 'DDD333', to_date('03-09-2014', 'DD-MM-YYYY'))
SELECT * FROM dual;

declare 
my_var varchar2(150);
begin
	my_var := '1- Les livres qui ont été achetés a plus de 1 exemplaires (au lieu de 10 000, no offense ';
	dbms_output.put_line(my_var);
end;
/
	SELECT titre, auteur, genre FROM Livres NATURAL JOIN Achats 
	GROUP BY refl, titre, auteur, genre
	HAVING COUNT(refl)>1;

declare 
my_var varchar2(150);
begin
	my_var := '2- Les livres avec une moyenne supérieure à 16';
	dbms_output.put_line(my_var);
end;
/
	SELECT refl,titre,avg(note) FROM Livres NATURAL JOIN Avis 
	GROUP BY refl, titre
    	HAVING avg(note)>=16;

declare 
my_var varchar2(150);
begin
	my_var := '3- Les clients qui ont pas mis de commentaire a un livre ';
	dbms_output.put_line(my_var);
end;
/
	SELECT pren, nom, titre, note FROM Clients NATURAL JOIN Avis NATURAL JOIN Livres
	WHERE commentaire is null ;
spool off
