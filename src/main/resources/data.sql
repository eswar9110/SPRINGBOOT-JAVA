-- =============================================
-- Sample Data for Authors Table (10 rows)
-- =============================================
INSERT INTO authors (name, email, bio) VALUES ('J.K. Rowling', 'jk.rowling@email.com', 'British author best known for the Harry Potter fantasy series.');
INSERT INTO authors (name, email, bio) VALUES ('George Orwell', 'george.orwell@email.com', 'English novelist and essayist known for his sharp criticism of political oppression.');
INSERT INTO authors (name, email, bio) VALUES ('Jane Austen', 'jane.austen@email.com', 'English novelist known for her commentary on the British landed gentry.');
INSERT INTO authors (name, email, bio) VALUES ('Mark Twain', 'mark.twain@email.com', 'American writer, humorist, and lecturer, often called the father of American literature.');
INSERT INTO authors (name, email, bio) VALUES ('Leo Tolstoy', 'leo.tolstoy@email.com', 'Russian writer regarded as one of the greatest authors of all time.');
INSERT INTO authors (name, email, bio) VALUES ('Agatha Christie', 'agatha.christie@email.com', 'English writer known for her detective novels featuring Hercule Poirot and Miss Marple.');
INSERT INTO authors (name, email, bio) VALUES ('Ernest Hemingway', 'ernest.hemingway@email.com', 'American novelist and short-story writer, known for his economical and understated style.');
INSERT INTO authors (name, email, bio) VALUES ('Gabriel Garcia Marquez', 'gabriel.marquez@email.com', 'Colombian novelist and Nobel Prize laureate, known for his magical realism.');
INSERT INTO authors (name, email, bio) VALUES ('Fyodor Dostoevsky', 'fyodor.dostoevsky@email.com', 'Russian novelist and philosopher, known for exploring human psychology.');
INSERT INTO authors (name, email, bio) VALUES ('Harper Lee', 'harper.lee@email.com', 'American novelist known for her Pulitzer Prize-winning novel To Kill a Mockingbird.');

-- =============================================
-- Sample Data for Books Table (10 rows)
-- =============================================
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('Harry Potter and the Philosophers Stone', '978-0-7475-3269-9', 24.99, 1997, 1);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('1984', '978-0-452-28423-4', 15.99, 1949, 2);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('Pride and Prejudice', '978-0-19-953556-9', 12.99, 1813, 3);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('Adventures of Huckleberry Finn', '978-0-14-243717-0', 11.50, 1884, 4);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('War and Peace', '978-0-14-044793-4', 18.75, 1869, 5);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('Murder on the Orient Express', '978-0-06-269366-2', 14.99, 1934, 6);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('The Old Man and the Sea', '978-0-684-80122-3', 13.50, 1952, 7);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('One Hundred Years of Solitude', '978-0-06-088328-7', 16.99, 1967, 8);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('Crime and Punishment', '978-0-14-044913-6', 14.25, 1866, 9);
INSERT INTO books (title, isbn, price, year_published, author_id) VALUES ('To Kill a Mockingbird', '978-0-06-112008-4', 15.49, 1960, 10);
