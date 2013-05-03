CREATE TABLE chefs 
(
id INTEGER PRIMARY KEY,
first_name VARCHAR(25),
last_name VARCHAR(25),
mentor INTEGER
);

CREATE TABLE restaurants
(
id INTEGER PRIMARY KEY,
name VARCHAR(100),
neighborhood VARCHAR(50),
cuisine VARCHAR(50)
);


CREATE TABLE chef_tenures
(
id INTEGER PRIMARY KEY,
chef_id INTEGER,
restaurant_id INTEGER,
start_date VARCHAR(50),
end_date VARCHAR(50),
head_chef INTEGER, 
FOREIGN KEY (chef_id) REFERENCES chefs(chef_id),
FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);


CREATE TABLE critics 
(
id INTEGER PRIMARY KEY,
screen_name VARCHAR(25)
);

CREATE TABLE restaurant_reviews
(
id INTEGER PRIMARY KEY,
critic_id INTEGER,
restaurant_id INTEGER,
review_text VARCHAR(20000),
score INTEGER,
review_date VARCHAR(50),
FOREIGN KEY (critic_id) REFERENCES critics(id),
FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) 
);



/*SAMPLE DATA*/



INSERT INTO chefs (first_name, last_name, mentor)
VALUES ("George","K",NULL), /*id 1*/
			 ("Dmitri","D",NULL), /*id 2*/
			 ("Angelo","K",1), /*id 3*/
			 ("George","D",2), /*id 4*/
			 ("Honeybee","Kay",3), /*id 5*/
			 ("Amalia","K",1);


INSERT INTO restaurants (name, neighborhood, cuisine)
VALUES ("George's Kitchen","High Point","Vegetarian"), /*id 1*/
			 ("Triki's Corner","Downbeach", "Greek Diner"), /*id 2*/
			 ("The Pad","Limbo","Steakhouse"), /*id 3*/
			 ("Melalani","Downbeach", "American"); /*id 4*/


INSERT INTO chef_tenures (chef_id, restaurant_id, start_date, end_date, head_chef)
VALUES (1,1,'1985-01-01', NULL, 1),
			 (2,2,'2004-06-15', '2011-02-01',1),
			 (2,4,'2011-02-02', '2013-05-01',1),
			 (3,1,'1995-01-01', '2000-09-01',0),
			 (3,3,'2000-09-01', '2013-05-01',1),
			 (4,2,'2000-09-01', '2011-02-01',0),
			 (4,4,'2011-02-02', '2013-05-01',0),
			 (5,3,'2010-10-22', '2013-05-01',0);


INSERT INTO critics (screen_name)
VALUES ("bolio"), /*id 1*/
		   ("yiayia"),	/*id 2*/
		   ("jason"), /*id 3*/
		   ("bigD"), /*id 4*/
		   ("HKREAZ4EVA"); /*id 5*/



INSERT INTO restaurant_reviews (critic_id, restaurant_id, review_text, score, review_date)
VALUES (1, 1, "This place is the best! Love the homemade pizza!", 20, '2011-04-03'),
			 (2, 1, "Is Beautiful. I love the vegitables.", 20, '2007-06-01'),
			 (3, 4, "Bangin' food.", 15, '2012-08-01'),
			 (4, 3, "Started eating meat again because of this place.", 16, "2013-04-29"),
			 (5, 3, "It's good, but too much work.", 12, '2011-09-13'),
			 (5, 1, "The people here are weird.", 8, '2013-04-13');


