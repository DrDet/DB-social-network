with msg_id as (
        insert into Messages (text, time, user_id, chat_id)
        values (MSG_TEXT, now(), USER_ID, CHAT_ID) RETURNING id
    ),
     media_id as (
         insert into Media (type, size, file_path, time)
         values ('image', SIZE, URL, now()) RETURNING id
    )
insert into MessageMedia (media_id, message_id)
       values ((select id from media_id), (select id from msg_id));
