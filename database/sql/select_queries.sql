set search_path to db_project;
select full_name from "Doctor" where age > (select avg(age) from "Doctor");
select avg(age) from "Doctor";
select count(*) from "Patient" where blood_type = 'A+' group by blood_type;
select full_name from "Doctor" where full_name like 'Mohammad%';
select full_name from "Patient" where blood_type like 'B_';
select name from "Drug" where cost::numeric > (select avg(cost::numeric) from "Drug");
select full_name from "Doctor" natural join "Work_time" natural join "Week" where room_num = 5 and week_day = 1;
select * from "Doctor" where phone_number like '%9';
select * from "Patient" where to_char(birthday, 'yyyy-mm-dd') like '2000-__-05';
select * from "Drug" order by cost ASC;
select full_name from "Doctor" order by age DESC;
select * from "Patient" order by full_name ASC;
select * from "Doctor" where age > (select avg(to_char(CURRENT_DATE, 'YYYY')::numeric - to_char(birthday, 'YYYY')::numeric) from "Patient");
select full_name from "Patient" where to_char(birthday, 'YYYY')::numeric < (select avg(age) from "Doctor");
select name from "Drug" D where not exists (select * from "Drug" where cost::numeric >= D.cost::numeric and drug_barcode != D.drug_barcode);
select count(*) from "Work_time" where dr_id = 898989;
select full_name from "Patient" order by full_name ASC;
select full_name from "Doctor" order by age ASC;
select count(*), id_prescribe from "Prescribe" natural join "Basket_drug" group by (id_prescribe);
select * from "Doctor" natural join "Section" where cost::numeric > (select avg(cost::numeric) from "Section");
select age from "Doctor" natural join "Section" where room_num = 5;
select * from "Patient" where full_name like '%y';
select * from "Patient" P where exists (select dr_id from "Doctor" where dr_id = P.id_p);
select full_name from (select full_name from "Patient" union select full_name from "Doctor") Foo where full_name like 'amir%';
select count(*) from "Section";
select * from "Patient" where blood_type not in('A+', 'A-');
select count(*) from "Patient" where (to_char(CURRENT_DATE, 'YYYY')::numeric - to_char(birthday, 'YYYY')::numeric) > (select avg(to_char(CURRENT_DATE, 'YYYY')::numeric - to_char(birthday, 'YYYY')::numeric) from "Patient");
select sum(to_char(CURRENT_DATE, 'YYYY')::numeric - to_char(birthday, 'YYYY')::numeric) from "Patient";
select * from "Doctor" where full_name like '___ %';
select * from "Doctor" D where not exists(select dr_id from "Section" where dr_id = D.dr_id);




