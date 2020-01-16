CREATE OR REPLACE procedure user_send_message (user_id integer, chat_id integer, msg_text varchar(5000))
AS $$
    plan = plpy.prepare(
        "insert into Messages (text, time, user_id, chat_id) values ($3, now(), $1, $2)",
        ["int4", "int4", "text"])
    plpy.execute(plan, [user_id, chat_id, msg_text])
$$ LANGUAGE plpython3u;
