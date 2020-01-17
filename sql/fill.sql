create or replace procedure fill()
AS $$
declare
    det_id integer := 0;
    pg_id integer := 0;
    eug_id integer := 0;
    chat_id integer := 0;
    post_ids_0 integer := 0; post_ids_1 integer := 0; post_ids_2 integer := 0; post_ids_3 integer := 0; post_ids_4 integer := 0; post_ids_5 integer := 0; post_ids_6 integer := 0; post_ids_7 integer := 0; post_ids_8 integer := 0; post_ids_9 integer := 0; post_ids_10 integer := 0; post_ids_11 integer := 0;
    media_ids_0 integer := 0; media_ids_1 integer := 0; media_ids_2 integer := 0; media_ids_3 integer := 0; media_ids_4 integer := 0; media_ids_5 integer := 0;
    group_ids_0 integer := 0; group_ids_1 integer := 0; group_ids_2 integer := 0;
begin
    insert into Users (name, surname, login, password_hash)
    values ('Denis', 'Vaksman', 'Det', '12345'),
           ('Pavel', 'Golovin', 'pg', '12345'),
           ('Evgeniy', 'Feder', 'dzaba', '12345'),
           ('Gleb', 'Drozdov', 'drozdik', '12345');
    det_id := (select id from Users where login = 'Det');
    pg_id := (select id from Users where login = 'pg');
    eug_id := (select id from Users where login = 'dzaba');
    insert into Chats (name, user_id) values ('Chat', det_id) returning id into chat_id;
    insert into Groups (name, user_id) values ('МХК', det_id) returning id into group_ids_0;
    insert into Groups (name, user_id) values ('Игромания', det_id) returning id into group_ids_1;
    insert into Groups (name, user_id) values ('Русское радио', det_id) returning id into group_ids_2;
    insert into UserChats (user_id, chat_id) values
        (det_id, chat_id),
        (pg_id, chat_id);
    insert into UserGroups (user_id, group_id) values
       (det_id, group_ids_0),
       (det_id, group_ids_1),
       (det_id, group_ids_2);
    insert into Messages (text, time, user_id, chat_id) values
        ('Привет', now(), det_id, chat_id),
        ('Привет Всем', now(), pg_id, chat_id);
    insert into Posts (text, time)
    values ('Пост det_id', now()),
           ('Пост pavel', now()),
           ('Пост eugeniy', now()),
           ('МХК: пост1', now()),
           ('МХК: пост2', now()),
           ('МХК: пост3', now()),
           ('Игромания: пост1', now()),
           ('Игромания: пост2', now()),
           ('Игромания: пост3', now()),
           ('Русское радио: пост1', now()),
           ('Русское радио: пост2', now()),
           ('Русское радио: пост3', now());
    insert into Posts (text, time) values ('Пост det_id', now()) returning id into post_ids_0;
    insert into Posts (text, time) values ('Пост pavel', now()) returning id into post_ids_1;
    insert into Posts (text, time) values ('Пост eugeniy', now()) returning id into post_ids_2;
    insert into Posts (text, time) values ('МХК: пост1', now()) returning id into post_ids_3;
    insert into Posts (text, time) values ('МХК: пост2', now()) returning id into post_ids_4;
    insert into Posts (text, time) values ('МХК: пост3', now()) returning id into post_ids_5;
    insert into Posts (text, time) values ('Игромания: пост1', now()) returning id into post_ids_6;
    insert into Posts (text, time) values ('Игромания: пост2', now()) returning id into post_ids_7;
    insert into Posts (text, time) values ('Игромания: пост3', now()) returning id into post_ids_8;
    insert into Posts (text, time) values ('Русское радио: пост1', now()) returning id into post_ids_9;
    insert into Posts (text, time) values ('Русское радио: пост2', now()) returning id into post_ids_10;
    insert into Posts (text, time) values ('Русское радио: пост3', now()) returning id into post_ids_11;
    insert into UserPosts (post_id, user_id)
        values (post_ids_0, det_id),
               (post_ids_1, pg_id),
               (post_ids_2, eug_id);
    insert into GroupPosts (post_id, group_id)
        values (post_ids_3, group_ids_0),
               (post_ids_4, group_ids_0),
               (post_ids_5, group_ids_0),
               (post_ids_6, group_ids_1),
               (post_ids_7, group_ids_1),
               (post_ids_8, group_ids_1),
               (post_ids_9, group_ids_2),
               (post_ids_10, group_ids_2),
               (post_ids_11, group_ids_2);
    insert into Media (type, size, file_path, time) values ('image', 512, 'storage.ru/1.png', now()) returning id into media_ids_0;
    insert into Media (type, size, file_path, time) values ('video', 512, 'storage.ru/1.mp4', now()) returning id into media_ids_1;
    insert into Media (type, size, file_path, time) values ('image', 512, 'storage.ru/2.png', now()) returning id into media_ids_2;
    insert into Media (type, size, file_path, time) values ('video', 512, 'storage.ru/2.mp4', now()) returning id into media_ids_3;
    insert into Media (type, size, file_path, time) values ('image', 512, 'storage.ru/3.png', now()) returning id into media_ids_4;
    insert into Media (type, size, file_path, time) values ('video', 512, 'storage.ru/3.mp4', now()) returning id into media_ids_5;
    insert into PostMedia (media_id, post_id)
        values (media_ids_0, post_ids_3),
               (media_ids_1, post_ids_4),
               (media_ids_2, post_ids_6),
               (media_ids_3, post_ids_7),
               (media_ids_4, post_ids_9),
               (media_ids_5, post_ids_10);
end;
$$ LANGUAGE plpgsql;

call fill();
