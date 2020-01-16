create or replace function get_chats_sorted_time(user_id_ integer)
returns table(chat_id integer)
AS $$
begin
    return query
        select chat_id from (
            select distinct on (Messages.chat_id) Messages.chat_id, time from
                UserChats
                inner join Messages
                    on UserChats.user_id = user_id_ and
                       UserChats.chat_id = Messages.chat_id
            order by Messages.chat_id, time desc) as cit
        order by time;
end;
$$ LANGUAGE plpgsql;