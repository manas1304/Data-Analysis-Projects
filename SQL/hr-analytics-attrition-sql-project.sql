CREATE TABLE hr_data (
    Age INT, Attrition VARCHAR(10), BusinessTravel VARCHAR(50), DailyRate INT, 
    Department VARCHAR(50), DistanceFromHome INT, Education INT, EducationField VARCHAR(50), 
    EmployeeCount INT, EmployeeNumber INT PRIMARY KEY, EnvironmentSatisfaction INT, Gender VARCHAR(10), 
    HourlyRate INT, JobInvolvement INT, JobLevel INT, JobRole VARCHAR(50), JobSatisfaction INT, 
    MaritalStatus VARCHAR(20), MonthlyIncome INT, MonthlyRate INT, NumCompaniesWorked INT, 
    Over18 VARCHAR(5), OverTime VARCHAR(5), PercentSalaryHike INT, PerformanceRating INT, 
    RelationshipSatisfaction INT, StandardHours INT, StockOptionLevel INT, TotalWorkingYears INT, 
    TrainingTimesLastYear INT, WorkLifeBalance INT, YearsAtCompany INT, YearsInCurrentRole INT, 
    YearsSinceLastPromotion INT, YearsWithCurrManager INT
);


select * from hr_data;



-- 1. Baseline Headcount, Attrition Count, and Attrition Rate (%)


select 
	count(*) as total_employees,
	count(case when Attrition = 'Yes' then 1 end) as attrition_count,
	round(count(case when Attrition = 'Yes' then 1 end)* 100/count(*),2) as attrition_rate
from hr_data;

-- This tell that 1470 was the count of total employees and employee count that left the company was 237 and attrition rate was 16%.


-- 2. Validate Data Scope (Department & Job Role Counts)

select 
	count(distinct department) as num_departments,
	count(distinct jobrole) as num_job_role,
	min(age) as min_age,
	max(age) as max_age
from hr_data;

-- So from these queries we can interpret that attrition rate is 16% that means yearly 16% people are leaving the company
-- accross 3 departments	-- let's find the reasons for this

select department, attrition, round(avg(monthlyIncome), 0) as monthly_income
from hr_data
group by department, attrition
order by department, attrition;


select * from (
	select jobrole, monthlyincome, dense_rank() over(partition by jobrole order by monthlyincome desc) as rank
	from hr_data
) subquery where rank <= 3;





