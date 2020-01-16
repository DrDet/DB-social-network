create or replace function get_sorted_groups(user_id_ integer)
returns table(group_id integer, likes_count bigint)
AS $$
begin
    return query
        with user_liked_posts as (
            select post_id, GroupPosts.group_id from
                Likes
                natural join GroupPosts
            where user_id = 1
        ), user_groups_posts as (
            select post_id, GroupPosts.group_id from
                UserGroups
                natural join GroupPosts
            where user_id = 1
        ), user_groups_liked_posts as (
            select * from user_liked_posts
            intersect
            select * from user_groups_posts
        ), weighted_groups as (
            select user_groups_liked_posts.group_id, count(*) as likes_count from
                user_groups_liked_posts
            group by user_groups_liked_posts.group_id
        ), user_groups as (
            select UserGroups.group_id, 0 as likes_count from
                UserGroups
            where user_id = user_id_
        ), all_groups_weighted as (
            select * from weighted_groups
            union
            select * from user_groups
        ) select all_groups_weighted.group_id as group_id, sum(all_groups_weighted.likes_count) as likes_count from
            all_groups_weighted
        group by all_groups_weighted.group_id
        order by likes_count desc;
end;
$$ LANGUAGE plpgsql;