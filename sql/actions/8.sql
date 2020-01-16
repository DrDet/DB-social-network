with media_id as (
    insert into Media (type, size, file_path, time)
        values ('video', S, URL, now()) RETURNING id
)
insert into GroupMedia (media_id, group_id)
       values ((select id from media_id), GROUP_ID);
