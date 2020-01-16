create or replace function get_recommendation_posts(user_id_ integer, posts_count_ integer)
returns table(post_id integer, likes_count bigint)
AS $$
begin
    return query
        select post_id, count(*) as likes_count from
            Followers
            inner join Likes on following_id = user_id and
                                follower_id = user_id_
        group by post_id
        order by likes_count desc
        limit posts_count_;
end;
$$ LANGUAGE plpgsql;
