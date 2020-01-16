create view friends as
    select a.follower_id as user_id,
           a.following_id as friend_id from
        Followers as a
        inner join Followers as b
            on a.follower_id = b.following_id and
               a.following_id = b.follower_id;

create view user_friends as
    select friend_id as target_id from friends
    where user_id = USER_ID;

select user_id, count(*) as common_friends_count from
    friends
    inner join user_friends
        on friend_id = target_id
where user_id != USER_ID
group by user_id
order by common_friends_count desc
limit 10;