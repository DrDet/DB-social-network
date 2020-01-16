with media_id as (
         insert into Media (type, size, file_path, time)
                values ('image', S, URL, now()) RETURNING id
     )
insert into UserMedia (media_id, user_id)
       values ((select id from media_id), USER_ID);
