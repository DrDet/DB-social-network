create unique index on Users (id);
create unique index on Users (login);
create unique index on Groups (id);
create unique index on Followers (follower_id, following_id);

-- для внешних ключей
create index on GroupPosts (group_id);
create index on UserPosts (user_id);
create index on PostMedia (post_id);
create index on UserMedia (user_id);
create index on UserChats (chat_id);
create index on GroupPosts (group_id);