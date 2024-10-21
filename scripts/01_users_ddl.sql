create database users;

\c users;

create schema if not exists all_connected_users;

create table all_connected_users.rol
(
    id_rol text not null
        primary key
        constraint rol_id_rol_check
            check (id_rol = ANY
                   (ARRAY ['admin'::text, 'cm'::text, 'event'::text, 'organization'::text, 'customer'::text, 'supplier'::text, 'guest'::text]))
);

INSERT INTO all_connected_users.rol (id_rol) VALUES ('admin');
INSERT INTO all_connected_users.rol (id_rol) VALUES ('cm');
INSERT INTO all_connected_users.rol (id_rol) VALUES ('event');
INSERT INTO all_connected_users.rol (id_rol) VALUES ('organization');
INSERT INTO all_connected_users.rol (id_rol) VALUES ('customer');
INSERT INTO all_connected_users.rol (id_rol) VALUES ('supplier');
INSERT INTO all_connected_users.rol (id_rol) VALUES ('guest');

create table all_connected_users."user"
(
    id_user   varchar(28)          not null
        primary key,
    fullname  varchar(100),
    username  varchar(45)          not null,
    mail      varchar(45),
    photo_url varchar(700),
    active    boolean default true not null
);

create table all_connected_users.user_rol
(
    id_user varchar(28) not null
        references all_connected_users."user",
    id_rol  text        not null
        references all_connected_users.rol
        constraint user_rol_id_rol_check
            check (id_rol = ANY
                   (ARRAY ['admin'::text, 'cm'::text, 'event'::text, 'organization'::text, 'customer'::text, 'supplier'::text, 'guest'::text])),
    primary key (id_user, id_rol)
);

create table all_connected_users.organization
(
    id_organization uuid          not null
        primary key,
    name            varchar(45)   not null,
    address         varchar(45)   not null,
    location_lat    numeric(9, 6) not null,
    location_lng    numeric(9, 6) not null,
    photo_url       varchar(700)
);

create table all_connected_users.user_organization
(
    id_organization uuid        not null
        references all_connected_users.organization,
    id_user         varchar(28) not null
        references all_connected_users."user",
    join_date       timestamp   not null,
    primary key (id_organization, id_user)
);

create table all_connected_users.deleted
(
    id_user     varchar(28)  not null
        primary key
        references all_connected_users."user",
    reason      varchar(200) not null,
    delete_date timestamp    not null
);

GRANT USAGE ON SCHEMA all_connected_users TO developer;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA all_connected_users TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_users GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO developer;


GRANT ALL PRIVILEGES ON SCHEMA all_connected_users TO devops;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA all_connected_users TO devops;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA all_connected_users TO devops;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA all_connected_users TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_users GRANT ALL PRIVILEGES ON TABLES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_users GRANT ALL PRIVILEGES ON SEQUENCES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_users GRANT ALL PRIVILEGES ON FUNCTIONS TO devops;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_users TO developer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_users TO devops;
