create view user_friends as
    select a.following_id as user_id from
        Followers as a
        inner join Followers as b
            on a.follower_id = b.following_id and
               a.following_id = b.follower_id
    where a.follower_id = USER_ID;

create view common_chats as
    select distinct chat_id from
        user_friends
        natural join UserChats
    intersect
    select chat_id from UserChats
    where user_id = USER_ID;

select user_id, count(*) as messages_count from
    common_chats
    natural join Messages
    natural join user_friends
group by user_id
order by messages_count desc;