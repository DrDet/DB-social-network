with user_liked_posts as (
    select post_id, group_id from
        Likes
        natural join GroupPosts
    where user_id = 1
), user_groups_posts as (
    select post_id, group_id from
        UserGroups
        natural join GroupPosts
    where user_id = 1
), user_groups_liked_posts as (
    select * from user_liked_posts
    intersect
    select * from user_groups_posts
), weighted_groups as (
    select group_id, count(*) as likes_count from
        user_groups_liked_posts
    group by group_id
), user_groups as (
    select group_id, 0 as likes_count from
        UserGroups
    where user_id = USER_ID
), all_groups_weighted as (
    select * from weighted_groups
    union
    select * from user_groups
) select group_id, sum(likes_count) as likes_count from
    all_groups_weighted
group by group_id
order by likes_count desc;
