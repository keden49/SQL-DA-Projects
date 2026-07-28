CREATE DATABASE city_library;
USE city_library;


CREATE TABLE books 
(
book_id INT PRIMARY KEY  AUTO_INCREMENT,
title VARCHAR(200),
author VARCHAR(100),
genre VARCHAR(50),
year_published INT,
available      TINYINT(1),
copies_total   INT,
copies_on_loan INT
);

SELECT author FROM books WHERE author LIKE  '% M%';



INSERT INTO books (title, author, genre, year_published, available, copies_total, copies_on_loan) 
VALUES
('The Great Gatsby',              'F. Scott Fitzgerald', 'Fiction',     1925, 1, 4, 1),
('A Brief History of Time',       'Stephen Hawking',     'Science',     1988, 1, 3, 0),
('Sapiens',                       'Yuval Noah Harari',   'History',     2011, 0, 5, 5),
('1984',                          'George Orwell',       'Fiction',     1949, 1, 6, 2),
('The Guns of War',               'Marcus Webb',         'History',     1978, 0, 2, 2),
('War and Peace',                 'Leo Tolstoy',         'Fiction',     1869, 1, 3, 1),
('The Selfish Gene',              'Richard Dawkins',     'Science',     1976, 0, 4, 4),
('Thinking Fast and Slow',        'Daniel Kahneman',     'Non-Fiction', 2011, 1, 5, 2),
('To Kill a Mockingbird',         'Harper Lee',          'Fiction',     1960, 1, 7, 3),
('Cosmos',                        'Carl Sagan',          'Science',     1980, 0, 3, 3),
('The Invisible Man',             'H.G. Wells',          'Fiction',     1897, 1, 2, 0),
('Guns Germs and Steel',          'Jared Diamond',       'History',     1997, 1, 4, 1),
('The Origin of Species',         'Charles Darwin',      'Science',     1859, 0, 2, 2),
('Americanah',                    'Chimamanda Ngozi Adichie','Fiction', 2013, 1, 5, 1),
('The Art of War',                'Sun Tzu',             'History',     500,  1, 6, 2),
('Atomic Habits',                 'James Clear',         'Non-Fiction', 2018, 0, 8, 8),
('Meditations',                   'Marcus Aurelius',     'Non-Fiction', 180,  1, 3, 0),
('The Alchemist',                 'Paulo Coelho',        'Fiction',     1988, 1, 5, 2),
('Brief Answers to Big Questions','Stephen Hawking',     'Science',     2018, 0, 4, 4),
('Things Fall Apart',             'Chinua Achebe',       'Fiction',     1958, 1, 6, 3);



