/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */

CREATE schema lab1;

CREATE TABLE roles (
     id integer,
     name varchar(255),
               constraint pk_role_name primary key (name),
               constraint uq_role_id unique (id),
               constraint ck_role_id check ( id < 10000000000 and id > 0)
);

CREATE TABLE userinfo (
    id integer,
    name varchar(255),
    surname varchar(255),
              constraint pk_userinfo primary key (id)
);

CREATE TABLE "user" (
      id integer,
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

CREATE TABLE "order"
(
      id integer,
      customer integer,
      created timestamp NOT NULL,
                    constraint pk_name primary key (id),
                    constraint ck_order_id check ( id < 10000000000 and id > 0),
                    constraint ck_order_user check ( customer < 10000000000 and customer > 0),
                    constraint fk_order_user_id foreign key (customer)
                                                references "user" (id)
);

CREATE TABLE supplier (
      id integer,
      name varchar(255),
      address varchar(255),
      phone varchar(255) NOT NULL,
      representative varchar(255),
                    constraint pk_supplier_name primary key (name),
                    constraint uq_supplier_id unique (id),
                    constraint ck_supplier_id check ( id < 10000000000 and id > 0)
);

CREATE TABLE product (
      id integer,
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
      "order" integer,
      product integer,
                    constraint pk_order2product primary key ("order", product),
                    constraint ck_order2product_order_id check ( "order" < 10000000000 and "order" > 0),
                    constraint ck_oorder2product_product check ( product < 10000000000 and product > 0),
                    constraint fk_order2product_order_id  foreign key ("order")
                                                          references "order" (id),
                    constraint fk_order2product_product  foreign key (product)
                                                            references product(id)
);


INSERT INTO roles(id, name)
VALUES  (1, 'admin'),
        (2, 'director'),
        (3, 'customer');

INSERT INTO userinfo(id, name, surname)
VALUES  (1, 'Ivan', 'Petrov'),
        (2, 'Irina', 'Ivanova'),
        (3, 'Vladimir', 'Sidorov');

INSERT INTO "user"(id, email, password, info, role)
VALUES (1, 'first@gmail.com', 'first5555', 1, 1),
       (2, 'second@gmail.com', 'second1276', 2, 2),
       (3, 'third@gmail.com', 'third9453', 3, 3);

INSERT INTO "order"(id, customer, created)
VALUES  (1, 1, CURRENT TIMESTAMP),
        (2, 1, CURRENT TIMESTAMP),
        (3, 2, CURRENT TIMESTAMP);

INSERT INTO supplier(id, name, address, phone, representative)
VALUES (1, 'Vzlet', 'SPB, Komsomola 4', '5555512', 'Nosov'),
       (2, 'Omega', 'SPB, Nevskyi', '1234567', 'Nekrasov'),
       (3, 'Smart devices', 'SPB, Leninskyi 42', '1238712', 'Sergeev');

INSERT INTO product(id, code, title, supplier, initial_price, retail_value)
VALUES (1, 'ff12', 'iphone 8', 3, 35000, 45000),
       (2, 'ff14', 'sony vaio', 1, 50000, 71000),
       (3, 'gs21', 'mouse smartbuy', 2, 500, 1000);

INSERT INTO order2product("order", product)
VALUES (1, 1),
       (2, 2),
       (3, 3);



SELECT *
FROM roles;

SELECT *
FROM userinfo;

SELECT *
FROM "user";

SELECT *
FROM "order";

SELECT *
FROM supplier;

SELECT *
FROM product;

SELECT *
FROM order2product;

