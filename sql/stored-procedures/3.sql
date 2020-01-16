CREATE OR REPLACE procedure user_publish_post (user_id integer, post_text varchar(50000))
AS $$
    plan = plpy.prepare(
"""
with post_id as (
    insert into Posts (text, time)
    values ($2, now())
    returning id
) insert into UserPosts (post_id, user_id)
         values ((select id from post_id), $1);
"""
, ["int4", "text"])
    plpy.execute(plan, [user_id, post_text])
$$ LANGUAGE plpython3u;