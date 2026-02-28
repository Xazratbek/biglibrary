BEGIN;

-- Authors (use full_name as natural key)
INSERT INTO catalog_author (full_name, country, birth_year)
SELECT 'Agatha Christie', 'uk', '1890-09-15'
WHERE NOT EXISTS (SELECT 1 FROM catalog_author WHERE full_name='Agatha Christie');
INSERT INTO catalog_author (full_name, country, birth_year)
SELECT 'Terry Pratchett', 'uk', '1948-04-28'
WHERE NOT EXISTS (SELECT 1 FROM catalog_author WHERE full_name='Terry Pratchett');
INSERT INTO catalog_author (full_name, country, birth_year)
SELECT 'Martin Fowler', 'uk', '1963-12-18'
WHERE NOT EXISTS (SELECT 1 FROM catalog_author WHERE full_name='Martin Fowler');
INSERT INTO catalog_author (full_name, country, birth_year)
SELECT 'Robert C. Martin', 'eng', '1952-12-05'
WHERE NOT EXISTS (SELECT 1 FROM catalog_author WHERE full_name='Robert C. Martin');

-- Genres/Tags (unique by slug)
INSERT OR IGNORE INTO catalog_genre (name, slug) VALUES
  ('Backend', 'backend'),
  ('Detektiv', 'detektiv'),
  ('Fantastika', 'fantastika');

INSERT OR IGNORE INTO catalog_tag (name, slug) VALUES
  ('Python', 'python'),
  ('Backend', 'backend'),
  ('Bestseller', 'bestseller');

-- Extra users (unique by username)
INSERT INTO auth_user (password, last_login, is_superuser, username, last_name, email, is_staff, is_active, date_joined, first_name)
SELECT 'pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'umid', 'Karimov', 'umid@example.com', 0, 1, '2024-09-02 09:00:00', 'Umid'
WHERE NOT EXISTS (SELECT 1 FROM auth_user WHERE username='umid');
INSERT INTO auth_user (password, last_login, is_superuser, username, last_name, email, is_staff, is_active, date_joined, first_name)
SELECT 'pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'sevara', 'Nazarova', 'sevara@example.com', 0, 1, '2024-09-02 09:05:00', 'Sevara'
WHERE NOT EXISTS (SELECT 1 FROM auth_user WHERE username='sevara');

-- Library cards for new users (unique by user_id or phone)
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'basic', 9000.00, '2024-09-02 10:00:00', '2024-09-02 10:00:00', u.id, '+998901111111'
FROM auth_user u
WHERE u.username='umid'
AND NOT EXISTS (SELECT 1 FROM accounts_librarycard WHERE user_id=u.id);
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'pro', 45000.00, '2024-09-02 10:05:00', '2024-09-02 10:05:00', u.id, '+998902222222'
FROM auth_user u
WHERE u.username='sevara'
AND NOT EXISTS (SELECT 1 FROM accounts_librarycard WHERE user_id=u.id);

-- Books (unique by isbn)
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Murder on the Orient Express', 'Detective novel.', a.id, 1934, 'ISBN-978-0301', 'eng', 62000.00, '2024-09-04 11:00:00', '2024-09-04 11:00:00'
FROM catalog_author a
WHERE a.full_name='Agatha Christie'
AND NOT EXISTS (SELECT 1 FROM catalog_book WHERE isbn='ISBN-978-0301');
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Good Omens', 'Fantasy satire.', a.id, 1990, 'ISBN-978-0302', 'eng', 61000.00, '2024-09-04 11:05:00', '2024-09-04 11:05:00'
FROM catalog_author a
WHERE a.full_name='Terry Pratchett'
AND NOT EXISTS (SELECT 1 FROM catalog_book WHERE isbn='ISBN-978-0302');
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Patterns of Enterprise Application Architecture', 'Backend architecture patterns.', a.id, 2002, 'ISBN-978-0303', 'eng', 120000.00, '2024-09-04 11:10:00', '2024-09-04 11:10:00'
FROM catalog_author a
WHERE a.full_name='Martin Fowler'
AND NOT EXISTS (SELECT 1 FROM catalog_book WHERE isbn='ISBN-978-0303');
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Clean Architecture', 'Backend system design.', a.id, 2017, 'ISBN-978-0304', 'eng', 110000.00, '2024-09-04 11:15:00', '2024-09-04 11:15:00'
FROM catalog_author a
WHERE a.full_name='Robert C. Martin'
AND NOT EXISTS (SELECT 1 FROM catalog_book WHERE isbn='ISBN-978-0304');

-- Book genres/tags (avoid duplicates with NOT EXISTS)
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0301' AND g.slug='detektiv'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_genres bg WHERE bg.book_id=b.id AND bg.genre_id=g.id
);
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0302' AND g.slug='fantastika'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_genres bg WHERE bg.book_id=b.id AND bg.genre_id=g.id
);
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0303' AND g.slug='backend'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_genres bg WHERE bg.book_id=b.id AND bg.genre_id=g.id
);
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g
WHERE b.isbn='ISBN-978-0304' AND g.slug='backend'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_genres bg WHERE bg.book_id=b.id AND bg.genre_id=g.id
);

INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t
WHERE b.isbn='ISBN-978-0303' AND t.slug='python'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_tags bt WHERE bt.book_id=b.id AND bt.tag_id=t.id
);
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t
WHERE b.isbn='ISBN-978-0304' AND t.slug='python'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_tags bt WHERE bt.book_id=b.id AND bt.tag_id=t.id
);
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t
WHERE b.isbn='ISBN-978-0301' AND t.slug='bestseller'
AND NOT EXISTS (
  SELECT 1 FROM catalog_book_tags bt WHERE bt.book_id=b.id AND bt.tag_id=t.id
);

-- Branches (unique by name)
INSERT INTO circulation_branch (name, city, address)
SELECT 'Buxoro filial', 'Buxoro', 'Ibn Sino ko''chasi, 8-uy'
WHERE NOT EXISTS (SELECT 1 FROM circulation_branch WHERE name='Buxoro filial');

-- Book copies (unique by inventory_code)
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-201', 'available', '2024-09-05 09:00:00'
FROM catalog_book b, circulation_branch br
WHERE b.isbn='ISBN-978-0301' AND br.name='Buxoro filial'
AND NOT EXISTS (SELECT 1 FROM circulation_bookcopy WHERE inventory_code='INV-201');
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-202', 'available', '2024-09-05 09:05:00'
FROM catalog_book b, circulation_branch br
WHERE b.isbn='ISBN-978-0302' AND br.name='Buxoro filial'
AND NOT EXISTS (SELECT 1 FROM circulation_bookcopy WHERE inventory_code='INV-202');
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-203', 'borrowed', '2024-09-05 09:10:00'
FROM catalog_book b, circulation_branch br
WHERE b.isbn='ISBN-978-0303' AND br.name='Markaziy filial'
AND NOT EXISTS (SELECT 1 FROM circulation_bookcopy WHERE inventory_code='INV-203');
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-204', 'reserved', '2024-09-05 09:15:00'
FROM catalog_book b, circulation_branch br
WHERE b.isbn='ISBN-978-0304' AND br.name='Chilonzor filial'
AND NOT EXISTS (SELECT 1 FROM circulation_bookcopy WHERE inventory_code='INV-204');

-- Reviews (unique by user_id+book_id enforced)
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Detektiv janri uchun zo''r.', '2024-09-06 12:00:00', b.id, u.id
FROM catalog_book b, auth_user u
WHERE b.isbn='ISBN-978-0301' AND u.username='umid'
AND NOT EXISTS (
  SELECT 1 FROM reviews_reviews r WHERE r.book_id=b.id AND r.user_id=u.id
);
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Backend kitoblar ichida foydali.', '2024-09-06 12:05:00', b.id, u.id
FROM catalog_book b, auth_user u
WHERE b.isbn='ISBN-978-0303' AND u.username='sevara'
AND NOT EXISTS (
  SELECT 1 FROM reviews_reviews r WHERE r.book_id=b.id AND r.user_id=u.id
);

-- Borrows (avoid duplicates by copy_id+user_id+borrowed_at)
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-15 10:00:00', '2024-08-29 10:00:00', '2024-08-28 12:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u
WHERE c.inventory_code='INV-201' AND u.username='umid'
AND NOT EXISTS (
  SELECT 1 FROM circulation_borrow b WHERE b.copy_id=c.id AND b.user_id=u.id AND b.borrowed_at='2024-08-15 10:00:00'
);
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-08-16 10:00:00', '2024-08-30 10:00:00', '2024-09-02 12:00:00', 4000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u
WHERE c.inventory_code='INV-203' AND u.username='sevara'
AND NOT EXISTS (
  SELECT 1 FROM circulation_borrow b WHERE b.copy_id=c.id AND b.user_id=u.id AND b.borrowed_at='2024-08-16 10:00:00'
);

-- Overdue example (due_at past)
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-07-20 10:00:00', '2024-07-27 10:00:00', '2024-08-01 12:00:00', 6000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u
WHERE c.inventory_code='INV-204' AND u.username='umid'
AND NOT EXISTS (
  SELECT 1 FROM circulation_borrow b WHERE b.copy_id=c.id AND b.user_id=u.id AND b.borrowed_at='2024-07-20 10:00:00'
);

-- Active reservations for a user
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'active', '2024-09-28 09:00:00', '2024-10-05 09:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u
WHERE b.isbn='ISBN-978-0303' AND br.name='Markaziy filial' AND u.username='umid'
AND NOT EXISTS (
  SELECT 1 FROM circulation_reservation r
  WHERE r.book_id=b.id AND r.branch_id=br.id AND r.user_id=u.id AND r.status='active' AND r.created_at='2024-09-28 09:00:00'
);

COMMIT;
