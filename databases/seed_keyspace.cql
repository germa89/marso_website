-- seed_keyspace.cql
USE marso;

INSERT INTO users (id, username, email, password) VALUES (uuid(), 'user1', 'user1@example.com', 'password123');
INSERT INTO users (id, username, email, password) VALUES (uuid(), 'user2', 'user2@example.com', 'password123');

INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Cerveza Cruzcampo', 'Pack de 24 cervezas.', 18.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Cerveza Mahou', 'Pack de 24 cervezas.', 19.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Vino Tinto Rioja', 'Botella de vino tinto reserva.', 12.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Vino Blanco Verdejo', 'Botella de vino blanco.', 8.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Coca-Cola', 'Pack de 24 latas.', 14.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Fanta Naranja', 'Pack de 24 latas.', 14.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Agua Mineral', 'Pack de 6 botellas 1.5L.', 4.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Tinto de Verano', 'Botella 1.5L.', 3.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Sangría', 'Botella 1.5L.', 4.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Zumo de Naranja', 'Pack de 12 bricks.', 9.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Café Molido', 'Paquete de 500g.', 6.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Aceite de Oliva', 'Botella de 1L.', 8.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Jamón Serrano', 'Sobre de 200g.', 5.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Queso Manchego', 'Cuña de 300g.', 7.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Aceitunas', 'Bote de 500g.', 3.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Patatas Fritas', 'Bolsa de 1kg.', 4.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Cerveza Estrella Galicia', 'Pack de 24 cervezas.', 20.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Sidra', 'Botella de 750ml.', 5.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Ron Barceló', 'Botella de 700ml.', 15.99);
INSERT INTO products (id, name, description, price) VALUES (uuid(), 'Whisky JB', 'Botella de 700ml.', 14.99);
