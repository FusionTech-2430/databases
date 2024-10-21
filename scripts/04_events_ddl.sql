create database "events";

\c "events";

create schema if not exists all_connected_events;

create table if not exists all_connected_events.event
(
    id_event    serial
        primary key,
    id_business uuid                 not null,
    name        varchar(45)          not null,
    description varchar(280)         not null,
    photo_url   varchar(700),
    capacity    integer              not null,
    date        timestamp            not null,
    active      boolean default true not null,
    price       double precision
);

create table if not exists all_connected_events.label
(
    id_label serial
        primary key,
    label    varchar(45) not null
);

create table if not exists all_connected_events.event_label
(
    id_event integer not null
        references all_connected_events.event,
    id_label integer not null
        references all_connected_events.label,
    primary key (id_event, id_label)
);

create table if not exists all_connected_events.event_participant
(
    id_event integer     not null
        references all_connected_events.event,
    id_user  varchar(28) not null,
    primary key (id_event, id_user)
);

GRANT USAGE ON SCHEMA all_connected_events TO developer;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA all_connected_events TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_events GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO developer;


GRANT ALL PRIVILEGES ON SCHEMA all_connected_events TO devops;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA all_connected_events TO devops;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA all_connected_events TO devops;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA all_connected_events TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_events GRANT ALL PRIVILEGES ON TABLES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_events GRANT ALL PRIVILEGES ON SEQUENCES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_events GRANT ALL PRIVILEGES ON FUNCTIONS TO devops;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_events TO developer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA all_connected_events TO devops;