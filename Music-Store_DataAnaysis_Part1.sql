/*Q1.Who is the senior most employee besed on job tittle?*/

select * from employee order by levels desc limit 1

Output:
employee_id	last_name	first_name	title	              reports_to	levels	birthdate	          hire_date	             address	         city	      state	country	postal_code                        phone fax	        email
9	         Madan           Mohan       Senior General Manager	NULL	          L7	26-01-1961 00:00	14-01-2016 00:00	1008 Vrinda Ave MT	Edmonton	AB	Canada	T5K 2N1	+1 (780) 428-9482	+1 (780) 428-3457	madan.mohan@chinookcorp.com


/*Q2.Which Country have the most invoice?*/
Quary:
select count(*) as highest, billing_country from invoice 
group by billing_country 
order by highest desc

Output

highest	billing_country
131	USA
76	Canada
61	Brazil
50	France
41	Germany
30	Czech Republic
29	Portugal
28	United Kingdom
21	India
13	Chile
13	Ireland
11	Spain
11	Finland
10	Australia
10	Netherlands
10	Sweden
10	Poland
10	Hungary
10	Denmark
9	Austria
9	Norway
9	Italy
7	Belgium
5	Argentina


/*Q3.what are the top 3 value of total invoices?*/

Quary:

select total from invoice order by total desc limit 3

Output:
total
23.76
19.8
19.8


/*Q4.Which city have best customers? we want to throgh a party. which city we are earning more money . write a query that return higest total
invoice . Return both the city name invoice customer?
Quary:
select sum(total) as total_invoice, billing_city from invoice
group by billing_city order by total_invoice desc
Output:
total_invoice	billing_city
273.24	Prague
169.29	Mountain View
166.32	London
158.4	Berlin
151.47	Paris
129.69	SÃ£o Paulo
114.84	Dublin
111.87	Delhi
108.9	SÃ£o JosÃ© dos Campos
106.92	BrasÃ­lia
102.96	Lisbon
99.99	Bordeaux
99.99	MontrÃ©al
98.01	Madrid
98.01	Redmond
97.02	Santiago
94.05	Frankfurt
92.07	Orlando
91.08	Reno
91.08	Ottawa
86.13	Fort Worth
84.15	Tucson
82.17	Stuttgart
82.17	Rio de Janeiro
82.17	Porto
81.18	Sidney
79.2	New York
79.2	Edinburgh 
79.2	Helsinki
78.21	Budapest
76.23	Madison
76.23	Warsaw
75.24	Yellowknife
75.24	Stockholm
73.26	Dijon
72.27	Oslo
72.27	Salt Lake City
71.28	Chicago
71.28	Bangalore
70.29	Winnipeg
69.3	Vienne
66.33	Vancouver
66.33	Boston
65.34	Amsterdam
64.35	Lyon
62.37	Halifax
60.39	Brussels
54.45	Cupertino
50.49	Rome
40.59	Toronto
39.6	Buenos Aires
37.62	Copenhagen
29.7	Edmonton


/*Q5.Who is the best customer? The customer spend most money. will be decliered as best customer. write a query that person send 
the most money?*/

Quary:

select sum(i.total) as total, c.customer_id, c.first_name, c.last_name from customer as c
join invoice as i on c.customer_id = i.customer_id
group by c.customer_id order by total desc limit 1

Output:

total	customer_id	first_name	last_name
144.54	  5	          R              Madhav                                            
