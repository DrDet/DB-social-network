with post_id as (
    insert into Posts (text, time)
        values (POST_TEXT, now())
        returning id
) insert into GroupPosts (post_id, group_id)
         values ((select id from post_id), GROUP_ID);