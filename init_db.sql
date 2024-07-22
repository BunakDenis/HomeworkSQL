create database goit_enterprise;

create table worker (
id int primary key auto_increment,
name varchar(1000) check (length(name) >= 2) not null,
birthday date check(birthday >= '1900-01-01'),
level varchar(50),
salary int check (salary >= 100 and salary <= 100000),
constraint check_level check (
level in ('Trainee', 'Junior', 'Middle', 'Senior')
)
);

create table client (
id int primary key auto_increment,
name varchar(1000) check (length(name) >= 2) not null
);

create table project (
id int auto_increment,
client_id int,
start_date date,
finish_date date,
primary key (id),
foreign key (client_id) references client(id)
);

create table project_worker (
project_id int,
worker_id int,
primary key (project_id, worker_id),
foreign key (project_id) references project(id),
foreign key (worker_id) references worker(id)
);