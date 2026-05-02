CREATE SCHEMA library;
CREATE TABLE authors (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE
);
CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    category_id INT,
    publication_year INT,
    available_copies INT CHECK (available_copies >= 0),

    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
CREATE TABLE members (
    member_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    membership_date DATE DEFAULT GETDATE()
);
CREATE TABLE borrow_records (
    borrow_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,

    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
CREATE TABLE reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT,
    book_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text VARCHAR(MAX),

    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO authors (author_name) VALUES
('J.K. Rowling'), ('Chetan Bhagat'), ('Dan Brown'),
('Paulo Coelho'), ('Agatha Christie');
INSERT INTO categories (category_name) VALUES
('Fiction'), ('Science'), ('History'), ('Technology'), ('Mystery');
INSERT INTO books (title, author_id, category_id, publication_year, available_copies) VALUES
('Harry Potter',1,1,2000,5),
('The Alchemist',4,1,1988,4),
('Da Vinci Code',3,5,2003,3),
('2 States',2,1,2009,6);
INSERT INTO members (name,email) VALUES
('Riya Sharma','riya@gmail.com'),
('Arjun Patel','arjun@gmail.com');
CREATE TRIGGER trg_borrow_book
ON borrow_records
AFTER INSERT
AS
BEGIN
    UPDATE b
    SET b.available_copies = b.available_copies - 1
    FROM books b
    JOIN INSERTED i ON b.book_id = i.book_id;
END;
CREATE TRIGGER trg_return_book
ON borrow_records
AFTER UPDATE
AS
BEGIN
    UPDATE b
    SET b.available_copies = b.available_copies + 1
    FROM books b
    JOIN INSERTED i ON b.book_id = i.book_id
    JOIN DELETED d ON i.borrow_id = d.borrow_id
    WHERE d.return_date IS NULL AND i.return_date IS NOT NULL;
END;
INSERT INTO borrow_records (member_id, book_id, borrow_date, due_date)
VALUES (1,1,GETDATE(), DATEADD(DAY,14,GETDATE()));
UPDATE borrow_records
SET return_date = GETDATE()
WHERE borrow_id = 1;
SELECT * FROM books;
SELECT m.name, b.title, br.borrow_date
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id;
SELECT m.name, b.title, br.due_date
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL AND br.due_date < GETDATE();
SELECT b.title, COUNT(*) AS total_borrows
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.title
ORDER BY total_borrows DESC;
SELECT m.name, COUNT(*) AS total_books
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.name
ORDER BY total_books DESC;
SELECT b.title, AVG(r.rating) AS avg_rating
FROM reviews r
JOIN books b ON r.book_id = b.book_id
GROUP BY b.title
ORDER BY avg_rating DESC;
SELECT DISTINCT m.member_id, b2.title
FROM borrow_records br
JOIN books b1 ON br.book_id = b1.book_id
JOIN books b2 ON b1.category_id = b2.category_id
JOIN members m ON br.member_id = m.member_id
WHERE b1.book_id <> b2.book_id;
SELECT TOP 5 book_id, COUNT(*) AS total
FROM borrow_records
GROUP BY book_id
ORDER BY total DESC;
SELECT book_id
FROM reviews
GROUP BY book_id
HAVING AVG(rating) > 4;
CREATE INDEX idx_borrow_book ON borrow_records(book_id);
CREATE INDEX idx_member ON borrow_records(member_id);
SELECT * FROM authors;
SELECT * FROM categories;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrow_records;

SELECT * FROM reviews;