create database cinema_management;
use cinema_management;

create table users(
    id int auto_increment primary key,
    username varchar(50) not null,
    password varchar(255) not null,
    email varchar(100) not null,
    gender enum('MALE','FEMALE','OTHER') not null,
    phone char(10) not null,
    address varchar(255) not null
);


insert into users(username,password,email,gender,phone,address) values
('admin','admin','admin@admin','MALE','1234567890','admin address'),
('user1','user1','user1@user1','MALE','1234567891','user1 address'),
('user2','user2','user@user2','FEMALE','1234567892','user2 address'),
('user3','user3','user3@user3','OTHER','1234567893','user3 address');

DELIMITER //
CREATE PROCEDURE login(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM users WHERE username = p_username AND password = p_password
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid username or password';
    END IF;

    SELECT id, username FROM users
    WHERE username = p_username AND password = p_password;
END //
DELIMITER ;


create table movies(
    id int auto_increment primary key,
    title varchar(100) not null,
    director varchar(100) not null,
    genre varchar(50) not null,
    description text not null,
    duration int not null,
    language varchar(50) not null
);


insert into movies (title, director, genre, description, duration, language) values
 ('Inception', 'Christopher Nolan', 'Sci-Fi', 'A thief who steals corporate secrets through dream-sharing technology.', 148, 'English'),
 ('The Godfather', 'Francis Ford Coppola', 'Crime', 'The aging patriarch of an organized crime dynasty transfers control to his reluctant son.', 175, 'English'),
 ('Parasite', 'Bong Joon Ho', 'Thriller', 'A poor family schemes to become employed by a wealthy family.', 132, 'Korean'),
 ('The Dark Knight', 'Christopher Nolan', 'Action', 'Batman faces the Joker, a criminal mastermind.', 152, 'English'),
 ('Interstellar', 'Christopher Nolan', 'Sci-Fi', 'A team of explorers travels through a wormhole in space.', 169, 'English'),
 ('Titanic', 'James Cameron', 'Romance', 'A love story unfolds on the ill-fated Titanic.', 195, 'English'),
 ('Avengers: Endgame', 'Anthony Russo, Joe Russo', 'Action', 'The Avengers assemble to reverse Thanos\' actions.', 181, 'English'),
 ('The Shawshank Redemption', 'Frank Darabont', 'Drama', 'Two imprisoned men bond over years.', 142, 'English'),
 ('Joker', 'Todd Phillips', 'Drama', 'A mentally troubled comedian descends into madness.', 122, 'English'),
 ('Spirited Away', 'Hayao Miyazaki', 'Animation', 'A young girl becomes trapped in a mysterious world.', 125, 'Japanese'),
 ('The Matrix', 'Lana Wachowski, Lilly Wachowski', 'Sci-Fi', 'A hacker discovers the truth about his reality.', 136, 'English'),
 ('Forrest Gump', 'Robert Zemeckis', 'Drama', 'The life story of a slow-witted but kind-hearted man.', 142, 'English'),
 ('The Lion King', 'Roger Allers, Rob Minkoff', 'Animation', 'A lion cub flees his kingdom after his father\'s death.', 88, 'English'),
 ('Pulp Fiction', 'Quentin Tarantino', 'Crime', 'The lives of two mob hitmen intertwine.', 154, 'English'),
 ('Coco', 'Lee Unkrich, Adrian Molina', 'Animation', 'A boy journeys to the Land of the Dead.', 105, 'English'),
 ('The Avengers', 'Joss Whedon', 'Action', 'Earth\'s mightiest heroes must stop Loki.', 143, 'English'),
 ('Frozen', 'Chris Buck, Jennifer Lee', 'Animation', 'A princess sets out to find her estranged sister.', 102, 'English'),
 ('Black Panther', 'Ryan Coogler', 'Action', 'Challa returns home to Wakanda to take the throne.', 134, 'English'),
 ('The Silence of the Lambs', 'Jonathan Demme', 'Thriller', 'A young FBI cadet seeks the help of a cannibalistic killer.', 118, 'English'),
 ('The Social Network', 'David Fincher', 'Drama', 'The story of Facebook\'s creation.', 120, 'English'),
 ('Toy Story', 'John Lasseter', 'Animation', 'A cowboy doll feels threatened by a new toy.', 81, 'English'),
 ('The Grand Budapest Hotel', 'Wes Anderson', 'Comedy', 'The adventures of a legendary concierge.', 99, 'English');

DELIMITER //

CREATE PROCEDURE get_paginated_movies(
    IN p_page_number INT,
    IN p_page_size INT
)
BEGIN
    DECLARE v_offset INT;

    SET v_offset = (p_page_number - 1) * p_page_size;

    SELECT * FROM movies
    LIMIT p_page_size OFFSET v_offset;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE get_total_pages(
    IN p_page_size INT,
    OUT p_total_pages INT
)
BEGIN
    DECLARE v_total_records INT;

    SELECT COUNT(*) INTO v_total_records FROM movies;

    SET p_total_pages = CEIL(v_total_records / p_page_size);
END //

DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_movie_details(
    IN p_movie_id INT
)
BEGIN
    SELECT * FROM movies WHERE id = p_movie_id;
END //
DELIMITER ;



CREATE TABLE screen_rooms (
  id INT PRIMARY KEY AUTO_INCREMENT,
  screen_room_name VARCHAR(100) NOT NULL,
  total_seat INT NOT NULL
);
INSERT INTO screen_rooms (screen_room_name, total_seat)
VALUES ('Phòng 1', 100),
       ('Phòng 2', 120),
       ('Phòng 3', 80);



CREATE TABLE schedules (
   id INT PRIMARY KEY AUTO_INCREMENT,
   movie_id INT NOT NULL,
   show_time DATETIME NOT NULL,
   screen_room_id INT NOT NULL,
   available_seats INT NOT NULL,
   format ENUM('2D', '3D') NOT NULL,

   FOREIGN KEY (movie_id) REFERENCES movies(id),
   FOREIGN KEY (screen_room_id) REFERENCES screen_rooms(id)
);

DELIMITER //

CREATE PROCEDURE get_schedules_by_movie_id(IN p_movie_id INT)
BEGIN
    SELECT * FROM schedules
    WHERE movie_id = p_movie_id
    ORDER BY show_time ASC;
END //

DELIMITER ;

INSERT INTO schedules (movie_id, show_time, screen_room_id, available_seats, format)
VALUES
    (1, '2025-05-17 14:00:00', 1, 100, '2D'),
    (1, '2025-05-17 18:00:00', 2, 90, '3D'),
    (2, '2025-05-18 16:30:00', 3, 80, '2D');

CREATE TABLE seats (
   id INT PRIMARY KEY AUTO_INCREMENT,
   screen_room_id INT,
   price DOUBLE DEFAULT 50000,
   status ENUM('AVAILABLE', 'BOOKED') DEFAULT 'AVAILABLE'
);

CREATE TABLE tickets (
 id INT PRIMARY KEY AUTO_INCREMENT,
 user_id INT,
 schedule_id INT,
 total_money DOUBLE,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE ticket_seats (
  ticket_id INT,
  seat_id INT,
  PRIMARY KEY (ticket_id, seat_id)

);

DELIMITER //

CREATE PROCEDURE create_ticket(
    IN p_customer_id INT,
    IN p_schedule_id INT,
    IN p_total_money DOUBLE,
    IN p_created_at DATETIME,
    OUT p_ticket_id BIGINT
)
BEGIN
    INSERT INTO tickets (tickets.user_id, schedule_id, total_money, created_at)
    VALUES (p_customer_id, p_schedule_id, p_total_money, p_created_at);

    SET p_ticket_id = LAST_INSERT_ID();
END //

CREATE PROCEDURE add_ticket_seat(
    IN p_ticket_id BIGINT,
    IN p_seat_id BIGINT
)
BEGIN
    INSERT INTO ticket_seats (ticket_id, seat_id)
    VALUES (p_ticket_id, p_seat_id);
END //

DELIMITER ;

DELIMITER //

DELIMITER //
CREATE PROCEDURE find_user_by_username(
    IN p_username VARCHAR(50)
)
BEGIN
    SELECT * FROM users
    WHERE username = p_username;
END //

DELIMITER ;
