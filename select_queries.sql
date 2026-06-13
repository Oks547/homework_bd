-- 2.1. Название и продолжительность самого длительного трека
SELECT title, duration
FROM Track
WHERE duration = (SELECT MAX(duration) FROM Track);

-- 2.2. Название треков, продолжительность которых не менее 3,5 минут (210 секунд)
SELECT title, duration
FROM Track
WHERE duration >= 210;

-- 2.3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title, release_year
FROM Collection
WHERE release_year BETWEEN 2018 AND 2020;

-- 2.4. Исполнители, чьё имя состоит из одного слова (нет пробелов)
SELECT name
FROM Artist
WHERE name NOT LIKE '% %';

-- 2.5. Название треков, которые содержат слово «мой» или «my»
SELECT title
FROM Track
WHERE LOWER(title) LIKE '%мой%' OR LOWER(title) LIKE '%my%';

-- ========== ЗАДАНИЕ 3 ==========

-- 3.1. Количество исполнителей в каждом жанре
SELECT g.name AS жанр, COUNT(ag.artist_id) AS количество_исполнителей
FROM Genre g
LEFT JOIN Artist_Genre ag ON g.genre_id = ag.genre_id
GROUP BY g.genre_id, g.name;

-- 3.2. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.track_id) AS количество_треков
FROM Track t
JOIN Album a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3.3. Средняя продолжительность треков по каждому альбому
SELECT a.title AS альбом, AVG(t.duration) AS средняя_длительность
FROM Album a
LEFT JOIN Track t ON a.album_id = t.album_id
GROUP BY a.album_id, a.title;

-- 3.4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT ar.name
FROM Artist ar
WHERE ar.artist_id NOT IN (
    SELECT aa.artist_id
    FROM Artist_Album aa
    JOIN Album a ON aa.album_id = a.album_id
    WHERE a.release_year = 2020
);

-- 3.5. Названия сборников, в которых присутствует исполнитель «Кино»
SELECT DISTINCT c.title AS сборник, c.release_year
FROM Collection c
JOIN Collection_Track ct ON c.collection_id = ct.collection_id
JOIN Track t ON ct.track_id = t.track_id
JOIN Album a ON t.album_id = a.album_id
JOIN Artist_Album aa ON a.album_id = aa.album_id
JOIN Artist ar ON aa.artist_id = ar.artist_id
WHERE ar.name = 'Кино';

-- ========== ЗАДАНИЕ 4 ==========

-- 4.1. Альбомы, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT a.title AS альбом
FROM Album a
JOIN Artist_Album aa ON a.album_id = aa.album_id
JOIN Artist_Genre ag ON aa.artist_id = ag.artist_id
GROUP BY a.album_id, a.title
HAVING COUNT(DISTINCT ag.genre_id) > 1;

-- 4.2. Треки, которые не входят в сборники
SELECT t.title AS трек
FROM Track t
LEFT JOIN Collection_Track ct ON t.track_id = ct.track_id
WHERE ct.collection_id IS NULL;

-- 4.3. Исполнитель(и), написавший самый короткий трек
SELECT ar.name, t.title, t.duration
FROM Track t
JOIN Album a ON t.album_id = a.album_id
JOIN Artist_Album aa ON a.album_id = aa.album_id
JOIN Artist ar ON aa.artist_id = ar.artist_id
WHERE t.duration = (SELECT MIN(duration) FROM Track);

-- 4.4. Альбомы, содержащие наименьшее количество треков
SELECT a.title, COUNT(t.track_id) AS количество_треков
FROM Album a
LEFT JOIN Track t ON a.album_id = t.album_id
GROUP BY a.album_id, a.title
HAVING COUNT(t.track_id) = (
    SELECT MIN(track_count)
    FROM (SELECT COUNT(track_id) AS track_count FROM Track GROUP BY album_id) AS counts
);

SELECT name
FROM Artist
WHERE name NOT LIKE '% %'
ORDER BY name;
