CREATE TABLE Genre (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR (50) NOT NULL
);


CREATE TABLE Artist (
	artist_id SERIAL PRIMARY KEY,
	name VARCHAR (100) NOT NULL
);


CREATE TABLE Artist_Genre (
	artist_id INTEGER REFERENCES Artist(artist_id) ON DELETE CASCADE,
	genre_id INTEGER REFERENCES Genre(genre_id) ON DELETE CASCADE,
	PRIMARY KEY (artist_id, genre_id) 
);


CREATE TABLE Album (
	album_id SERIAL PRIMARY KEY,
	title VARCHAR (200) NOT NULL,
	release_year INTEGER 
);


CREATE TABLE Artist_Album (
	artist_id INTEGER REFERENCES Artist(artist_id) ON DELETE CASCADE,
	album_id INTEGER REFERENCES Album(album_id) ON DELETE CASCADE,
	PRIMARY KEY (artist_id, album_id) 
);


CREATE TABLE Track (
	track_id SERIAL PRIMARY KEY,
	title VARCHAR (200) NOT NULL,
	duration INTEGER,
	album_id INTEGER NOT NULL REFERENCES Album(album_id) ON DELETE CASCADE 
);


CREATE TABLE Collection (
	collection_id SERIAL PRIMARY KEY,
	title VARCHAR (200) NOT NULL,
	release_year INTEGER
);


CREATE TABLE Collection_Track (
	collection_id INTEGER REFERENCES Collection(collection_id) ON DELETE CASCADE,
	track_id INTEGER REFERENCES Track(track_id) ON DELETE CASCADE,
	PRIMARY KEY(collection_id, track_id)
);