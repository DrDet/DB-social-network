begin;

create type gender as enum ('male', 'female');

create table Users
(
  id           numeric(10)  not null unique,
  gender       gender       not null,
  name         varchar(100) not null,
  surname      varchar(100) not null,
  birthday     date,
  phone_number numeric(15),
  email        varchar(40),
  native_town  varchar(100),
  interests    varchar(500),
  primary key (id)
);

create table Chats
(
  id      numeric(10)  not null unique,
  name    varchar(100) not null,
  user_id numeric(10)  not null,
  primary key (id)
);

create table Messages
(
  id      numeric(10)   not null unique,
  text    varchar(5000) not null,
  time    timestamp     not null,
  user_id numeric(10)   not null,
  chat_id numeric(10)   not null,
  primary key (id)
);

create table Groups
(
  id      numeric(10)  not null unique,
  name    varchar(100) not null,
  user_id numeric(10)  not null,
  primary key (id)
);

create table Posts
(
  id   numeric(10)    not null unique,
  text varchar(15000) not null,
  time timestamp      not null,
  primary key (id)
);

create type media_type as enum ('image', 'video', 'audio', 'gif');

create table Media
(
  id        numeric(10)  not null unique,
  type      media_type   not null,
  size      numeric(15)  not null,
  file_path varchar(500) not null,
  time      timestamp    not null,
  primary key (id)
);

create table Friends
(
  user_id1 numeric(10) not null,
  user_id2 numeric(10) not null,
  primary key (user_id1, user_id2),
  foreign key (user_id1) references Users (id) deferrable initially deferred,
  foreign key (user_id2) references Users (id) deferrable initially deferred
);

create table UserChats
(
  user_id numeric(10) not null,
  chat_id numeric(10) not null,
  primary key (user_id, chat_id),
  foreign key (user_id) references Users (id) deferrable initially deferred,
  foreign key (chat_id) references Chats (id) deferrable initially deferred
);

create table UserGroups
(
  user_id  numeric(10) not null,
  group_id numeric(10) not null,
  primary key (user_id, group_id),
  foreign key (user_id) references Users (id) deferrable initially deferred,
  foreign key (group_id) references Groups (id) deferrable initially deferred
);

create table UserMedia
(
  media_id numeric(10) not null unique,
  user_id  numeric(10) not null,
  primary key (media_id),
  foreign key (media_id) references Media (id) deferrable initially deferred,
  foreign key (user_id) references Users (id) deferrable initially deferred
);

create table UserPosts
(
  post_id numeric(10) not null unique,
  user_id numeric(10) not null,
  primary key (post_id),
  foreign key (post_id) references Posts (id) deferrable initially deferred,
  foreign key (user_id) references Users (id) deferrable initially deferred
);

create table GroupPosts
(
  post_id  numeric(10) not null unique,
  group_id numeric(10) not null,
  primary key (post_id),
  foreign key (post_id) references Posts (id) deferrable initially deferred,
  foreign key (group_id) references Groups (id) deferrable initially deferred
);

create table GroupMedia
(
  media_id numeric(10) not null unique,
  group_id numeric(10) not null,
  primary key (media_id),
  foreign key (media_id) references Media (id) deferrable initially deferred,
  foreign key (group_id) references Groups (id) deferrable initially deferred
);

create table MessageMedia
(
  media_id   numeric(10) not null unique,
  message_id numeric(10) not null,
  primary key (media_id),
  foreign key (media_id) references Media (id) deferrable initially deferred,
  foreign key (message_id) references Messages (id) deferrable initially deferred
);

create table PostMedia
(
  media_id numeric(10) not null unique,
  post_id  numeric(10) not null,
  primary key (media_id),
  foreign key (media_id) references Media (id) deferrable initially deferred,
  foreign key (post_id) references Posts (id) deferrable initially deferred
);

alter table Chats
  add foreign key (id, user_id) references UserChats (chat_id, user_id) deferrable initially deferred;

alter table Messages
  add foreign key (user_id) references Users (id) deferrable initially deferred,
  add foreign key (chat_id) references Chats (id) deferrable initially deferred;

alter table Groups
  add foreign key (id, user_id) references UserGroups (group_id, user_id) deferrable initially deferred;

commit;
