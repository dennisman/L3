/*BORDET Dennis
BEZIERS LA FOSSE Thibault
MERLET Corentin

Projet Pokedex BD pl/sql*/

spool projet.log
set serveroutput on;

-- suppression des anciennes tables
DROP TABLE Localisations CASCADE CONSTRAINTS;
DROP TABLE Caracteristiques CASCADE CONSTRAINTS;
DROP TABLE Techniques CASCADE CONSTRAINTS;
DROP TABLE InfosZones CASCADE CONSTRAINTS;


-- table Techniques, type1->capacité
-- decrit la capacité associé a un type1
CREATE TABLE Techniques(
	capacite VARCHAR2(15),
	type1 VARCHAR2(10) NOT NULL,
	PRIMARY KEY (type1)
);

-- table Caractéristiques, contient la majeure partie des données concernant un pokémon,
-- le numéro d'un pokémon determine tous les autres attribut,
-- grosse table
CREATE TABLE Caracteristiques(
	num NUMBER NOT NULL CHECK(num > 0 AND num <= 151), -- CONTRAINTE pokemons de la 1ere version : de 1 à 151
	nom VARCHAR2(15),
	vie NUMBER NOT NULL,
	attaque NUMBER NOT NULL,
	defense NUMBER NOT NULL,
	attSpe NUMBER NOT NULL,					--attaque spéciale
	defSpe NUMBER NOT NULL,
	vitesse NUMBER NOT NULL,
	type1 VARCHAR2(10),
	type2 VARCHAR2(10),
	taille NUMBER(4,2) NOT NULL,
	poids NUMBER(5,2) NOT NULL,
	preEvolution NUMBER,					--numéro(clé) du pokemon qui représente sa pré-évolution
	postEvolution NUMBER,					--numéro(clé) du pokemon qui représente sa post-évolution
	arene VARCHAR2(25),						-- arene dans laquelle il est présent
	apparition VARCHAR2(50),				-- apparition dans les films/série
	PRIMARY KEY (num),
	CONSTRAINT type1_FK FOREIGN KEY(type1) REFERENCES Techniques(type1) 
);

--table InfosZones zone->niveau
--chaque zone du jeu laisse apparaitre des pokemons d'un certains niveau
-- ce niveau est déterminé suivant la zone
CREATE TABLE InfosZones(
	zone VARCHAR2(15) NOT NULL,
	niveau NUMBER,
	PRIMARY KEY (zone)
);

-- table Localisations qui précise pour chaque couple (pokémon, zone où est present ce pokemon) 
-- le boolean capturable : si un pokemon est capturable, il est sauvage, sinon c'est celui d'un
-- dresseur présent dans la zone
CREATE TABLE Localisations(
	num NUMBER NOT NULL,
	zone VARCHAR2(15) NOT NULL,
	capturable NUMBER(1),
	PRIMARY KEY(num, zone), 
	CONSTRAINT num_FK FOREIGN KEY(num) REFERENCES Caracteristiques(num),
	CONSTRAINT zone_FK FOREIGN KEY(zone) REFERENCES InfosZones(zone)
);

---------------------------------PROCEDURES-------------------------------------------


-- ajout d'un pokemon
-- si il est déja present, on update, (mieux que de lever une erreur)
-- sinon, on l'ajoute
CREATE OR REPLACE PROCEDURE ajouterPokemon(numero IN NUMBER,
	nm IN Caracteristiques.nom %type,
	att IN NUMBER,
	defp IN NUMBER,
	life IN NUMBER,
	attS IN NUMBER,
	defS IN NUMBER,
	vit IN NUMBER,
	t1 IN Caracteristiques.type1 %type,
	t2 IN Caracteristiques.type1 %type,
	height IN Caracteristiques.taille %type,
	weight IN Caracteristiques.poids %type,
	preE IN Caracteristiques.postEvolution %type,
	postE IN Caracteristiques.postEvolution %type,
	arena IN Caracteristiques.arene %type,
	app IN Caracteristiques.apparition %type)	
	IS	
	nu INT;
	deja_present EXCEPTION;
BEGIN

	select count(*) INTO nu from Caracteristiques
	where Caracteristiques.num = numero;
	
    IF (nu > 0)
        THEN
        dbms_output.put_line('Le pokemon etait deja Present ... Update');
    	UPDATE  Caracteristiques SET nom=nm, vie=life, attaque=att, defense=defp,
    	attSpe=attS, defSpe=defS, vitesse=vit, type1=t1, type2=t2, poids=weight, taille=height, preEvolution=preE, postEvolution=postE,
    	 arene=arena, apparition=app where Caracteristiques.num = numero	 
    ELSE
		INSERT INTO Caracteristiques VALUES(numero, nm, life, att, defp, attS, defS, vit, t1, t2, height, weight, preE, postE, arena, app); 
	END IF;
	
EXCEPTION
	--WHEN deja_present THEN RAISE_APPLICATION_ERROR(-20002, 'Pokemon deja present');

END;
/

-- Procedure d'ajout de technique ( type, capacite)
-- si deja present, on update,
-- sinon on insert
CREATE OR REPLACE PROCEDURE ajoutTech(typ In techniques.type1 %type, capac in techniques.capacite %type)
IS
	ty NUMBER;
BEGIN
	select count(*) INTO ty from Techniques
	where Techniques.type1 = typ;
	
    IF (ty > 0)
        THEN
    	UPDATE Techniques SET Techniques.capacite = capac WHERE Techniques.type1 = typ;
    ELSE
		Insert into Techniques values (capac, typ);
	END IF;
END;
/

-- procedure d'ajout de localisation 
-- si le pokemon entré est deja dans la zone specifiee, on leve une exception
-- si le pokemon n'est pas dans la base de donnée, un trigger, va l'ajouter par default
-- sinon on ajoute normalement dans la table Localisations
CREATE OR REPLACE PROCEDURE ajoutLocal(nu In localisations.num %type, zon in localisations.zone %type, capt in localisations.capturable %type)
IS
	deja_dedans INT;
	nb_poke INT;
	deja_present EXCEPTION;
	pas_de_poke EXCEPTION;
BEGIN
	select count(*) INTO deja_dedans from Localisations
	where Localisations.num = nu AND Localisations.zone = zon;
	
	
    IF (deja_dedans > 0)
        THEN
    	RAISE deja_present;
    ELSE
    	select count(*) INTO nb_poke from Caracteristiques
    	where Caracteristiques.num = nu;
    	
    	IF (nb_poke = 0)
        	THEN
    		--RAISE pas_de_poke;
    		-- -> on a fait un trigger a la place
    	ELSE
			Insert into Localisations values (nu, zon, capt);
		End IF;
	END IF;
	
EXCEPTION
	WHEN deja_present THEN RAISE_APPLICATION_ERROR(-20004, 'le pokemon entré est deja dans cette zone');
	--WHEN pas_de_poke THEN RAISE_APPLICATION_ERROR(-20005, 'aucun pokemon n''a été rentré dans la BD avec ce numéro');
END;
/



CREATE OR REPLACE PROCEDURE ajoutZone(zon In InfosZones.zone %type, niv in InfosZones.niveau %type)
IS
	zo NUMBER;
BEGIN
	select count(*) INTO zo from InfosZones
	where InfosZones.zone = zon;
	
    IF(zo > 0)
        THEN
		UPDATE InfosZones SET InfosZones.niveau = niv WHERE InfosZones.zone = zon;
    ELSE
		Insert into InfosZones values (zon, niv);
	END IF;
END;
/

---------------------------------TRIGGERS-------------------------------------------

create or replace trigger pre_bef_ins_upd
	before insert or update
	on caracteristiques 
	for each row
declare
	numEvo number;
	preE number;
	numAct number;
	newNom varchar2(15);
	evolution_error EXCEPTION;
begin
	preE := :new.preEvolution;
	numAct := :new.num;
	newNom := :new.nom;
	if (preE <> (numAct -1))
		then 
		if not((newNom = 'Aquali' or newNom = 'Voltali' or newNom = 'Pyroli') and preE = 133)
			then raise evolution_error; 
		end if;		
	else
		select count(*) into numEvo from Caracteristiques where Caracteristiques.num = preE;
		if numEvo = 0 and numAct>1 then
			dbms_output.put_line('Cette preEvolution est absente de la base de donnees. Vous pourrier ajouter le pokemon numero '||preE||' par exemple');
		end if;
	end if;
	
exception 
	when evolution_error then
		dbms_output.put_line('Pre evolution incorrecte');
end;
/

create or replace trigger post_bef_ins_upd
	before insert or update
	on caracteristiques
	for each row
declare
	numEvo number;
	postE number;
	numAct number;
	newNom varchar2(15);
	evolution_error EXCEPTION;
begin 
	postE := :new.postEvolution;
	numAct := :new.num;
	newNom := :new.nom;		
	if (postE <> (numAct +1))
		then 
		if not((newNom = 'Evoli') and (postE = 134 or postE = 135))
			then raise evolution_error; 
		end if;		
	select count(*) into numEvo from Caracteristiques where Caracteristiques.num = postE;
		if numEvo = 0 then
			dbms_output.put_line('Cette postEvolution est absente de la base de donnee. Vous pourrier ajouter le pokemon numero '||postE||' par exemple');
		end if;
	end if;
exception 
	when evolution_error then
		dbms_output.put_line('Post evolution incorrecte');
end;		
/	

create or replace trigger type_bef_ins_upd
	before insert or update
	on caracteristiques
	for each row
declare
	nbtmp NUMBER;
	type1tmp VARCHAR2(15);
	rekete VARCHAR2(200);
begin
	if INSERTING then 
		type1tmp := :new.type1;
		select count(*) into nbtmp from techniques where techniques.type1 = type1tmp;
		if nbtmp = 0 then
			rekete := 'insert into Techniques values(null, '''||type1tmp||''')';
			execute immediate rekete;
			dbms_output.put_line('Type ajoute a la table technique');
		end if;
	end if;
end;
/		

create or replace trigger zone_bef_ins_upd
	before insert or update
	on Localisations
	for each row
declare
	newzone VARCHAR2(20);
	nbpkmn number;
	nbzone number;
	numpkmn number;
	rekete varchar2(200);
begin
	if INSERTING then
		newzone := :new.zone;
		select count(*) into nbzone 
		from InfosZones 
		where InfosZones.zone = newzone;
		
		numpkmn := :new.num;
		select count(*) into nbpkmn 
		from Caracteristiques 
		where Caracteristiques.num = numpkmn;
		if nbpkmn = 0 then
			rekete := 'insert into Caracteristiques values ('||numpkmn||', ''inconnu'', 1, 1, 1, 1, 1, 1, ''inconnu'', null, 1.0, 1.0, null, null, null, null)';
			dbms_output.put_line('Numero de pokemon ajoute aux caracteristiques. Procedez a une mise a jour des valeurs. ');
			execute immediate rekete;
		end if;
		if nbzone = 0 then
			rekete := 'insert into InfosZones(zone, niveau) values ('''||newzone||''', null)';
			execute immediate rekete;
			dbms_output.put_line('Zone ajoutee a la table InfosZone');
		end if;
	end if;
end;
/

---------------------------------VUES-------------------------------------------

create or replace view poke_plante as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'plante' or type2 = 'plante';
create or replace view poke_feu as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'feu' or type2 = 'feu';
create or replace view poke_electrik as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'electrik' or type1 = 'electrik';
create or replace view poke_eau as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'eau' or type2 = 'eau';
create or replace view poke_roche as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'roche' or type2 = 'roche';
create or replace view poke_sol as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'sol' or type2 = 'sol';
create or replace view poke_glace as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'glace' or type2 = 'glace';
create or replace view poke_vol as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'vol' or type2 = 'vol';
create or replace view poke_dragon as
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'dragon' or type2 = 'dragon';
create or replace view poke_poison as 
	select nom, num, type1, type2 from Caracteristiques
	where type1 = 'poison' or type2 = 'poison';
		
create or replace view statistiques as
	select nom, num, vie, attaque, defense, attSpe, defSpe, vitesse from Caracteristiques;
	
create or replace view zonePokemon as 
	select nom, num, zone from Localisations natural join Caracteristiques
	where num = num;

GRANT INSERT, UPDATE ON Caracteristiques to L3_2;
GRANT INSERT, UPDATE ON techniques to L3_2;
GRANT INSERT, UPDATE ON InfosZones to L3_2;
GRANT INSERT, UPDATE ON Localisations to L3_2;

GRANT SELECT ON Caracteristiques to L3_2 WITH GRANT OPTION;
GRANT SELECT ON techniques to L3_2 WITH GRANT OPTION;
GRANT SELECT ON InfosZones to L3_2 WITH GRANT OPTION;
GRANT SELECT ON Localisations to L3_2 WITH GRANT OPTION;

GRANT SELECT ON Caracteristiques to L3_1;
GRANT SELECT ON techniques to L3_1;
GRANT SELECT ON InfosZones to L3_1;
GRANT SELECT ON Localisations to L3_1;

alter trigger zone_bef_ins_upd enable;
alter trigger type_bef_ins_upd enable;
alter trigger post_bef_ins_upd enable;
alter trigger pre_bef_ins_upd enable;
--associer vue aux roles

insert into Techniques values('coupe', 'plante');
insert into InfosZones values('Argenta', 1);
insert into Localisations values(005, 'Foret de jade', 1);
insert into Caracteristiques values(09, 'bulbite', 50, 50, 50, 50, 50, 50, 'plante', 'eaau', 5.5, 5.3, 008, 002, null, null);
insert into Caracteristiques values(10, 'bulbitare', 50, 50, 50, 50, 50, 50, 'feu', 'plante', 5.5, 5.3, 009, 011, null, null);
execute ajouterpokemon(001, 'bulbite', 55, 45, 65, 315, 25, 200, 'plante', 'poison', 50.5, 0.2, null, 002, '', 'film 1');

spool off

