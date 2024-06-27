Create database Cinema1;

-- folsim baza de date
Use Cinema1;

-- cream tabela filme -- 
Create table filme (
Id int primary key not null auto_increment,
Titlu varchar(25) not null,
Gen varchar(25),
Tip varchar(5) default '2D',
Durata int ,
Actori varchar(70),
Descriere varchar(100)
);

describe filme;

Create table Sali (
Id int,
Nume varchar(30) not null,
Numar_locuri int,
Id_Film int not null,
Foreign key(Id_Film) references Filme(Id),
Primary key (Id)

);

Create table Rulare_Filme(
Id int primary key auto_increment not null,
Id_Film int not null,
Id_Sali int not null,
Start_time datetime,
End_time datetime,
Foreign key(Id_film) references Filme(Id),
Foreign key(Id_sali) references Sali(Id)
);

Create table Bilete(
Id int primary key auto_increment not null,
Pret decimal (6,2)not null,
Achitat boolean, 
Id_rulare_film int,
Foreign key (Id_Rulare_film) references Rulare_filme (Id)


);
-- adaugam constrangerea auto_increment pe tabela sali
alter table Sali
modify Id int auto_increment;

-- 19:17:27	alter table Sali modify Id int auto_increment	Error Code: 1833. Cannot change column 'Id': used in a foreign key constraint 'rulare_filme_ibfk_2' of table 'cinema1.rulare_filme'	0.000 sec

-- sterg cheia secundara din tabela Rulare filme
alter table Rulare_filme
drop foreign key rulare_filme_ibfk_2;

-- adaug din nou cheie secundara pe Rulare_filme
alter table Rulare_filme
add foreign key (Id_sali) references Sali(Id);
desc Sali;

-- schimb numele unei coloane
alter table Bilete change Pret Pret_bilet decimal(7,2);
desc Bilete;

-- sterg o coloana din tabela Bilete 
alter table Bilete 
drop column Pret_bilet;
desc Bilete;

-- adaug o coloana in tabela Bilete
alter table Bilete
add Pret decimal (6,2) not null;
desc Bilete;

-- schimb pozitia unei coloane
alter table Bilete
change Pret Pret decimal (6,2) after Id;
desc Bilete;

desc Sali;

-- schimbam tipul unei coloane
alter table Sali 
modify column Nume varchar(35);

-- modificam numele unei coloane
alter table Sali
change Nume Nume_sala varchar(25);

-- modificam numele unei tabele
rename table Bilete to Tichete;

-- sterge baza de date
drop database Cinema1;

-- sterge un tabel de tot
drop table Sali;

-- sterge un tabel si il creeaza din nou fara valori
truncate table Sali;

-- Sterge valorile dintr-un tabel
delete from Sali;

-- iti arata toate tabelele pe care le ai definite in baza de date 
show tables;

-- sterge primary key din tabela Filme
alter table Filme
drop primary key;

create table Clienti (
Id int primary key,
Id_bilet int,
Nume varchar(30) not null,
Prenume varchar(30),
Email varchar (25) unique,
Gen enum('M','F'),
Foreign key (Id_bilet) references Tichete(Id)

);

-- sterge primary key din tabela Clienti
alter table Clienti
drop primary key;

-- adaug primary key in tabele Clienti
alter table Clienti
add primary key (Id);

desc Clienti;

use Cinema1;
create table Rezervari(
Id int primary key not null auto_increment,
Data_rezervare datetime,
Ora_rezervare datetime,
Numar_loc int,
Id_client int,
Id_rulare_film int,
Foreign key (Id_client) references Clienti(Id),
Foreign key (Id_rulare_film) references Rulare_filme(Id)
);
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 8
desc Clienti;

p-- pentru drepturi de editare
SET SQL_SAFE_UPDATES = 0;

-- introduc valori in tabela fara sa definesc coloanele
insert into filme 
	values 
    (1,'Titanic', 'drama', '2D',120,'Dicaprio', 'drama bazata pe fapte reale');
 
select * from filme;

-- definim celule pentru care introduc valorile
insert into filme(titlu, gen, durata)
values
('Deadpool','actiune',120),
('The Gentlemen','comedie',140);

-- populam date in tabela sali
insert into sali (id, nume_sala, id_film)
values(1,'sala1', 3);

insert into sali
values (2,'sala2', 60,2);

select * from sali;

 insert into rulare_filme (id_film, id_sali) values ( 1, 1);
 
select * from rulare_filme;

insert into rulare_filme values(2,3,2,'2024-04-22 18:00', '2024-04-22 20:00');

-- actualizam toate celulele de pe start_time cu acc valoare
update rulare_filme set start_time = '2024-04-23 15:00';

-- actualizam  celula de  start_time de pe id-ul 2
update rulare_filme set start_time = '2024-04-23 15:00' where id=2;

-- modificam durata filmelor la 120' cu genul dramatic si tipul 2D
update filme set durata = 120 where gen = 'dramatic' and tip = '2D';

-- adaug/modifc valoare pe coloana descriere pentru filmul cu titlu Deadpool
update filme set descriere = 'viata in NY' where titlu ='Deadpool';

-- sterg filmul  cu id 3
delete from filme where id= 3;

-- actualizam id_film pentru id 1 in tabela sali
update sali set id_film = 1 where id = 1;

-- actualizam id_film pt id-ul 2 din rulare_filme
update rulare_filme set id_film = 2 where id = 2;

select *from filme;

-- populam tabela tichete
insert into tichete
values (2,30,true,2),
(3,40,false,1);

select * from tichete;
select * from clienti;

-- populam tabela clienti
insert into clienti 
values ( 1,1, 'racovita', 'corina', 'co@gmail,com', 'f');

insert into clienti 
values ( 2,2, 'racovita', 'co', 'co2@gmail,com', 'f');

insert into clienti ( id,id_bilet, nume, email)
values ( 3, 3, 'eva', 'eva1@gmail.com');

insert into filme(titlu, gen, tip, durata,actori)
values
('fixiki', 'animatie', '3D', 20, 'tom'),
('straina', 'serial','2D',60 , 'Alexandra'),
('tom si jerry', 'animatie', '2D', 25, 'tom');

select * from filme;
select * from rezervari;
select * from sali;
select * from clienti;
select * from rulare_filme;
select * from tichete;
insert into sali 
	values 
    ( 3, 'sala 3', 50, 4),
	( 4, 'sala nr 4', 50, 4),
    ( 5, 'sala nr 5', 60, 6);
    
insert into rezervari
	values
    (1, '2024-04-22', '1802-00-00 ', 5,1,1),
    (2, '2024-04-23', '1802-00-00 ', 20,2,2);
    

update rezervari set ora_rezervare= '2024-04-22 19:00' where Id = 1;
update rezervari set ora_rezervare= '2024-04-23 17:00' where Id = 2;

insert into rezervari
	values
    (3, '2024-04-22', '2024-04-22 15:00' , 78,1,1);
    
insert into rezervari
	values
    (4, '2024-04-24', '2024-04-24 14:00' , 50,1,2);
    
    -- modificam tipul unei coloane 
    alter table rezervari modify column Data_rezervare date not null;
      alter table rezervari modify column Ora_rezervare time not null;
      
-- extragem din tabela Filme informatiile despre titlu si durata
select Titlu , Durata from Filme;
-- extragem din tabela Filme doar filmele care au o durata mai mare de 60'
select Titlu , Durata from Filme where durata >60;
select Titlu , Durata from Filme where durata >=60;

-- extragem din tabela filme filmele de gen animatie si durata diferita de 20'
select * from Filme where gen = 'animatie' and durata !=20;
select * from Filme where gen = 'animatie' and not durata =20;

-- extragem din tabela filme valorile de pe coloanele titlu gen tip si durata ,de gen actiune sau animatie si tipul 2D
select Titlu, Gen, Tip, Durata from Filme where (gen = 'animatie' or gen ='actiune') and tip= '2D';

-- Extragem toate tipurile de filme care au o durata de 20' si 60'
select Titlu from Filme where durata in (20 , 60);
select Titlu from Filme where durata =20 or durata =60;

-- extragem filmele la care descrierea incepe cu drama, folosim operatorul like
select * from Filme where descriere like 'drama%';


update Filme set descriere = ' blabla drama blabla' where id=4;
update Filme set descriere = ' blabla drama' where id=5;

-- extragem filmele la care descrierea contine cuvantul drama, folosim operatorul like
select * from Filme where descriere like '%drama%';

-- extragem filmele la care descrierea se termina cu drama, folosim operatorul like
select * from Filme where descriere like '%drama';

select * from tichete;

-- folosim functie acregata max pe coloana pret pt a returna pretul maxim al unui bilet
select max(pret) from tichete;

-- folosim functie acregata max pe coloana pret pt a returna pretul minim al unui bilet
select min(pret) from tichete;

-- returnam nr biletelor cu pretul minim
-- select count(*) from tichete where pret=min(pret); ( nu a functionat)
select count(*) from tichete where pret=(select min(pret) from tichete);
select count(*) from tichete where pret=30;
select count(*) from tichete;

-- ordoneaza salile dupa nume in ordine descrescatoare
select * from sali order by Nume_sala desc;
select * from sali order by Id_film desc;
select * from sali order by Id_film asc;

-- returnam primele doua randuri din tabela sali
select * from sali limit 2;

-- ordanam salile dupa Id_film si numar_locuri
select * from sali order by Numar_locuri , Id_Film;
select * from sali order by Numar_locuri , Nume_sala;

select * from rulare_filme;
select * from rezervari;

-- facem o grupare a salilor in functie de film
select Id_Film, count(Id_Film) from sali group by Id_Film;

-- returnam titlu filmelor care ruleaza in sali cu 50 de locuri 
select Titlu from filme where id=(select Id_film from Sali where nume_sala='sala1');

-- returnam un singur titlu al unui film care ruleaza in sali cu 40 de locuri 
select Titlu from filme where id=(select Id_film from Sali where numar_locuri=40);
-- returnam toate filmele care ruleaza in sali cu 50 de locuri 
select Titlu from filme where id in (select Id_film from Sali where numar_locuri=50);
    update Sali set numar_locuri =40 where id=2;
        update Sali set Id_film =5 where id=3;
	
    select * from sali;
    
    -- selectam numele filmelor si numele sali
    select Filme.Id, Titlu, Nume_sala from Filme inner join Sali on Filme.Id=Sali.Id_film;
      select * from rezervari;
    select * from Filme;
    select * from Tichete;
    select * from rulare_filme;
    select * from sali;
    -- afiseaza toate titlurile de film , durata si pretul biletului.
    select Filme.Titlu, Filme.Durata, Tichete.Pret 
    from filme inner join rulare_filme inner join tichete
    on Filme.Id=rulare_filme.Id_film and rulare_filme.Id=tichete.Id_rulare_film;
    -- folosim left join pe tabela filme 
  select Filme.Id, Filme.Titlu, Filme.Durata, Nume_sala, Numar_locuri
    from filme left join sali 
    on Filme.Id=sali.Id_film 
    order by Filme.Titlu;
    
    select Filme.Id, Filme.Titlu, Filme.Durata, Nume_sala, Numar_locuri
    from filme right join sali 
    on Filme.Id=sali.Id_film 
    order by Filme.Titlu;
    
    -- afiseaza tiltu filmelor, descrierea, data_rezervare, ora_rezervare
    select Filme.Titlu, Filme.Descriere, Rezervari.data_rezervare, Rezervari.Ora_rezervare
    from filme inner join rulare_filme inner join rezervari
    on Filme.Id=rulare_filme.Id_Film and rulare_filme.Id=rezervari.Id_rulare_film;
    
     select Filme.Titlu, Filme.Descriere, Rezervari.data_rezervare, Rezervari.Ora_rezervare
    from filme 
    left join rulare_filme on Filme.Id=rulare_filme.Id_Film
    left join rezervari on rulare_filme.Id=rezervari.Id_rulare_film;
	
    
    
    
    