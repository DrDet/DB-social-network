CREATE OR REPLACE procedure group_publish_post (group_id integer, post_text varchar(50000))
AS $$
    plan = plpy.prepare(
"""
with post_id as (
    insert into Posts (text, time)
        values ($2, now())
        returning id
) insert into GroupPosts (post_id, group_id)
        values ((select id from post_id), $1);
"""
, ["int4", "text"])
    plpy.execute(plan, [group_id, post_text])
$$ LANGUAGE plpython3u;
