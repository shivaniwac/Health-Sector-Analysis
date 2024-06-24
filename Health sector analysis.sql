USE HEALTHPROJECT;
-- create database if not exists Healthproject;
create table if not exists Health(NAME Varchar(50) NOT NULL primary key );
ALTER TABLE `healthproject`.`health` 
ADD COLUMN `Age` INT NOT NULL AFTER `NAME`,
ADD COLUMN `Blood_Type` VARCHAR(45) NOT NULL AFTER `Age`,
ADD COLUMN `Medical_condition` VARCHAR(45) NOT NULL AFTER `Blood_Type`,
ADD COLUMN `Date_of_Admission` DATE NOT NULL AFTER `Medical_condition`,
ADD COLUMN `Doctor` VARCHAR(45) NOT NULL AFTER `Date_of_Admission`,
ADD COLUMN `Hospital` VARCHAR(45) NOT NULL AFTER `Doctor`,
ADD COLUMN `Insurance_provider` VARCHAR(45) NOT NULL AFTER `Hospital`,
ADD COLUMN `Billing_amount` VARCHAR(45) NOT NULL AFTER `Insurance_provider`,
ADD COLUMN `Room_number` INT NOT NULL AFTER `Billing_amount`,
ADD COLUMN `Admission_type` VARCHAR(45) NOT NULL AFTER `Room_number`,
ADD COLUMN `Discharge_Date` DATE NOT NULL AFTER `Admission_type`,
ADD COLUMN `Medication` VARCHAR(45) NOT NULL AFTER `Discharge_Date`,
ADD COLUMN `Test_result` VARCHAR(45) NOT NULL AFTER `Medication`;
-- ----------------------------------FEATURE ENGINEERING---------------------------------------- 
-- ------------------------------------age_group--------------------------------------------- 

SELECT 
      age,
      (CASE
        WHEN age BETWEEN '18' AND '33' THEN 'Young adult'
        WHEN age BETWEEN '34' AND '48' THEN 'Adult'
        WHEN age BETWEEN '49' AND '64' THEN 'Middle Aged'
        WHEN age BETWEEN '65' AND '78' THEN 'Aged'
        ELSE 'Old'
      END
      ) AS age_group
FROM `healthproject`.`health`;
ALTER TABLE `healthproject`.`health` ADD COLUMN age_group varchar(20);
update `healthproject`.`health`
set age_group = (CASE
        WHEN age BETWEEN '18' AND '33' THEN 'Young adult'
        WHEN age BETWEEN '34' AND '48' THEN 'Adult'
        WHEN age BETWEEN '49' AND '64' THEN 'Middle Aged'
        WHEN age BETWEEN '65' AND '78' THEN 'Aged'
        ELSE 'Old'
      END
      );
-- ------------------- ----- -----------day name-- ------------------------------------------
select date_of_admission, dayname(date_of_admission)
from `healthproject`.`health`;
ALTER TABLE `healthproject`.`health` ADD COLUMN day_name varchar(20);
update  `healthproject`.`health` 
set day_name = dayname(date_of_admission);
-- ------------------------------------month_name --------------------------------------------------
select Date_of_Admission, monthname(Date_of_Admission)
from `healthproject`.`health`; 
ALTER TABLE `healthproject`.`health` ADD COLUMN month_name varchar(20);
update  `healthproject`.`health`
set month_name = monthname(Date_of_Admission);	
-- --------------------------------------- ----------------------------------------------------------
-- ------------------------------------Generic ------------------------------------------------------
select * from `healthproject`.`health`; 
-- -------------------------------------age, Gender, Blood_Type,Medical_condition----------------------------------------------------------- 
select age_group,gender, count(*) as count
from `healthproject`.`health`
group by age_group, gender
order by age_group, gender;

Select distinct Medical_condition
from `healthproject`.`health`;

Select Medical_condition, gender,count(*) as count
from `healthproject`.`health`
group by medical_condition, gender;

select age_group,gender,Medical_condition, count(*) as count
from `healthproject`.`health`
group by age_group, gender,Medical_condition
order by age_group, gender,Medical_condition;

select distinct age_group,Medical_condition, count(*) as count
from `healthproject`.`health`
group by age_group,Medical_condition
order by age_group,Medical_condition desc;

select distinct blood_type
from `healthproject`.`health`;

select distinct blood_type,Medical_condition, count(*) as count
from `healthproject`.`health`
group by  blood_type,Medical_condition
order by blood_type,Medical_condition;

-- ---------------------------doctor, insurance_provider, Hospital ---------------------------------
select distinct hospital
from `healthproject`.`health`;

select distinct medical_Condition, insurance_provider, count(*) as count
from `healthproject`.`health`
group by medical_condition, insurance_provider
order by insurance_provider;

select distinct insurance_provider, round(sum(Billing_amount),2) as total_Profit_of_Insurance_provider
from `healthproject`.`health`
group by  insurance_provider
order by total_Profit_of_Insurance_provider;

select distinct medical_Condition, insurance_provider, round(sum(Billing_amount),2) as total_Profit_of_Insurance_provider
from `healthproject`.`health`
group by medical_condition, insurance_provider
order by insurance_provider;


select distinct medical_Condition, max(Medication)as Maximum_medication
from `healthproject`.`health`
group by medical_condition
order by medical_Condition, Maximum_medication;

select distinct month_name, count(*) as month_namee
from `healthproject`.`health`
group by month_name 
order by month_namee desc ;

select distinct day_name, count(day_name)as Maximum_day_patient
from `healthproject`.`health`
where month_name = 'august'
group by day_name
order by Maximum_day_patient desc;

   
      