with user_friends as (
    select a.following_id as friend_id from
        Followers as a
        inner join Followers as b
            on a.follower_id = b.following_id and
               a.following_id = b.follower_id
    where a.follower_id = USER_ID
),
other_friends as (
    select a.following_id as friend_id from
        Followers as a
        inner join Followers as b
            on a.follower_id = b.following_id and
               a.following_id = b.follower_id
    where a.follower_id = OTHER_ID
)
select * from user_friends
intersect
select * from other_friends;