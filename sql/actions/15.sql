select chat_id from (
    select distinct on (Messages.chat_id) Messages.chat_id, time from
        UserChats
        inner join Messages
            on UserChats.user_id = USER_ID and
               UserChats.chat_id = Messages.chat_id
    order by Messages.chat_id, time desc) as cit
order by time;
