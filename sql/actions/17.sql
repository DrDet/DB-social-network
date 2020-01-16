select * from
(select count(*) as posts_count from Posts where now() - time < '5 minutes') as s1
cross join
(select count(*) as messages_count from Messages where now() - time < '5 minutes') as s2
cross join
(select sum(size) as total_upload_size from Media where now() - time < '5 minutes') as s3;