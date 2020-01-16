create or replace function get_possible_friends(user_id_ integer, limit_ integer)
returns table(user_id integer, common_friends_count bigint)
AS $$
begin
    return query
        with friends as (
            select a.follower_id as user_id,
                   a.following_id as friend_id from
                Followers as a
                inner join Followers as b
                    on a.follower_id = b.following_id and
                       a.following_id = b.follower_id
        ),
        user_friends as (
            select friend_id as target_id from friends
            where user_id = user_id_
        )
        select user_id, count(*) as common_friends_count from
            friends
            inner join user_friends
                on friend_id = target_id
        where user_id != USER_ID
        group by user_id
        order by common_friends_count desc
        limit limit_;
end;
$$ LANGUAGE plpgsql;

