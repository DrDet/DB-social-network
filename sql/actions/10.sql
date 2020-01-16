select post_id, count(*) as likes_count from
    Followers
    inner join Likes on following_id = user_id and
                        follower_id = USER_ID
group by post_id
order by likes_count desc
limit 20;