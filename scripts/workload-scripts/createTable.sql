drop table if exists tokenized_access_logs;
CREATE EXTERNAL TABLE tokenized_access_logs (
    product string,
    ip string,
    date_logged string,
    url string) stored as parquet location 's3a://cloudbreak-group/user/dhdemo/data/tokenized';


SELECT COUNT(*) FROM tokenized_access_logs;
