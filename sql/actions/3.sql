with post_id as (
    insert into Posts (text, time)
    values (POST_TEXT, now())
    returning id
) insert into UserPosts (post_id, user_id)
         values ((select id from post_id), USER_ID);