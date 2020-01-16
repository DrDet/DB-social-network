create view user_liked_posts as
    select post_id, group_id from
        Likes
        natural join GroupPosts
    where user_id = USER_ID;

create view user_groups_posts as
    select post_id, group_id from
        UserGroups
        natural join GroupPosts
    where user_id = USER_ID;

create view user_groups_liked_posts as
    select * from user_liked_posts
    intersect
    select * from user_groups_posts;

select group_id, count(*) as likes_count from
    user_groups_liked_posts
group by group_id
order by likes_count desc;