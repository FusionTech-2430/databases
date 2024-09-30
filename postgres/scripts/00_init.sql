CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';
SELECT pg_create_physical_replication_slot('replication_slot');

CREATE USER developer WITH PASSWORD 'rtnfhdNoT08M';

CREATE USER devops WITH PASSWORD 'joKS9k0mvIch';