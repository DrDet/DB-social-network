create view group_posts as
    select post_id
    from
        UserGroups
        natural join GroupPosts
    where user_id = USER_ID;

create view following_posts as
    select post_id
    from
        Followers
        inner join UserPosts on following_id = user_id
    where follower_id = USER_ID;

create view liked_posts as
    select post_id
    from Likes
    where user_id = USER_ID;

create view target_posts as
    select * from
        group_posts union select * from following_posts
        except all select * from liked_posts;

select post_id from
    target_posts
    inner join Posts on target_posts.post_id = Posts.id
order by time;