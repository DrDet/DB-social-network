create or replace function get_stats()
returns table(posts_count integer, messages_count integer, total_upload_size bigint)
AS $$
begin
    return query
        select * from
        (select count(*)::integer as posts_count from Posts where now() - time < '5 minutes') as s1
        cross join
        (select count(*)::integer as messages_count from Messages where now() - time < '5 minutes') as s2
        cross join
        (select sum(size)::bigint as total_upload_size from Media where now() - time < '5 minutes') as s3;
end;
$$ LANGUAGE plpgsql;
