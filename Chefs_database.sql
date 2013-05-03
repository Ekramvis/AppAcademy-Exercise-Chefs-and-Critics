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

/*connects chefs with restaurants*/
CREATE TABLE chef_tenures
(
id INTEGER PRIMARY KEY,
chef_id INTEGER,
restaurant_id INTEGER,
start_date VARCHAR(50),
end_date VARCHAR(50),
head_chef ENUM(0, 1, NULL), 
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
score ENUM(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),   
review_date VARCHAR(50),
FOREIGN KEY (critic_id) REFERENCES critics(id),
FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) 
);