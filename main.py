import csv
from datetime import datetime

import psycopg2

username = 'postgres'
password = 'dcher'
database = 'postgres'
host = 'localhost'
port = '5432'

INPUT_CSV_FILE = r'E:\Tableau Data\financial_loan.csv'  # PATH TO CSV-FILE

creation_query = '''
CREATE TABLE bank_loan (
    order_num SERIAL NOT NULL,
    id INTEGER NULL,
    address_state VARCHAR(2) NULL,
    application_type VARCHAR(10) NULL,
    emp_length VARCHAR(10) NULL,
    emp_title VARCHAR(100) NULL,
    grade VARCHAR(1) NULL,
    home_ownership VARCHAR(10) NULL,
    issue_date DATE NULL,
    last_credit_pull_date DATE NULL,
    last_payment_date DATE NULL,
    loan_status VARCHAR(20) NULL,
    next_payment_date DATE NULL,
    member_id INTEGER NULL,
    purpose VARCHAR(20) NULL,
    sub_grade VARCHAR(2) NULL,
    term  VARCHAR(20) NULL,
    verification_status VARCHAR(20) NULL,
    annual_income FLOAT NULL,
    dti FLOAT NULL,
    installment FLOAT NULL,
    int_rate FLOAT NULL,
    loan_amount INTEGER NULL,
    total_acc INTEGER NULL,
    total_payment INTEGER NULL,
    PRIMARY KEY (order_num) 
);
'''

conn = psycopg2.connect(user=username, password=password, dbname=database)
cur = conn.cursor()

cur.execute(creation_query)


def convert_date(date_str):
    try:
        return datetime.strptime(date_str, "%d-%m-%Y").strftime("%Y-%m-%d")
    except ValueError:
        return None


with open(INPUT_CSV_FILE, 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:

        # DATE CONVERTATION
        row['issue_date'] = convert_date(row.get('issue_date', ''))
        row['last_credit_pull_date'] = convert_date(row.get('last_credit_pull_date', ''))
        row['last_payment_date'] = convert_date(row.get('last_payment_date', ''))
        row['next_payment_date'] = convert_date(row.get('next_payment_date', ''))

        cur.execute('''
            INSERT INTO bank_loan (
                id, address_state, application_type, emp_length, emp_title, grade, home_ownership,
                issue_date, last_credit_pull_date, last_payment_date, loan_status, next_payment_date,
                member_id, purpose, sub_grade, term, verification_status, annual_income, dti,
                installment, int_rate, loan_amount, total_acc, total_payment
            ) VALUES (
                %(id)s, %(address_state)s, %(application_type)s, %(emp_length)s, %(emp_title)s, %(grade)s,
                %(home_ownership)s, %(issue_date)s, %(last_credit_pull_date)s, %(last_payment_date)s,
                %(loan_status)s, %(next_payment_date)s, %(member_id)s, %(purpose)s, %(sub_grade)s, %(term)s,
                %(verification_status)s, %(annual_income)s, %(dti)s, %(installment)s, %(int_rate)s, %(loan_amount)s,
                %(total_acc)s, %(total_payment)s
            )
        ''', row)


conn.commit()
cur.close()
conn.close()
