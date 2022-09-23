-- EXERCISES

-- FINDING 5 OLDEST USERS:

SELECT username,created_at FROM users ORDER BY created_at LIMIT 5; 

-- MOST POPULAR REGISTRAION DATE

SELECT DAYNAME(DATE_FORMAT (created_at,'%Y,%m,%d')) as registered_day,COUNT(*) as frequency 
FROM users 
GROUP BY registered_day 
ORDER BY frequency DESC;

-- FIND THE USERS WHO HAVE NEVER POSTED A PHOTOS

SELECT users.username
FROM users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- FIND USER WHO CAN GET MOST LIKES ON SINGLE PHOTO:

SELECT users.username,photos.id,photos.image_url,COUNT(likes.photo_id) as most_likes
FROM users
JOIN photos
ON users.id = photos.user_id
JOIN likes
ON likes.photo_id = photos.id
GROUP BY photos.id
ORDER BY COUNT(likes.photo_id) DESC LIMIT 1;

-- CACULATE AVERGAE NUMBER OF PHOTOS PER USER :
-- TOTAL NO OF PHOTOS / TOTAL NO OF USERS:

SELECT(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);

-- TOP 5 MOST COMMONLY USED HASHTAGS:

SELECT tags.tag_name,COUNT(*) as NO_OF_TIMES
FROM tags
JOIN photo_tags
ON tags.id = photo_tags.tag_id
GROUP BY tags.tag_name
ORDER BY NO_OF_TIMES DESC LIMIT 5;

-- FIND THE USERS WHO HAVE LIKED EVERY SINGLE PHOTO ON THE SITE:

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);


