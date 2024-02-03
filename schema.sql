CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "age" INTEGER,
    "date_of_birht" NUMERIC,
    "gender" TEXT CHECK("gender" IN ('m' , 'f')),
    PRIMARY KEY("id")
);

CREATE TABLE "artists" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "age" INTEGER,
    "date_of_birth" NUMERIC,
    "gender" TEXT CHECK("gender" IN ('m' , 'f')),
    PRIMARY KEY("id")
);

CREATE TABLE "songs" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "year" INTEGER,
    PRIMARY KEY("id")
);

CREATE TABLE "albums" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "year" INTEGER,
    "produced_by" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("produced_by") REFERENCES "artists"("id")
);

CREATE TABLE "playlists" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "created_by" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("created_by") REFERENCES "users"("id")
);

CREATE TABLE "performed" (
    "artist_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("artist_id","song_id"),
    FOREIGN KEY("artist_id") REFERENCES "artists"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

CREATE TABLE "album_have" (
    "album_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("album_id","song_id"),
    FOREIGN KEY("album_id") REFERENCES "albums"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

CREATE TABLE "user_liked_songs" (
    "user_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("user_id","song_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

CREATE TABLE "user_liked_albums" (
    "user_id" INTEGER,
    "album_id" INTEGER,
    PRIMARY KEY("album_id","user_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("album_id") REFERENCES "albums"("id")
);

CREATE TABLE "user_liked_playlists" (
    "user_id" INTEGER,
    "playlist_id" INTEGER,
    PRIMARY KEY("playlist_id","user_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("playlist_id") REFERENCES "playlists"("id")
);

CREATE TABLE "user_aritst_follows" (
    "user_id" INTEGER,
    "artist_id" INTEGER,
    PRIMARY KEY("user_id","artist_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("artist_id") REFERENCES "artists"("id")
);

CREATE TABLE "user_user_follows" (
    "first_user_id" INTEGER,
    "second_user_id" INTEGER,
    PRIMARY KEY("first_user_id","second_user_id"),
    FOREIGN KEY("first_user_id") REFERENCES "users"("id"),
    FOREIGN KEY("second_user_id") REFERENCES "users"("id")
);

CREATE INDEX "song_names" ON "songs"("name");
CREATE INDEX "artist_names" ON "artists"("name");
CREATE INDEX "album_names" ON "albums"("name");


CREATE VIEW "likes_songs" AS
SELECT "songs"."name" , COUNT("user_liked_songs"."song_id")
FROM "songs"
JOIN "user_liked_songs" ON "songs"."id" = "song_id"
GROUP BY "songs"."name";

CREATE VIEW "likes_albums" AS
SELECT "albums"."name" , COUNT("user_liked_albums"."album_id")
FROM "albums"
JOIN "user_liked_albums" ON "albums"."id" = "album_id"
GROUP BY "albums"."name";

CREATE VIEW "likes_playlists" AS
SELECT "playlists"."name" , COUNT("user_liked_playlists"."playlist_id")
FROM "playlists"
JOIN "user_liked_playlists" ON "playlists"."id" = "playlist_id"
GROUP BY "songs"."name";

CREATE VIEW "songs_artist" AS
SELECT "songs"."name" As "song" , CONCAT("artists"."first_name",' ',"artists"."last_name") AS "artist"
FROM "songs"
JOIN "performed" on "songs"."id" = "song_id"
JOIN "artists" ON "artists"."id" = "artist_id";


