CHANGE MASTER TO
  MASTER_HOST='mysql-master',
  MASTER_PORT=3307,
  MASTER_USER='replication_user',
  MASTER_PASSWORD='replication_password',
  MASTER_LOG_FILE='mysql-bin.000003',
  MASTER_LOG_POS=850;

START SLAVE;

SHOW SLAVE STATUS\G;