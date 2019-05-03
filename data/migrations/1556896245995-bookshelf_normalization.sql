
-- creates a new table for normalized data
CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- gets unique bookshelf names and adds to bookshelves
INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

-- adds bookshelf id column to books table
ALTER TABLE books ADD COLUMN bookshelf_id INT;

-- finds books that have a bookshelf value matching the bookshelf name and adds the bookshelf id to the book
UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;

-- gets rid of the bookshelf column in the books table
ALTER TABLE books DROP COLUMN bookshelf;

-- connects the tables by setting the bookshelf id of each book to a foreign key referencing the bookshelves id
ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);