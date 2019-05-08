/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */

CREATE schema lab1;

create table roles (
      id integer,
      name varchar(255),
                   constraint pk_role_name primary key (name),
                   constraint uq_role_id unique (id),
                   constraint ck_role_id check ( id < 10000000000 and id > 0)
);

create table userinfo (
                        id integer,
                        name varchar(255) not null,
                        surname varchar(255) not null,
                        constraint pk_userinfo primary key (id)
);

create table users (
      id integer,
      email varchar(255),
      password varchar(255),
      info integer,
      role integer,
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

create table orders
(
      id integer,
      customer integer,
      created timestamp,
                    constraint pk_name primary key (id),
                    constraint ck_order_id check ( id < 10000000000 and id > 0),
                    constraint ck_order_user check ( customer < 10000000000 and customer > 0),
                    constraint fk_order_user_id foreign key (customer)
                                                references users(id)
);

create table supplier (
      id integer,
      name varchar(255),
      address varchar(255) not null,
      phone varchar(255),
      representative varchar(255) not null,
                    constraint pk_supplier_name primary key (name),
                    constraint uq_supplier_id unique (id),
                    constraint ck_supplier_id check ( id < 10000000000 and id > 0)
);

create table product (
      id integer,
      code varchar(255),
      title varchar(255),
      supplier integer,
      initial_price double,
      retail_value double,
                   constraint pk_product primary key (code),
                   constraint uq_product_id unique (id),
                   constraint ck_product_id check ( product < 10000000000 and product > 0),
                   constraint ck_product_supplier check ( supplier < 10000000000 and supplier > 0),
                   constraint fk_product_supplier foreign key (supplier)
                                                  references supplier(id),
                   constraint ck_product_initial_price check ( initial_price < 10000000000 and initial_price > 0),
                   constraint ck_product_retail_value check ( retail_value < 10000000000 and retail_value > 0)
);

create table order2product (
      order integer,
      product integer,
                    constraint pk_order2product primary key (order, product),
                    constraint ck_order2product_order check ( order2product.order < 10000000000 and order2product.order > 0),
                    constraint ck_oorder2product_product check ( product < 10000000000 and product > 0),
                    constraint fk_order2product_order_id  foreign key (order)
                                                          references orders (id),
                    constraint fk_order2product_product_id  foreign key (order)
                                                            references product(id)
);




