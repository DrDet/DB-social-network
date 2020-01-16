create or replace function get_common_friends(user_id_ integer, other_id_ integer)
returns table(user_id integer)
AS $$
begin
    return query
        with user_friends as (
            select a.following_id as friend_id from
                Followers as a
                inner join Followers as b
                    on a.follower_id = b.following_id and
                       a.following_id = b.follower_id
            where a.follower_id = user_id_
        ),
        other_friends as (
            select a.following_id as friend_id from
                Followers as a
                inner join Followers as b
                    on a.follower_id = b.following_id and
                       a.following_id = b.follower_id
            where a.follower_id = other_id_
        )
        select * from user_friends
        intersect
        select * from other_friends;
end;
$$ LANGUAGE plpgsql;