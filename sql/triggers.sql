create or replace function post_delete_prepare() returns trigger
AS $$
begin
    delete from Likes where post_id = old.id;
    delete from UserPosts where post_id = old.id;
    delete from PostMedia where post_id = old.id;
    delete from GroupPosts where post_id = old.id;
end;
$$ LANGUAGE plpgsql;

create trigger post_delete_prepare
    before delete
    on Posts
execute procedure post_delete_prepare();
