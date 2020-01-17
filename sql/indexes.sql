create unique index on Users (id);
create unique index on Users (login);
create unique index on Groups (id);
create unique index on Posts(id);
create unique index on GroupPosts (post_id);
create index on PostMedia (post_id);
create index on UserChats (chat_id);