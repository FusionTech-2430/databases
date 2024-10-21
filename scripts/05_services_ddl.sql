create database services;

\c services;

create schema if not exists all_connected_services;

create table all_connected_services.service
(
    id_service  serial
        primary key,
    id_business uuid                        not null,
    name        varchar(45)                 not null,
    description varchar(280)                not null,
    photo_url   varchar(700),
    state       text default 'active'::text not null
        constraint service_state_check
            check (state = ANY (ARRAY ['active'::text, 'paused'::text, 'reported'::text]))
);


create table all_connected_services.contract
(
    id_contract uuid             not null
        primary key,
    id_service  integer          not null
        references all_connected_services.service,
    id_user     varchar(28)      not null,
    due_date    timestamp        not null,
    price       double precision not null,
    state       boolean          not null,
    description varchar(200)     not null
);

create table all_connected_services.label
(
    id_label serial
        primary key,
    label    varchar(45) not null
);


create table all_connected_services.service_label
(
    id_label   integer not null
        references all_connected_services.label,
    id_service integer not null
        references all_connected_services.service,
    primary key (id_label, id_service)
);

create table all_connected_services.rating
(
    id_rating          serial
        primary key,
    id_user            varchar(28) not null,
    date               timestamp   not null,
    rating             integer     not null,
    comment            varchar(500),
    service_id_service integer     not null
        references all_connected_services.service
);

create table all_connected_services.reported_service
(
    id_service  integer      not null
        primary key
        references all_connected_services.service,
    reason      varchar(45)  not null,
    description varchar(200) not null,
    report_date timestamp    not null
);


GRANT USAGE ON SCHEMA all_connected_services TO developer;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA all_connected_services TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_services GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO developer;


GRANT ALL PRIVILEGES ON SCHEMA all_connected_services TO devops;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA all_connected_services TO devops;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA all_connected_services TO devops;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA all_connected_services TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_services GRANT ALL PRIVILEGES ON TABLES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_services GRANT ALL PRIVILEGES ON SEQUENCES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_services GRANT ALL PRIVILEGES ON FUNCTIONS TO devops;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_services TO developer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_services TO devops;