/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */

CREATE schema lab1;

CREATE TABLE roles (
     id integer GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1),
     name varchar(255),
               constraint pk_role_name primary key (name),
               constraint uq_role_id unique (id)
);

CREATE TABLE userinfo (
    id integer GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1),
    name varchar(255), /*not null,*/
    surname varchar(255), /*not null,*/
              constraint pk_userinfo primary key (id)
);

CREATE TABLE users (   /*user - зарезервированное слово */
      id integer GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1),
      email varchar(255),
      password varchar(255) NOT NULL,
      info integer NOT NULL,
      role integer NOT NULL,
                    constraint pk_email primary key (email),
                    constraint uq_user_id unique (id),
                    constraint ck_user_id check ( id < 10000000000 and id > 0),
                    constraint uq_user_info unique (info),
                    constraint ck_user_info check ( info < 10000000000 and info > 0),
                    constraint fk_user_userinfo_id  foreign key (info)
                                                    references userinfo(id),
                    constraint ck_user_role check ( role < 10000000000 and role > 0),
                    constraint fk_user_role_id  foreign key (role)
                                                references roles(id)
);

CREATE TABLE orders   /*order - зарезервированное слово */
(
      id integer GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1),
      customer integer,   /*user - зарезервированное слово */
      created timestamp CONSTRAINT 'DD-MON-YYYY HH24:MI:SS' NOT NULL,
                    constraint pk_name primary key (id),
                    constraint ck_order_id check ( id < 10000000000 and id > 0),
                    constraint ck_order_user check ( customer < 10000000000 and customer > 0),
                    constraint fk_order_user_id foreign key (customer)
                                                references users(id)
);

CREATE TABLE supplier (
      id integer GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1),
      name varchar(255),
      address varchar(255), /*not null,*/
      phone varchar(255) NOT NULL,
      representative varchar(255), /*not null,*/
                    constraint pk_supplier_name primary key (name),
                    constraint uq_supplier_id unique (id),
                    constraint ck_supplier_id check ( id < 10000000000 and id > 0)
);

CREATE TABLE product (
      id integer GENERATED ALWAYS AS IDENTITY ( START WITH 1, INCREMENT BY 1),
      code varchar(255),
      title varchar(255) NOT NULL,
      supplier integer,
      initial_price double NOT NULL,
      retail_value double NOT NULL,
                   constraint pk_product primary key (code),
                   constraint uq_product_id unique (id),
                   constraint ck_product_id check ( id < 10000000000 and id > 0),
                   constraint ck_product_supplier check ( supplier < 10000000000 and supplier > 0),
                   constraint fk_product_supplier foreign key (supplier)
                                                  references supplier(id),
                   constraint ck_product_initial_price check ( initial_price < 10000000000 and initial_price > 0),
                   constraint ck_product_retail_value check ( retail_value < 10000000000 and retail_value > 0)
);

CREATE TABLE order2product (
      order_id integer,   /*order - зарезервированное слово */
      product integer,
                    constraint pk_order2product primary key (order_id, product),
                    constraint ck_order2product_order_id check ( order_id < 10000000000 and order_id > 0),
                    constraint ck_oorder2product_product check ( product < 10000000000 and product > 0),
                    constraint fk_order2product_order_id  foreign key (order_id)
                                                          references orders (id),
                    constraint fk_order2product_product  foreign key (product)
                                                            references product(id)
);


INSERT INTO roles(name)
VALUES  ('admin'),
        ('director'),
        ('customer');

INSERT INTO userinfo(name, surname)
VALUES  ('Ivan', 'Petrov'),
        ('Irina', 'Ivanova'),
        ('Vladimir', 'Sidorov');

INSERT INTO users(email, password, info, role)
VALUES ('first@gmail.com', 'first5555', 1, 1),
       ('second@gmail.com', 'second1276', 2, 2),
       ('third@gmail.com', 'third9453', 3, 3);

INSERT INTO orders(customer, created)
VALUES  (1, CURRENT TIMESTAMP),
        (1, CURRENT TIMESTAMP),
        (2, CURRENT TIMESTAMP);

INSERT INTO supplier(name, address, phone, representative)
VALUES ('Vzlet', 'SPB, Komsomola 4', '5555512', 'Nosov'),
       ('Omega', 'SPB, Nevskyi', '1234567', 'Nekrasov'),
       ('Smart devices', 'SPB, Leninskyi 42', '1238712', 'Sergeev');

INSERT INTO product(code, title, supplier, initial_price, retail_value)
VALUES ('ff12', 'iphone 8', 3, 35000, 45000),
       ('ff14', 'sony vaio', 1, 50000, 71000),
       ('gs21', 'mouse smartbuy', 4, 500, 1000);

INSERT INTO order2product(order_id, product)
VALUES (2, 1),
       (3, 4),
       (4, 6);



SELECT *
FROM roles;

SELECT *
FROM userinfo;

SELECT *
FROM users;

SELECT *
FROM orders;

SELECT *
FROM supplier;

SELECT *
FROM product;

SELECT *
FROM order2product;

