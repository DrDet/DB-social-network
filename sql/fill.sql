create or replace procedure fill()
AS $$
declare
    det_id integer := 0;
    pg_id integer := 0;
    chat_id integer := 0;
    group_id1 integer := 0;
    group_id2 integer := 0;
    group_id3 integer := 0;
begin
    insert into Users (name, surname, login, password_hash)
    values ('Denis', 'Vaksman', 'Det', '12345'),
           ('Pavel', 'Golovin', 'pg', '12345'),
           ('Evgeniy', 'Feder', 'dzaba', '12345'),
           ('Gleb', 'Drozdov', 'drozdik', '12345');
    det_id := (select id from Users where login = 'Det');
    pg_id := (select id from Users where login = 'pg');
    insert into Chats (name, user_id) values ('Chat', det_id) returning id into chat_id;
    insert into Groups (name, user_id) values ('Игромания', det_id) returning id into group_id1;
    insert into Groups (name, user_id) values ('МХК', det_id) returning id into group_id2;
    insert into Groups (name, user_id) values ('Русское радио', det_id) returning id into group_id3;
    insert into UserChats (user_id, chat_id) values
        (det_id, chat_id),
        (pg_id, chat_id);
    insert into UserGroups (user_id, group_id) values
       (det_id, group_id1),
       (det_id, group_id2),
       (det_id, group_id3);
    insert into Messages (text, time, user_id, chat_id) values
        ('Привет', now(), det_id, chat_id),
        ('Привет Всем', now(), pg_id, chat_id);
end;
$$ LANGUAGE plpgsql;

call fill();
