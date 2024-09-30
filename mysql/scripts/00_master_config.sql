ALTER USER 'replication_user'@'%' IDENTIFIED WITH 'mysql_native_password' BY 'rep_pass';
GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;
# mysql-bin.000003
# 850