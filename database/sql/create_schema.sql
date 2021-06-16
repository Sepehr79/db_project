/*
 * SQL to create database
 */

 /**************************************    Create new schema 'db_project'   ***************************************/
drop schema if exists db_project cascade;
create schema db_project;
SET search_path TO db_project;

/****************************************  Creating tables  **********************************************/
create table if not exists "Doctor"(
	dr_id smallserial,
	full_name varchar(50) not null,
	special varchar(20) not null,
	age Integer,
	phone_number varchar(20) not null unique,
	primary key (dr_id)
);

create table if not exists "Week"(
	day_str varchar(20) not null,
	week_day Integer not null,
	primary key(week_day)
);

create table if not exists "Work_time"(
	start_time TIME not null,
	end_time TIME not null,
	week_day Integer not null,
	room_num Integer not null,
	dr_id Integer not null,
	primary key(start_time, end_time, week_day, room_num),
	foreign key (dr_id) REFERENCES "Doctor",
	foreign key(week_day) REFERENCES "Week"
);

create table if not exists "Patient"(
	id_p smallserial,
	full_name varchar(50) not null,
	birthDay DATE,
	address varchar(150),
	blood_type varchar(5),
	primary key (id_p)
);

create table if not exists "Section"(
	section_id smallserial,
	id_p Integer not null,
	dr_id Integer not null,
	time_slot TIMESTAMP not null,
	cost money not null, 
	room_num Integer not null,
	primary key(section_id),
	foreign key(id_p) REFERENCES "Patient"
);

create table if not exists "Drug"(
	drug_barcode smallserial,
	produce_date DATE not null,
	exp_date DATE not null,
	name varchar(30) not null,
	cost money not null,
	primary key(drug_barcode)
);

create table if not exists "Prescribe"(
	id_p Integer not null,
	dr_id Integer not null,
	info varchar(100) not null, 
	prescribe_date DATE not null,
	id_prescribe smallserial,
	primary key(id_prescribe),
	foreign key(id_p) REFERENCES "Patient",
	foreign key(dr_id) REFERENCES "Doctor"
);

create table if not exists "Basket_drug"(
	id_prescribe Integer not null,
	drug_barcode Integer not null,
	primary key(id_prescribe, drug_barcode),
	foreign key(id_prescribe) REFERENCES "Prescribe",
	foreign key(drug_barcode) REFERENCES "Drug"
);

/*************************************** Inserting data *****************************************/

-- Resetting data
delete from "Basket_drug";
delete from "Work_time";
delete from "Section";
delete from "Prescribe";
delete from "Doctor";
delete from "Week";
delete from "Patient";
delete from "Drug";



-- Week
insert into "Week" values ('SHANBE', 1);
insert into "Week" values ('YEKSHANBE', 2);
insert into "Week" values ('DOSHANBE', 3);
insert into "Week" values ('SESHANBE', 4);
insert into "Week" values ('CHAHARSHANBE', 5);
insert into "Week" values ('PANJSHANBE', 6);
insert into "Week" values ('JOMEH', 7);

-- Doctor
insert into "Doctor" (dr_id, full_name, special, age, phone_number) values(1 ,'Mohammad askari', 'DAKHELI', 20, '+989020783081');
insert into "Doctor" (dr_id, full_name, special, age, phone_number) values(2 ,'ahmad ahmadi', 'MAQZ VA ASAB', 26, '+989374328978');
insert into "Doctor" (dr_id, full_name, special, age, phone_number) values(3 ,'ali hoseini', 'DAKHELI', 30, '+986551425');
insert into "Doctor" (dr_id, full_name, special, age, phone_number) values(4 ,'sepehr mollaei', 'CHESHM', 35, '+982351122');

-- Inserting data for doctor work time
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(1, '8:00', '9:30', 1, 5); -- This doctor with id 1 works from 8 to 9:30 on day Saturday in room 5
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(1, '8:00', '9:30', 3, 5);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(1, '8:00', '9:30', 5, 6);

insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(2, '12:00', '14:30', 2, 2);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(2, '12:00', '14:30', 4, 3);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(2, '12:00', '14:00', 6, 2);

insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(3 ,'15:00', '16:30', 2, 1);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(3 ,'16:00', '17:30', 5, 3);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(3 ,'16:00', '17:00', 1, 4);

insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(4, '16:00', '17:30', 1, 2);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(4, '17:00', '20:30', 4, 3);
insert into "Work_time" (dr_id, start_time, end_time, week_day, room_num) values(4, '17:00', '20:00', 6, 2);

-- Patient
insert into "Patient" (id_p, full_name, birthday, address, blood_type) values(1, 'Bimar Bimary', '2000-1-1', 'MAHALE BIMARHA', 'A+');
insert into "Patient" (id_p, full_name, birthday, address, blood_type) values(2, 'AAA BBB', '2000-6-1', 'MAHALE BIMARHA', 'B-');
insert into "Patient" (id_p, full_name, birthday, address, blood_type) values(3, 'BBB CCC', '1998-1-1', 'MAHALE BIMARHA', 'AB+');
insert into "Patient" (id_p, full_name, birthday, address, blood_type) values(4, 'DDD EEE', '2002-1-1', 'MAHALE BIMARHA', 'O-');

-- Section
insert into "Section" (section_id, id_p, dr_id, time_slot, cost, room_num) values(1, 1, 2, '2021-10-11 12:30', '60000',  3);
insert into "Section" (section_id, id_p, dr_id, time_slot, cost, room_num) values(2, 2, 3, '2021-10-12 15:30', '60000',  1);
insert into "Section" (section_id, id_p, dr_id, time_slot, cost, room_num) values(3, 3, 2, '2021-10-11 12:30', '60000',  3);
insert into "Section" (section_id, id_p, dr_id, time_slot, cost, room_num) values(4, 4, 1, '2021-10-14 8:30', '60000',  5);


-- Prescribe
insert into "Prescribe"(id_prescribe, id_p, dr_id, info, prescribe_date) values (1, 1, 2, 'SOME INFO', '2021-10-11');
insert into "Prescribe"(id_prescribe, id_p, dr_id, info, prescribe_date) values (2, 2, 3, 'SOME INFO', '2021-10-12');
insert into "Prescribe"(id_prescribe, id_p, dr_id, info, prescribe_date) values (3, 3, 2, 'SOME INFO', '2021-10-11');
insert into "Prescribe"(id_prescribe, id_p, dr_id, info, prescribe_date) values (4, 4, 1, 'SOME INFO', '2021-10-14');

-- Drug
insert into "Drug"(drug_barcode, produce_date, exp_date, name, cost) values (1111, '2019-1-19', '2021-12-19', 'Druge A', '60000');
insert into "Drug"(drug_barcode, produce_date, exp_date, name, cost) values (2222, '2020-1-19', '2022-12-19', 'Druge B', '70000');
insert into "Drug"(drug_barcode, produce_date, exp_date, name, cost) values (3333, '2018-1-19', '2024-9-19', 'Druge C', '90000');
insert into "Drug"(drug_barcode, produce_date, exp_date, name, cost) values (4444, '2017-1-19', '2020-12-19', 'Druge D', '10000');

-- Basket_drug
insert into "Basket_drug"(id_prescribe, drug_barcode) values (1 , 2222);
insert into "Basket_drug"(id_prescribe, drug_barcode) values (1 , 1111);
insert into "Basket_drug"(id_prescribe, drug_barcode) values (1 , 4444);

insert into "Basket_drug"(id_prescribe, drug_barcode) values (2 , 1111);
insert into "Basket_drug"(id_prescribe, drug_barcode) values (2 , 2222);

insert into "Basket_drug"(id_prescribe, drug_barcode) values (3 , 4444);

insert into "Basket_drug"(id_prescribe, drug_barcode) values (4 , 1111);
insert into "Basket_drug"(id_prescribe, drug_barcode) values (4 , 2222);
insert into "Basket_drug"(id_prescribe, drug_barcode) values (4 , 3333);
insert into "Basket_drug"(id_prescribe, drug_barcode) values (4 , 4444);

