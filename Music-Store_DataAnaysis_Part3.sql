/*1. Find how much amount spent by each customer on artists?
write aquery to return customer name, artist name and total spent?*/

Quary:

with best_selling_artist as(
 select artist.artist_id as artist_id , artist.name as artist_name,
 sum(invoice_line.unit_price*invoice_line.quantity) as total_sales
 from invoice_line
 join track on track.track_id= invoice_line.track_id
 join album on album.album_id= track.album_id
 join artist on artist.artist_id = album.artist_id
 group by 1
 order by 3 desc
 limit 1
)

select c.customer_id,c.first_name,c.last_name, bsa.artist_name,
sum(il.unit_price*il.quantity) as amount_spent from invoice i
join customer c on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
join track t on t.track_id=il.track_id
join album alb on alb.album_id=t.album_id
join best_selling_artist bsa on bsa.artist_id=alb.artist_id
group by 1, 2, 3, 4
order by 5 desc;

Output:
customer
_id    first_name	                                        last_name	                                  artist_name	amount_spent
46	Hugh                                              	O'Reilly                                          	Queen	27.72
38	Niklas                                            	SchrÃ¶der                                          	Queen	18.81
3	FranÃ§ois                                          	Tremblay                                          	Queen	17.82
34	JoÃ£o                                              	Fernandes                                         	Queen	16.83
53	Phil                                              	Hughes                                            	Queen	11.88
41	Marc                                              	Dubois                                            	Queen	11.88
47	Lucas                                             	Mancini                                           	Queen	10.89
33	Ellie                                             	Sullivan                                          	Queen	10.89
20	Dan                                               	Miller                                            	Queen	3.96
5	R                                                 	Madhav                                            	Queen	3.96
23	John                                              	Gordon                                            	Queen	2.97
54	Steve                                             	Murray                                            	Queen	2.97
31	Martha                                            	Silk                                              	Queen	2.97
16	Frank                                             	Harris                                            	Queen	1.98
17	Jack                                              	Smith                                             	Queen	1.98
24	Frank                                             	Ralston                                           	Queen	1.98
30	Edward                                            	Francis                                           	Queen	1.98
35	Madalena                                          	Sampaio                                           	Queen	1.98
36	Hannah                                            	Schneider                                         	Queen	1.98
11	Alexandre                                         	Rocha                                             	Queen	1.98
8	Daan                                              	Peeters                                           	Queen	1.98
42	Wyatt                                             	Girard                                            	Queen	1.98
44	Terhi                                             	HÃ¤mÃ¤lÃ¤inen                                        	Queen	1.98
1	LuÃ­s                                              	GonÃ§alves                                         	Queen	1.98
48	Johannes                                          	Van der Berg                                      	Queen	1.98
49	StanisÅ‚aw                                         	WÃ³jcik                                            	Queen	1.98
52	Emma                                              	Jones                                             	Queen	1.98
57	Luis                                              	Rojas                                             	Queen	1.98
15	Jennifer                                          	Peterson                                          	Queen	1.98
28	Julia                                             	Barnett                                           	Queen	1.98
27	Patrick                                           	Gray                                              	Queen	0.99
58	Manoj                                             	Pareek                                            	Queen	0.99
45	Ladislav                                          	KovÃ¡cs                                            	Queen	0.99
26	Richard                                           	Cunningham                                        	Queen	0.99
59	Puja                                              	Srivastava                                        	Queen	0.99
13	Fernanda                                          	Ramos                                             	Queen	0.99
6	Helena                                            	HolÃ½                                              	Queen	0.99
22	Heather                                           	Leacock                                           	Queen	0.99
19	Tim                                               	Goyer                                             	Queen	0.99
39	Camille                                           	Bernard                                           	Queen	0.99
55	Mark                                              	Taylor                                            	Queen	0.99
50	Enrique                                           	MuÃ±oz                                             	Queen	0.99
43	Isabelle                                          	Mercier                                           	Queen	0.99


/*Q.we want to findout the most popular genre for each country.we determin the most popular 
genre as the genre with highest amount of purchase. write a query that returns each country along with 
the top genre. For countries where the maximum number of purchases is shared return all genre?*/
 
Quary:

with popular_genre As
( 
  select count(invoice_line.quantity) As purchases, customer.country, genre.name, genre.genre_id,
	Row_number() over (partition By customer.country order by count(invoice_line.quantity)desc) As rowno
	from invoice_line
	join invoice on invoice.invoice_id=invoice_line.invoice_id
	join customer on customer.customer_id=invoice.customer_id
	join track on track.track_id=invoice_line.track_id
	join genre on genre.genre_id=track.genre_id
	group by 2,3,4
	order by 2 asc, 1 desc
)
select * from popular_genre where rowno <=1

Output:
purchases country	name	            genre_id	rowno
17	Argentina	Alternative & Punk	4	1
34	Australia	Rock	                1	1
40	Austria	        Rock	                1	1
26	Belgium	        Rock	                1	1
205	Brazil	        Rock	                1	1
333	Canada	        Rock	                1	1
61	Chile		Rock	                1	1
143	Czech Republic	Rock	                1	1
24	Denmark	        Rock	                1	1
46	Finland	        Rock	                1	1
211	France	        Rock	                1	1
194	Germany	        Rock	                1	1
44	Hungary	        Rock	                1	1
102	India	        Rock	                1	1
72	Ireland	        Rock	                1	1
35	Italy	        Rock	                1	1
33	Netherlands	Rock	                1	1
40	Norway	        Rock	                1	1
40	Poland	        Rock	                1	1
108	Portugal	Rock	                1	1
46	Spain	        Rock	                1	1
60	Sweden	        Rock	                1	1
166	United Kingdom	Rock	                1	1
561	USA	        Rock	                1	1


/*Q3.Write a quary determine the customer that has spent the most on the music for each country.
Write a query that returns the cuntry along with the top customer and how much they spent. for cuntries where the
the top amount spent is shared, provide all customer who spent this amount?*/

Quary:

with customer_with_country As 
(
    select customer.customer_id, first_name, last_name, billing_country, sum(total) as total_spending,
	Row_number() over (partition By billing_country order by sum(total)desc) As rowno
	from invoice
	join customer on customer.customer_id=invoice.customer_id
	group by 1,2,3,4
	order by 4 asc, 5 desc
)


 select * from customer_with_country where rowno<=1

Output:

customer_id	first_name	                              last_name	                                               billing_country	total_spending	rowno
56	Diego                                             	GutiÃ©rrez                                         	Argentina	     39.6	1
55	Mark                                              	Taylor                                            	Australia	     81.18	1
7	Astrid                                            	Gruber                                            	Austria	             69.3	1
8	Daan                                              	Peeters                                           	Belgium	             60.39	1
1	LuÃ­s                                              	GonÃ§alves                                         	Brazil	             108.9	1
3	FranÃ§ois                                          	Tremblay                                          	Canada	             99.99	1
57	Luis                                              	Rojas                                             	Chile	             97.02	1
5	R                                                 	Madhav                                            	Czech Republic	     144.54	1
9	Kara                                              	Nielsen                                           	Denmark	             37.62	1
44	Terhi                                             	HÃ¤mÃ¤lÃ¤inen                                        	Finland	             79.2	1
42	Wyatt                                             	Girard                                            	France	             99.99	1
37	Fynn                                              	Zimmermann                                        	Germany	             94.05	1
45	Ladislav                                          	KovÃ¡cs                                            	Hungary	             78.21	1
58	Manoj                                             	Pareek                                            	India	             111.87	1
46	Hugh                                              	O'Reilly                                          	Ireland	             114.84	1
47	Lucas                                             	Mancini                                           	Italy	              50.49	1
48	Johannes                                          	Van der Berg                                      	Netherlands	       65.34	1
4	BjÃ¸rn                                             	Hansen                                            	Norway	              72.27	1
49	StanisÅ‚aw                                         	WÃ³jcik                                            	Poland	              76.23	1
34	JoÃ£o                                              	Fernandes                                         	Portugal	      102.96	1
50	Enrique                                           	MuÃ±oz                                             	Spain	              98.01	1
51	Joakim                                            	Johansson                                         	Sweden	              75.24	1
53	Phil                                              	Hughes                                            	United Kingdom	      98.01	1
17	Jack                                              	Smith                                             	USA	              98.01	1

