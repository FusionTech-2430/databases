create database products;

\c products;

create schema if not exists all_connected_products;

create table all_connected_products.product
(
    id_product  serial
        primary key,
    id_business uuid                        not null,
    name        varchar(45)                 not null,
    description varchar(280)                not null,
    photo_url   varchar(700),
    stock       integer                     not null,
    price       double precision            not null,
    status      text default 'active'::text not null
        constraint product_status_check
            check (status = ANY (ARRAY ['active'::text, 'paused'::text, 'reported'::text]))
);

create table all_connected_products.label
(
    id_label serial
        primary key,
    label    varchar(45) not null
);

create table all_connected_products.product_label
(
    id_announcement integer not null
        references all_connected_products.product,
    id_label        integer not null
        references all_connected_products.label,
    primary key (id_announcement, id_label)
);


create table all_connected_products."order"
(
    id_order      uuid                             not null
        primary key,
    creation_date timestamp                        not null,
    delivery_date timestamp,
    id_user       varchar(28)                      not null,
    total         double precision                 not null,
    status        text default 'in_progress'::text not null
        constraint order_status_check
            check (status = ANY (ARRAY ['in_progress'::text, 'confirmed'::text, 'delivered'::text]))
);


create table all_connected_products.product_order
(
    id_order   uuid             not null
        references all_connected_products."order",
    id_product integer          not null
        references all_connected_products.product,
    quantity   integer          not null,
    subtotal   double precision not null,
    primary key (id_order, id_product)
);

create table all_connected_products.rating
(
    id_rating  serial
        primary key,
    id_product integer     not null
        references all_connected_products.product,
    id_user    varchar(28) not null,
    date       timestamp   not null,
    rating     integer     not null,
    comment    varchar(500)
);


create table all_connected_products.reported_product
(
    id_product  integer      not null
        primary key
        references all_connected_products.product,
    reason      varchar(45)  not null,
    description varchar(500) not null,
    report_date timestamp    not null
);

alter table all_connected_products."order"
    add id_business uuid;

GRANT USAGE ON SCHEMA all_connected_products TO developer;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA all_connected_products TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_products GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO developer;


GRANT ALL PRIVILEGES ON SCHEMA all_connected_products TO devops;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA all_connected_products TO devops;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA all_connected_products TO devops;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA all_connected_products TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_products GRANT ALL PRIVILEGES ON TABLES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_products GRANT ALL PRIVILEGES ON SEQUENCES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_products GRANT ALL PRIVILEGES ON FUNCTIONS TO devops;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_products TO developer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_products TO devops;