-- Adminer 5.4.2-dev PostgreSQL 16.10 dump

DROP TABLE IF EXISTS "products";
DROP SEQUENCE IF EXISTS products_id_seq;
CREATE SEQUENCE products_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 11 CACHE 1;

CREATE TABLE "public"."products" (
    "id" integer DEFAULT nextval('products_id_seq') NOT NULL,
    "name" character varying(100) NOT NULL,
    "price" double precision NOT NULL,
    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "products" ("id", "name", "price") VALUES
(1,	'Kaos Polos Putih',	75000),
(2,	'Kaos Polos Hitam',	75000),
(3,	'Celana Jeans Biru',	150000),
(4,	'Celana Chino Coklat',	140000),
(5,	'Sepatu Sneakers Putih',	325000),
(6,	'Sepatu Boots Hitam',	450000),
(7,	'Topi Baseball',	50000),
(8,	'Jaket Hoodie Abu-abu',	200000),
(9,	'Sweater Rajut',	180000),
(10,	'Tas Ransel',	220000);

DROP TABLE IF EXISTS "transaction";
DROP SEQUENCE IF EXISTS transaction_id_seq;
CREATE SEQUENCE transaction_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 17 CACHE 1;

CREATE TABLE "public"."transaction" (
    "id" integer DEFAULT nextval('transaction_id_seq') NOT NULL,
    "invoice_id" character varying(100) NOT NULL,
    "external_id" character varying(100) NOT NULL,
    "status" character varying(50) NOT NULL,
    "amount" double precision NOT NULL,
    "payer_email" character varying(255),
    "description" text,
    "metadata" jsonb,
    "created_at" timestamptz NOT NULL,
    "updated_at" timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "transaction_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX transaction_invoice_id_key ON public.transaction USING btree (invoice_id);

INSERT INTO "transaction" ("id", "invoice_id", "external_id", "status", "amount", "payer_email", "description", "metadata", "created_at", "updated_at") VALUES
(1,	'69130a5c4fac09f8b8a8c23c',	'order_rezaaawp@gmail.com_1762855516',	'PENDING',	375000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 03:05:17.415495+00',	'2025-11-11 10:05:17.417862+00'),
(2,	'69130edc4fac09f8b8a8c7a6',	'order_rezaaawp@gmail.com_1762856668',	'PENDING',	525000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 03:24:29.142559+00',	'2025-11-11 10:24:29.144823+00'),
(3,	'69130fb7da89df55a5e5792d',	'order_rezaaawp@gmail.com_1762856887',	'PENDING',	525000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 03:28:08.285026+00',	'2025-11-11 10:28:08.285676+00'),
(4,	'69131077da89df55a5e57a70',	'order_rezaaawp@gmail.com_1762857078',	'PENDING',	250000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 03:31:19.568521+00',	'2025-11-11 10:31:19.571201+00'),
(5,	'6913126fda89df55a5e57c17',	'order_rezaaawp@gmail.com_1762857583',	'PAID',	325000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 03:39:44.671815+00',	'2025-11-11 10:40:02.427712+00'),
(6,	'69131324da89df55a5e57caa',	'order_rezaaawp@gmail.com_1762857764',	'PAID',	400000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "69131324da89df55a5e57caa", "items": [{"name": "Kaos Polos Putih", "price": 75000, "quantity": 1}, {"name": "Sepatu Sneakers Putih", "price": 325000, "quantity": 1}], "amount": 400000, "status": "PAID", "created": "2025-11-11T10:42:44.884Z", "is_high": false, "paid_at": "2025-11-11T10:43:00.000Z", "updated": "2025-11-11T10:43:00.745Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "bank_code": "BCA", "payment_id": "4ee99119-8a41-4e9c-9399-fcbe63459f65", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762857764", "paid_amount": 400000, "payer_email": "rezaaawp@gmail.com", "merchant_name": "RWP", "payment_method": "BANK_TRANSFER", "payment_channel": "BCA", "payment_destination": "3816537949174"}',	'2025-11-11 03:42:45.10229+00',	'2025-11-11 10:43:02.44941+00'),
(7,	'69131be4da89df55a5e584af',	'order_rezaaawp@gmail.com_1762860004',	'REFUNDED',	215000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "69131be4da89df55a5e584af", "items": [{"name": "Kaos Polos Putih", "price": 75000, "quantity": 1}, {"name": "Celana Chino Coklat", "price": 140000, "quantity": 1}], "amount": 215000, "status": "PAID", "created": "2025-11-11T11:20:04.754Z", "is_high": false, "paid_at": "2025-11-11T11:20:55.360Z", "updated": "2025-11-11T11:20:58.771Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "payment_id": "ewc_831f7248-4b35-426a-b966-4ab2979d7146", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762860004", "paid_amount": 215000, "payer_email": "rezaaawp@gmail.com", "ewallet_type": "DANA", "merchant_name": "RWP", "payment_method": "EWALLET", "payment_channel": "DANA", "payment_method_id": "pm-598947c3-1968-40e5-89f8-ecefc84cbed1"}',	'2025-11-11 04:20:04.929405+00',	'2025-11-11 11:20:59.609514+00'),
(8,	'6913245d4fac09f8b8a8d974',	'order_rezaaawp@gmail.com_1762862173',	'PAID',	300000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "6913245d4fac09f8b8a8d974", "items": [{"name": "Kaos Polos Hitam", "price": 75000, "quantity": 1}, {"name": "Celana Jeans Biru", "price": 150000, "quantity": 1}, {"name": "Kaos Polos Putih", "price": 75000, "quantity": 1}], "amount": 300000, "status": "PAID", "created": "2025-11-11T11:56:14.266Z", "is_high": false, "paid_at": "2025-11-11T11:56:23.274Z", "updated": "2025-11-11T11:56:25.776Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "payment_id": "ewc_8d207449-582b-4647-bf10-f685942def42", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762862173", "paid_amount": 300000, "payer_email": "rezaaawp@gmail.com", "ewallet_type": "DANA", "merchant_name": "RWP", "payment_method": "EWALLET", "payment_channel": "DANA", "payment_method_id": "pm-ce7d02ad-8076-4f1f-9d08-f3fd4d8f8cab"}',	'2025-11-11 04:56:14.494732+00',	'2025-11-11 11:56:27.095313+00'),
(9,	'6913247f4fac09f8b8a8d986',	'order_rezaaawp@gmail.com_1762862207',	'PAID',	465000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "6913247f4fac09f8b8a8d986", "items": [{"name": "Celana Chino Coklat", "price": 140000, "quantity": 1}, {"name": "Sepatu Sneakers Putih", "price": 325000, "quantity": 1}], "amount": 465000, "status": "PAID", "created": "2025-11-11T11:56:47.815Z", "is_high": false, "paid_at": "2025-11-11T11:57:15.742Z", "updated": "2025-11-11T11:57:17.723Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "payment_id": "ewc_ed9c3b60-5f04-49e2-bb93-fe7ec769bcac", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762862207", "paid_amount": 465000, "payer_email": "rezaaawp@gmail.com", "ewallet_type": "DANA", "merchant_name": "RWP", "payment_method": "EWALLET", "payment_channel": "DANA", "payment_method_id": "pm-00165765-5858-4127-a6f7-788dbd0e34c7"}',	'2025-11-11 04:56:47.973299+00',	'2025-11-11 11:57:18.863535+00'),
(10,	'691324b04fac09f8b8a8d9b9',	'order_rezaaawp@gmail.com_1762862256',	'PENDING',	420000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 04:57:36.88591+00',	'2025-11-11 11:57:36.88617+00'),
(11,	'6913284bda89df55a5e58eae',	'order_rezaaawp@gmail.com_1762863179',	'PAID',	75000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "6913284bda89df55a5e58eae", "items": [{"name": "Kaos Polos Putih", "price": 75000, "quantity": 1}], "amount": 75000, "status": "PAID", "created": "2025-11-11T12:13:00.297Z", "is_high": false, "paid_at": "2025-11-11T12:13:20.020Z", "updated": "2025-11-11T12:13:22.202Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "payment_id": "ewc_4ff005f8-99b1-4fb5-9e0b-052ab1530e08", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762863179", "paid_amount": 75000, "payer_email": "rezaaawp@gmail.com", "ewallet_type": "DANA", "merchant_name": "RWP", "payment_method": "EWALLET", "payment_channel": "DANA", "payment_method_id": "pm-03367ca7-43f6-4fc6-a1d7-b4b40801a0a1"}',	'2025-11-11 05:13:00.488006+00',	'2025-11-11 12:13:23.734984+00'),
(12,	'69132879da89df55a5e58ed4',	'order_rezaaawp@gmail.com_1762863225',	'PENDING',	400000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 05:13:45.6956+00',	'2025-11-11 12:13:45.695749+00'),
(13,	'691328a8da89df55a5e58ef1',	'order_rezaaawp@gmail.com_1762863272',	'PENDING',	465000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 05:14:33.197881+00',	'2025-11-11 12:14:33.198118+00'),
(14,	'69132a034fac09f8b8a8de47',	'order_gamersreza.78@gmail.com_1762863619',	'PENDING',	75000,	'gamersreza.78@gmail.com',	'Pembayaran oleh Reza',	'{}',	'2025-11-11 05:20:20.55128+00',	'2025-11-11 12:20:20.551878+00'),
(15,	'69132a58da89df55a5e59024',	'order_rezaaawp@gmail.com_1762863704',	'PAID',	150000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "69132a58da89df55a5e59024", "items": [{"name": "Kaos Polos Putih", "price": 75000, "quantity": 1}, {"name": "Kaos Polos Hitam", "price": 75000, "quantity": 1}], "amount": 150000, "status": "PAID", "created": "2025-11-11T12:21:45.175Z", "is_high": false, "paid_at": "2025-11-11T12:21:52.967Z", "updated": "2025-11-11T12:21:55.597Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "payment_id": "ewc_689f18e6-adb8-4686-9847-081b3d02dc1b", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762863704", "paid_amount": 150000, "payer_email": "rezaaawp@gmail.com", "ewallet_type": "DANA", "merchant_name": "RWP", "payment_method": "EWALLET", "payment_channel": "DANA", "payment_method_id": "pm-0ee391c1-1fa3-413e-b5d3-3cee73518495"}',	'2025-11-11 05:21:45.373831+00',	'2025-11-11 12:21:56.40839+00'),
(16,	'69132c79da89df55a5e591ae',	'order_rezaaawp@gmail.com_1762864249',	'PAID',	225000,	'rezaaawp@gmail.com',	'Pembayaran oleh Reza',	'{"id": "69132c79da89df55a5e591ae", "items": [{"name": "Kaos Polos Putih", "price": 75000, "quantity": 1}, {"name": "Celana Jeans Biru", "price": 150000, "quantity": 1}], "amount": 225000, "status": "PAID", "created": "2025-11-11T12:30:49.926Z", "is_high": false, "paid_at": "2025-11-11T12:31:00.968Z", "updated": "2025-11-11T12:31:03.236Z", "user_id": "64ffb9fd57021c99cf7f3b78", "currency": "IDR", "payment_id": "ewc_3810d795-e00c-437b-98ca-c09e70cd11ff", "description": "Pembayaran oleh Reza", "external_id": "order_rezaaawp@gmail.com_1762864249", "paid_amount": 225000, "payer_email": "rezaaawp@gmail.com", "ewallet_type": "DANA", "merchant_name": "RWP", "payment_method": "EWALLET", "payment_channel": "DANA", "payment_method_id": "pm-e45c2ff9-d359-48ba-8985-2bb5540cb358"}',	'2025-11-11 05:30:50.035835+00',	'2025-11-11 12:31:04.175211+00');

DROP TABLE IF EXISTS "transactiondetail";
DROP SEQUENCE IF EXISTS transactiondetail_id_seq;
CREATE SEQUENCE transactiondetail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 33 CACHE 1;

CREATE TABLE "public"."transactiondetail" (
    "id" integer DEFAULT nextval('transactiondetail_id_seq') NOT NULL,
    "product_name" character varying(100) NOT NULL,
    "qty" integer NOT NULL,
    "price" numeric(12,2) NOT NULL,
    "subtotal" numeric(12,2) NOT NULL,
    "transaction_id" integer NOT NULL,
    CONSTRAINT "transactiondetail_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "transactiondetail" ("id", "product_name", "qty", "price", "subtotal", "transaction_id") VALUES
(1,	'Topi Baseball',	1,	50000.00,	50000.00,	1),
(2,	'Sepatu Sneakers Putih',	1,	325000.00,	325000.00,	1),
(3,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	2),
(4,	'Sepatu Boots Hitam',	1,	450000.00,	450000.00,	2),
(5,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	3),
(6,	'Sepatu Boots Hitam',	1,	450000.00,	450000.00,	3),
(7,	'Topi Baseball',	1,	50000.00,	50000.00,	4),
(8,	'Jaket Hoodie Abu-abu',	1,	200000.00,	200000.00,	4),
(9,	'Topi Baseball',	1,	50000.00,	50000.00,	5),
(10,	'Jaket Hoodie Abu-abu',	1,	200000.00,	200000.00,	5),
(11,	'Kaos Polos Hitam',	1,	75000.00,	75000.00,	5),
(12,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	6),
(13,	'Sepatu Sneakers Putih',	1,	325000.00,	325000.00,	6),
(14,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	7),
(15,	'Celana Chino Coklat',	1,	140000.00,	140000.00,	7),
(16,	'Kaos Polos Hitam',	1,	75000.00,	75000.00,	8),
(17,	'Celana Jeans Biru',	1,	150000.00,	150000.00,	8),
(18,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	8),
(19,	'Celana Chino Coklat',	1,	140000.00,	140000.00,	9),
(20,	'Sepatu Sneakers Putih',	1,	325000.00,	325000.00,	9),
(21,	'Tas Ransel',	1,	220000.00,	220000.00,	10),
(22,	'Jaket Hoodie Abu-abu',	1,	200000.00,	200000.00,	10),
(23,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	11),
(24,	'Sepatu Sneakers Putih',	1,	325000.00,	325000.00,	12),
(25,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	12),
(26,	'Celana Chino Coklat',	1,	140000.00,	140000.00,	13),
(27,	'Sepatu Sneakers Putih',	1,	325000.00,	325000.00,	13),
(28,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	14),
(29,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	15),
(30,	'Kaos Polos Hitam',	1,	75000.00,	75000.00,	15),
(31,	'Kaos Polos Putih',	1,	75000.00,	75000.00,	16),
(32,	'Celana Jeans Biru',	1,	150000.00,	150000.00,	16);

ALTER TABLE ONLY "public"."transactiondetail" ADD CONSTRAINT "transactiondetail_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES transaction(id) ON DELETE CASCADE NOT DEFERRABLE;

-- 2025-11-11 13:15:51 UTC
