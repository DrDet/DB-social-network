create or replace function get_user_feed(user_id_ integer)
returns table(post_id integer)
AS $$
begin
    return query
        with group_posts as (
            select GroupPosts.post_id
            from UserGroups
                     natural join GroupPosts
            where user_id = user_id_
        ),
         following_posts as (
             select UserPosts.post_id
             from Followers
                      inner join UserPosts on following_id = user_id
             where follower_id = user_id_
         ),
         liked_posts as (
             select Likes.post_id
             from Likes
             where user_id = user_id_
         ),
         target_posts as (
             select * from
                 group_posts union select * from following_posts
                 except all select * from liked_posts
         )
        select target_posts.post_id from
            target_posts
                inner join Posts on target_posts.post_id = Posts.id
        order by time;
end;
$$ LANGUAGE plpgsql;
