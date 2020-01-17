insert into Users (name, surname, login, password_hash)
values ('Denis', 'Vaksman', 'Det', '12345'),
       ('Pavel', 'Golovin', 'pg', '12345'),
       ('Evgeniy', 'Feder', 'dzaba', '12345'),
       ('Gleb', 'Drozdov', 'drozdik', '12345');

with det_id as (
    select id from Users where login = 'Det'
), chat_id as (
    insert into Chats (name, user_id) values ('Chat', (select id from det_id)) returning id
), ins1 as (
insert into UserChats (user_id, chat_id) values
        ((select id from det_id), (select id from chat_id))
), group_id as (
    insert into Groups (name, user_id)
        values ('Игромания', (select id from det_id))
        returning id
)
insert into UserGroups (user_id, group_id)
values ((select id from det_id), (select id from group_id));
