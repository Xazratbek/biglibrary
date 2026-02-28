BEGIN;

-- UK authors (country value not enforced at DB level)
INSERT INTO catalog_author (full_name, country, birth_year) VALUES
  ('George Orwell', 'uk', '1903-06-25'),
  ('J.K. Rowling', 'uk', '1965-07-31'),
  ('Kazuo Ishiguro', 'uk', '1954-11-08');

-- Additional genres/tags needed for filters
INSERT OR IGNORE INTO catalog_genre (name, slug) VALUES
  ('Backend', 'backend');

INSERT OR IGNORE INTO catalog_tag (name, slug) VALUES
  ('Python', 'python');

-- Books for UK authors + backend/year>=2000
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT '1984', 'Dystopian classic.', id, 1949, 'ISBN-978-0101', 'eng', 65000.00, '2024-09-03 10:00:00', '2024-09-03 10:00:00'
FROM catalog_author WHERE full_name='George Orwell';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Animal Farm', 'Political satire novella.', id, 1945, 'ISBN-978-0102', 'eng', 42000.00, '2024-09-03 10:05:00', '2024-09-03 10:05:00'
FROM catalog_author WHERE full_name='George Orwell';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Harry Potter and the Philosopher''s Stone', 'Fantasy novel.', id, 1997, 'ISBN-978-0103', 'eng', 70000.00, '2024-09-03 10:10:00', '2024-09-03 10:10:00'
FROM catalog_author WHERE full_name='J.K. Rowling';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Never Let Me Go', 'Dystopian science fiction.', id, 2005, 'ISBN-978-0104', 'eng', 68000.00, '2024-09-03 10:15:00', '2024-09-03 10:15:00'
FROM catalog_author WHERE full_name='Kazuo Ishiguro';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Backend Engineering with Python', 'Backend architecture and Python patterns.', id, 2021, 'ISBN-978-0201', 'eng', 90000.00, '2024-09-03 10:20:00', '2024-09-03 10:20:00'
FROM catalog_author WHERE full_name='George Orwell';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Scalable Backend Systems', 'Modern backend systems, post-2000.', id, 2022, 'ISBN-978-0202', 'eng', 95000.00, '2024-09-03 10:25:00', '2024-09-03 10:25:00'
FROM catalog_author WHERE full_name='J.K. Rowling';

-- Attach backend genre to backend books
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0201' AND g.slug='backend';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0202' AND g.slug='backend';

-- Tag python on backend books
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t
WHERE b.isbn='ISBN-978-0201' AND t.slug='python';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t
WHERE b.isbn='ISBN-978-0202' AND t.slug='python';

-- Add some tags/genres to UK books for diversity
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0101' AND g.slug='roman';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t
WHERE b.isbn='ISBN-978-0101' AND t.slug='klassika';

-- More branches if needed
INSERT INTO circulation_branch (name, city, address) VALUES
  ('Namangan filial', 'Namangan', 'Bobur ko''chasi, 3-uy');

-- More copies with AVAILABLE status for counting
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-101', 'available', '2024-09-04 09:00:00'
FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0101' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-102', 'available', '2024-09-04 09:05:00'
FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0102' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-103', 'available', '2024-09-04 09:10:00'
FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0103' AND br.name='Samarqand filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-104', 'available', '2024-09-04 09:15:00'
FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0201' AND br.name='Namangan filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-105', 'available', '2024-09-04 09:20:00'
FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0202' AND br.name='Namangan filial';

-- Reviews with rating >=4 for specific books
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Yaxshi yozilgan.', '2024-09-05 10:30:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0101' AND u.username='aziza';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Ajoyib!', '2024-09-05 10:35:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0102' AND u.username='jamshid';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Juda foydali.', '2024-09-05 10:40:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0201' AND u.username='shirin';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Backend uchun zo''r.', '2024-09-05 10:45:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0202' AND u.username='botir';

-- Extra borrows to make top-5 most borrowed books
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-01 10:00:00', '2024-08-15 10:00:00', '2024-08-14 09:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-101' AND u.username='aziza';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-05 10:00:00', '2024-08-19 10:00:00', '2024-08-18 12:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-102' AND u.username='jamshid';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-07 10:00:00', '2024-08-21 10:00:00', '2024-08-20 15:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-103' AND u.username='shirin';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-09 10:00:00', '2024-08-23 10:00:00', '2024-08-22 11:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-104' AND u.username='botir';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-11 10:00:00', '2024-08-25 10:00:00', '2024-08-24 11:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-105' AND u.username='nargiza';

-- Overdue borrows (due_at in past)
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-07-01 10:00:00', '2024-07-10 10:00:00', '2024-07-12 12:00:00', 3000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-003' AND u.username='dilshod';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-07-05 10:00:00', '2024-07-12 10:00:00', '2024-07-20 12:00:00', 5000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-004' AND u.username='madina';

-- Active reservations for a specific user
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'active', '2024-09-27 09:00:00', '2024-10-04 09:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u
WHERE b.isbn='ISBN-978-0201' AND br.name='Namangan filial' AND u.username='aziza';

COMMIT;
