with user_friends as (
    select a.following_id as user_id from
        Followers as a
        inner join Followers as b
           on a.follower_id = b.following_id and
              a.following_id = b.follower_id
    where a.follower_id = USER_ID
), user_chats as (
    select chat_id from UserChats
    where user_id = USER_ID
), chats_user_count as (
    select chat_id, count(*) as users_count from
        user_chats
        natural join UserChats
    group by chat_id
), chat_friends_count as (
    select chat_id, count(*) as friends_count from
        user_chats
        natural join UserChats
        natural join user_friends
    group by chat_id
) select chat_id from
    chats_user_count natural join chat_friends_count
where cast(friends_count as float) / users_count >= 0.8;