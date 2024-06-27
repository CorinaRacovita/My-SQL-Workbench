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


