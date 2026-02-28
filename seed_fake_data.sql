BEGIN;

-- Users
INSERT INTO auth_user (password, last_login, is_superuser, username, last_name, email, is_staff, is_active, date_joined, first_name)
VALUES
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'aziza', 'Karimova', 'aziza@example.com', 0, 1, '2024-09-01 09:00:00', 'Aziza'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'jamshid', 'Aliyev', 'jamshid@example.com', 0, 1, '2024-09-01 09:05:00', 'Jamshid'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'shirin', 'Sodiqova', 'shirin@example.com', 0, 1, '2024-09-01 09:10:00', 'Shirin'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'botir', 'Qodirov', 'botir@example.com', 0, 1, '2024-09-01 09:15:00', 'Botir'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'nargiza', 'Usmonova', 'nargiza@example.com', 0, 1, '2024-09-01 09:20:00', 'Nargiza'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'sardor', 'Ergashev', 'sardor@example.com', 0, 1, '2024-09-01 09:25:00', 'Sardor'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'dilshod', 'Rahimov', 'dilshod@example.com', 0, 1, '2024-09-01 09:30:00', 'Dilshod'),
  ('pbkdf2_sha256$260000$dummy$hash', NULL, 0, 'madina', 'Yusupova', 'madina@example.com', 0, 1, '2024-09-01 09:35:00', 'Madina');

-- Library cards
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'basic', 15000.00, '2024-09-01 10:00:00', '2024-09-01 10:00:00', id, '+998901234567' FROM auth_user WHERE username='aziza';
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'pro', 32000.00, '2024-09-01 10:05:00', '2024-09-01 10:05:00', id, '+998911112233' FROM auth_user WHERE username='jamshid';
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'basic', 8000.00, '2024-09-01 10:10:00', '2024-09-01 10:10:00', id, '+998933334455' FROM auth_user WHERE username='shirin';
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'pro', 54000.00, '2024-09-01 10:15:00', '2024-09-01 10:15:00', id, '+998943332211' FROM auth_user WHERE username='botir';
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'basic', 12000.00, '2024-09-01 10:20:00', '2024-09-01 10:20:00', id, '+998971010101' FROM auth_user WHERE username='nargiza';
INSERT INTO accounts_librarycard (membership_level, balance, created_at, updated_at, user_id, phone)
SELECT 'pro', 76000.00, '2024-09-01 10:25:00', '2024-09-01 10:25:00', id, '+998981212121' FROM auth_user WHERE username='sardor';

-- Authors
INSERT INTO catalog_author (full_name, country, birth_year) VALUES
  ('Abdulla Qodiriy', 'uz', '1894-04-10'),
  ('O''tkir Hoshimov', 'uz', '1941-08-05'),
  ('Chingiz Aytmatov', 'ru', '1928-12-12'),
  ('Fyodor Dostoevsky', 'ru', '1821-11-11'),
  ('Ernest Hemingway', 'eng', '1899-07-21'),
  ('G''afur G''ulom', 'uz', '1903-05-10');

-- Genres
INSERT INTO catalog_genre (name, slug) VALUES
  ('Roman', 'roman'),
  ('Qissa', 'qissa'),
  ('Tarixiy', 'tarixiy'),
  ('Detektiv', 'detektiv'),
  ('Fantastika', 'fantastika'),
  ('Psixologik', 'psixologik');

-- Tags
INSERT INTO catalog_tag (name, slug) VALUES
  ('Klassika', 'klassika'),
  ('Yoshlar', 'yoshlar'),
  ('Sarguzasht', 'sarguzasht'),
  ('Ijtimoiy', 'ijtimoiy'),
  ('Tibbiy', 'tibbiy'),
  ('Drama', 'drama'),
  ('Qiziqarli', 'qiziqarli'),
  ('Motivatsiya', 'motivatsiya');

-- Books
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'O''tkan kunlar', 'Tarixiy roman, sevgi va jamiyat haqida.', id, 1926, 'ISBN-978-0001', 'uz', 55000.00, '2024-09-01 11:00:00', '2024-09-01 11:00:00' FROM catalog_author WHERE full_name='Abdulla Qodiriy';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Dunyoning ishlari', 'Insoniy qadriyatlar va hayotiy voqealar.', id, 1982, 'ISBN-978-0002', 'uz', 48000.00, '2024-09-01 11:05:00', '2024-09-01 11:05:00' FROM catalog_author WHERE full_name='O''tkir Hoshimov';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Jamila', 'Qissa va sevgi hikoyasi.', id, 1958, 'ISBN-978-0003', 'ru', 42000.00, '2024-09-01 11:10:00', '2024-09-01 11:10:00' FROM catalog_author WHERE full_name='Chingiz Aytmatov';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Jinoyat va jazo', 'Psixologik roman.', id, 1866, 'ISBN-978-0004', 'ru', 60000.00, '2024-09-01 11:15:00', '2024-09-01 11:15:00' FROM catalog_author WHERE full_name='Fyodor Dostoevsky';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Chol va dengiz', 'Qisqa roman, iroda va umid haqida.', id, 1952, 'ISBN-978-0005', 'eng', 39000.00, '2024-09-01 11:20:00', '2024-09-01 11:20:00' FROM catalog_author WHERE full_name='Ernest Hemingway';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Shum bola', 'Yoshlar uchun sarguzasht qissa.', id, 1936, 'ISBN-978-0006', 'uz', 36000.00, '2024-09-01 11:25:00', '2024-09-01 11:25:00' FROM catalog_author WHERE full_name='G''afur G''ulom';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Tushlar', 'Ijtimoiy-dramatik roman.', id, 1985, 'ISBN-978-0007', 'uz', 52000.00, '2024-09-01 11:30:00', '2024-09-01 11:30:00' FROM catalog_author WHERE full_name='O''tkir Hoshimov';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Oq kema', 'Qissa, bolalik va tabiat haqida.', id, 1970, 'ISBN-978-0008', 'ru', 41000.00, '2024-09-01 11:35:00', '2024-09-01 11:35:00' FROM catalog_author WHERE full_name='Chingiz Aytmatov';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Kambag''allar', 'Ijtimoiy roman.', id, 1846, 'ISBN-978-0009', 'ru', 57000.00, '2024-09-01 11:40:00', '2024-09-01 11:40:00' FROM catalog_author WHERE full_name='Fyodor Dostoevsky';
INSERT INTO catalog_book (title, description, author_id, published_year, isbn, language, price, created_at, updated_at)
SELECT 'Quyosh ham chiqadi', 'Roman, urushdan keyingi hayot.', id, 1926, 'ISBN-978-0010', 'eng', 59000.00, '2024-09-01 11:45:00', '2024-09-01 11:45:00' FROM catalog_author WHERE full_name='Ernest Hemingway';

-- Book genres (M2M)
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0001' AND g.slug='tarixiy';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0001' AND g.slug='roman';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0002' AND g.slug='roman';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0003' AND g.slug='qissa';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0004' AND g.slug='psixologik';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0005' AND g.slug='roman';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0006' AND g.slug='qissa';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0007' AND g.slug='roman';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0008' AND g.slug='qissa';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0009' AND g.slug='psixologik';
INSERT INTO catalog_book_genres (book_id, genre_id)
SELECT b.id, g.id FROM catalog_book b, catalog_genre g WHERE b.isbn='ISBN-978-0010' AND g.slug='roman';

-- Book tags (M2M)
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0001' AND t.slug='klassika';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0001' AND t.slug='ijtimoiy';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0002' AND t.slug='drama';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0002' AND t.slug='klassika';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0003' AND t.slug='yoshlar';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0004' AND t.slug='klassika';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0004' AND t.slug='drama';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0005' AND t.slug='sarguzasht';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0006' AND t.slug='qiziqarli';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0007' AND t.slug='ijtimoiy';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0008' AND t.slug='yoshlar';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0009' AND t.slug='drama';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0010' AND t.slug='klassika';
INSERT INTO catalog_book_tags (book_id, tag_id)
SELECT b.id, t.id FROM catalog_book b, catalog_tag t WHERE b.isbn='ISBN-978-0010' AND t.slug='motivatsiya';

-- Branches
INSERT INTO circulation_branch (name, city, address) VALUES
  ('Markaziy filial', 'Toshkent', 'Yunusobod tumani, 12-uy'),
  ('Chilonzor filial', 'Toshkent', 'Chilonzor 5-mavze, 45-uy'),
  ('Samarqand filial', 'Samarqand', 'Registon ko''chasi, 7-uy');

-- Book copies
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-001', 'available', '2024-09-02 09:00:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0001' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-002', 'borrowed', '2024-09-02 09:05:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0001' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-003', 'reserved', '2024-09-02 09:10:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0002' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-004', 'available', '2024-09-02 09:15:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0002' AND br.name='Samarqand filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-005', 'borrowed', '2024-09-02 09:20:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0003' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-006', 'available', '2024-09-02 09:25:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0003' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-007', 'available', '2024-09-02 09:30:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0004' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-008', 'lost', '2024-09-02 09:35:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0004' AND br.name='Samarqand filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-009', 'available', '2024-09-02 09:40:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0005' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-010', 'reserved', '2024-09-02 09:45:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0006' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-011', 'available', '2024-09-02 09:50:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0006' AND br.name='Samarqand filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-012', 'borrowed', '2024-09-02 09:55:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0007' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-013', 'available', '2024-09-02 10:00:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0008' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-014', 'available', '2024-09-02 10:05:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0009' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-015', 'borrowed', '2024-09-02 10:10:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0010' AND br.name='Samarqand filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-016', 'available', '2024-09-02 10:15:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0005' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-017', 'reserved', '2024-09-02 10:20:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0007' AND br.name='Samarqand filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-018', 'available', '2024-09-02 10:25:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0008' AND br.name='Chilonzor filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-019', 'available', '2024-09-02 10:30:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0009' AND br.name='Markaziy filial';
INSERT INTO circulation_bookcopy (book_id, branch_id, inventory_code, status, added_at)
SELECT b.id, br.id, 'INV-020', 'available', '2024-09-02 10:35:00' FROM catalog_book b, circulation_branch br WHERE b.isbn='ISBN-978-0010' AND br.name='Markaziy filial';

-- Borrows
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-09-10 12:00:00', '2024-09-24 12:00:00', '2024-09-20 12:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-002' AND u.username='aziza';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-09-12 14:00:00', '2024-09-26 14:00:00', '2024-09-25 09:00:00', 5000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-005' AND u.username='jamshid';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-09-15 09:30:00', '2024-09-29 09:30:00', '2024-09-28 10:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-012' AND u.username='shirin';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-09-18 16:00:00', '2024-10-02 16:00:00', '2024-10-01 11:30:00', 3000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-015' AND u.username='botir';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-09-20 10:00:00', '2024-10-04 10:00:00', '2024-10-03 18:00:00', 0.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-010' AND u.username='nargiza';
INSERT INTO circulation_borrow (borrowed_at, due_at, returned_at, fine_amount, copy_id, user_id)
SELECT '2024-09-22 13:00:00', '2024-10-06 13:00:00', '2024-10-05 15:00:00', 7000.00, c.id, u.id
FROM circulation_bookcopy c, auth_user u WHERE c.inventory_code='INV-008' AND u.username='sardor';

-- Reservations
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'pending', '2024-09-21 09:00:00', '2024-09-28 09:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u WHERE b.isbn='ISBN-978-0003' AND br.name='Chilonzor filial' AND u.username='madina';
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'active', '2024-09-22 10:00:00', '2024-09-29 10:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u WHERE b.isbn='ISBN-978-0004' AND br.name='Markaziy filial' AND u.username='dilshod';
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'cancelled', '2024-09-23 11:00:00', '2024-09-30 11:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u WHERE b.isbn='ISBN-978-0005' AND br.name='Samarqand filial' AND u.username='aziza';
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'expired', '2024-09-10 15:00:00', '2024-09-17 15:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u WHERE b.isbn='ISBN-978-0006' AND br.name='Markaziy filial' AND u.username='jamshid';
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'pending', '2024-09-25 12:00:00', '2024-10-02 12:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u WHERE b.isbn='ISBN-978-0007' AND br.name='Chilonzor filial' AND u.username='nargiza';
INSERT INTO circulation_reservation (status, created_at, expires_at, book_id, branch_id, user_id)
SELECT 'active', '2024-09-26 14:00:00', '2024-10-03 14:00:00', b.id, br.id, u.id
FROM catalog_book b, circulation_branch br, auth_user u WHERE b.isbn='ISBN-978-0008' AND br.name='Samarqand filial' AND u.username='sardor';

-- Reviews (unique per user+book)
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Juda yoqdi, tavsiya qilaman.', '2024-09-05 10:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0001' AND u.username='aziza';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Mazmunli va oson o''qiladi.', '2024-09-06 11:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0002' AND u.username='jamshid';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Qissa juda ta''sirli.', '2024-09-07 12:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0003' AND u.username='shirin';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '3', 'Biroz og''ir o''qildi, lekin qiymatli.', '2024-09-08 13:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0004' AND u.username='botir';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Qisqa va mazmunli.', '2024-09-09 14:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0005' AND u.username='nargiza';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Juda kulgili va qiziqarli.', '2024-09-10 15:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0006' AND u.username='sardor';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Roman juda hayotiy.', '2024-09-11 16:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0007' AND u.username='dilshod';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '5', 'Tabiat tasvirlari ajoyib.', '2024-09-12 17:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0008' AND u.username='madina';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '3', 'Og''ir mavzu, lekin foydali.', '2024-09-13 18:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0009' AND u.username='aziza';
INSERT INTO reviews_reviews (rating, text, created_at, book_id, user_id)
SELECT '4', 'Til uslubi yoqdi.', '2024-09-14 19:00:00', b.id, u.id
FROM catalog_book b, auth_user u WHERE b.isbn='ISBN-978-0010' AND u.username='jamshid';

COMMIT;
