select count(*) from Posts where now() - time < '5 minutes';
select count(*) from Messages where now() - time < '5 minutes';
select sum(size) from Media where now() - time < '5 minutes';