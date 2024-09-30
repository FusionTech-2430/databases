create database businesses;

\c businesses;

create schema if not exists all_connected_businesses;

create table all_connected_businesses.business
(
    id_business uuid        not null
        primary key,
    name        varchar(45) not null,
    owner_id    varchar(28) not null,
    logo_url    varchar(700)
);

create table all_connected_businesses.business_member
(
    id_user     varchar(28) not null,
    id_business uuid        not null
        references all_connected_businesses.business,
    join_date   timestamp   not null,
    primary key (id_user, id_business)
);

create table all_connected_businesses.business_organization
(
    id_organization uuid not null,
    id_business     uuid not null
        references all_connected_businesses.business,
    primary key (id_organization, id_business)
);

create table all_connected_businesses.suscription
(
    id_suscription  serial
        primary key,
    name            varchar(45)      not null,
    price_month     double precision not null,
    duration_months integer          not null
);

create table all_connected_businesses.business_suscription
(
    id_business_suscription uuid             not null
        primary key,
    id_business             uuid             not null
        references all_connected_businesses.business,
    id_suscription          integer          not null
        references all_connected_businesses.suscription,
    charge                  double precision not null,
    charge_date             timestamp        not null,
    expiration_date         timestamp        not null
);

create table all_connected_businesses.conveyance_request
(
    id_conveyance_request serial
        primary key,
    id_user               varchar(28)           not null,
    id_business           uuid                  not null,
    accepted              boolean default false not null,
    active                boolean default true  not null,
    request_date          timestamp             not null,
    foreign key (id_user, id_business) references all_connected_businesses.business_member
);

create table all_connected_businesses.invitation_token
(
    invitation_token varchar(28) not null
        primary key,
    id_business      uuid        not null
        references all_connected_businesses.business,
    creation_date    timestamp   not null,
    expiration_date  timestamp   not null
);

create table all_connected_businesses.report
(
    id_report   serial
        primary key,
    id_business uuid         not null
        references all_connected_businesses.business,
    id_reporter varchar(28)  not null,
    reason      varchar(45)  not null,
    description varchar(500) not null
);

create table all_connected_businesses.suscription_benefit
(
    id_benefit     serial
        primary key,
    id_suscription integer      not null
        references all_connected_businesses.suscription,
    benefit        varchar(45)  not null,
    description    varchar(100) not null
);


GRANT USAGE ON SCHEMA all_connected_businesses TO developer;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA all_connected_businesses TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_businesses GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO developer;


GRANT ALL PRIVILEGES ON SCHEMA all_connected_businesses TO devops;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA all_connected_businesses TO devops;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA all_connected_businesses TO devops;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA all_connected_businesses TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_businesses GRANT ALL PRIVILEGES ON TABLES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_businesses GRANT ALL PRIVILEGES ON SEQUENCES TO devops;
ALTER DEFAULT PRIVILEGES IN SCHEMA all_connected_businesses GRANT ALL PRIVILEGES ON FUNCTIONS TO devops;