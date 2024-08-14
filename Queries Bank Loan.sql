select * from bank_loan;

-- ******************************************************************
-- count total applications number
select count(bank_loan.id) as total_applications from bank_loan;

-- count month to date(MTD) total applications
select count(bank_loan.id) as MTD_total_applications from bank_loan
where EXTRACT(MONTH FROM issue_date) = 12;

-- count previous month to date(PMTD) total applications
select count(bank_loan.id) as PMTD_total_applications from bank_loan
where EXTRACT(MONTH FROM issue_date) = 11;

-- ******************************************************************

-- count sum of all loan amounts
select sum(loan_amount) as total_loan_amount from bank_loan;

-- count month to date(MTD) loan amount
select sum(loan_amount) as MTD_loan_amount from bank_loan
where EXTRACT(MONTH FROM issue_date) = 12;

-- count previous month to date(PMTD) loan amount
select sum(loan_amount) as PMTD_loan_amount from bank_loan
where EXTRACT(MONTH FROM issue_date) = 11;

-- ******************************************************************

-- count sum of all total payments
select sum(total_payment) as total_payments_sum from bank_loan;

-- count month to date(MTD) total payments
select sum(total_payment) as MTD_total_payments from bank_loan
where EXTRACT(MONTH FROM issue_date) = 12;

-- count previous month to date(PMTD) total payments
select sum(total_payment) as PMTD_total_payments_sum from bank_loan
where EXTRACT(MONTH FROM issue_date) = 11;

-- ******************************************************************

-- average from interest rate
select avg(int_rate) * 100 as AVG_interest_rate from bank_loan;

-- MTD average interest rate
select avg(int_rate) * 100 as MTD_avg_interest_rate from bank_loan
where EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD average interest rate
select avg(int_rate) * 100 as PMTD_avg_interest_rate from bank_loan
where EXTRACT(MONTH FROM issue_date) = 11;

-- ******************************************************************

-- average from dti
select avg(dti) * 100 as AVG_dti from bank_loan;

-- MTD average dti
select avg(dti) * 100 as MTD_avg_dti from bank_loan
where EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD average dti
select avg(dti) * 100 as PMTD_avg_dti from bank_loan
where EXTRACT(MONTH FROM issue_date) = 11;

-- ******************************************************************

-- count amount of "good" loans
select count(id) as good_loan_applications from bank_loan
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- count percentage of "good" loans
select (count(case when loan_status = 'Fully Paid'
or loan_status = 'Current' then id end) * 100.0) / count(id) 
as good_loan_percentage from bank_loan;

-- count sum of payments funded for "good" loans
select sum(loan_amount) as good_loan_funded from bank_loan
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- count sum of payments got from "good" loans
select sum(total_payment) as good_loan_received from bank_loan
where loan_status = 'Fully Paid' or loan_status = 'Current';

-- ******************************************************************

-- count amount of "bad" loans
select count(id) as bad_loan_applications from bank_loan
where loan_status = 'Charged Off';

-- count percentage of "bad" loans
select (count(case when loan_status = 'Charged Off' then id end) 
* 100.0) / count(id) as bad_loan_percentage from bank_loan;

-- count sum of payments funded for "bad" loans
select sum(loan_amount) as bad_loan_funded from bank_loan
where loan_status = 'Charged Off';


-- count sum of payments got from "bad" loans
select sum(total_payment) as bad_loan_received from bank_loan
where loan_status = 'Charged Off';

-- ******************************************************************

-- kpi`s grouped by loan_status
select
        loan_status,
        count(id) as loan_count,
        sum(total_payment) as total_amount_received,
        sum(loan_amount) as total_amount_funded,
        avg(int_rate * 100) as interest_rate,
        avg(dti * 100) as dti
    from
        bank_loan
    group by
        loan_status
			
select 
	loan_status, 
	sum(total_payment) AS MTD_Total_Amount_Received, 
	sum(loan_amount) AS MTD_Total_Amount_Funded 
from bank_loan
where extract (month from issue_date) = 12
group by loan_status;


-- grouped by month
select 
    extract(month from issue_date) as month_number, 
    to_char(issue_date, 'FMMonth') as month_name,
    count(id) as total_loan_applications,
    sum(loan_amount) as total_funded_amount,
    sum(total_payment) as total_amount_received
from 
    bank_loan
group by 
    extract(month from issue_date), 
    to_char(issue_date, 'FMMonth')
order by 
    month_number;
	
-- grouped by state
select 
    address_state,
    count(id) as total_loan_applications,
    sum(loan_amount) as total_funded_amount,
    sum(total_payment) as total_amount_received
from 
    bank_loan
group by 
    address_state
order by 
    address_state;
	
-- grouped by term
select 
    term,
    count(id) as total_loan_applications,
    sum(loan_amount) as total_funded_amount,
    sum(total_payment) as total_amount_received
from 
    bank_loan
group by 
    term
order by 
    term;
	
-- grouped by employee length
select 
    emp_length,
    count(id) as total_loan_applications,
    sum(loan_amount) as total_funded_amount,
    sum(total_payment) as total_amount_received
from 
    bank_loan
group by 
    emp_length
order by 
    emp_length;

-- grouped by purpose
select 
    purpose,
    count(id) as total_loan_applications,
    sum(loan_amount) as total_funded_amount,
    sum(total_payment) as total_amount_received
from 
    bank_loan
group by 
    purpose
order by 
    purpose;

-- grouped by home ownership
select 
    home_ownership,
    count(id) as total_loan_applications,
    sum(loan_amount) as total_funded_amount,
    sum(total_payment) as total_amount_received
from 
    bank_loan
group by 
    home_ownership
order by 
    home_ownership;
	