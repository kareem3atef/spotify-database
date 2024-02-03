INSERT INTO "users" ("first_name")
VALUES ("kareem");


INSERT INTO "artists" ("first_name" , "last_name")
VALUES ("Amr" , "Diab");

INSERT INTO "songs" ("name" , "year")
VALUES
("ma3ak qalby" , 2016),
("qosad 3iny" , 2004),
("ana msh anany" , 2014),
("khlek m3aya" , 2009);


INSERT INTO "albums" ("name" , "year" , "produced_by")
VALUES
("a7la w a7la" , 2016 , 1);

INSERT INTO "performed"
VALUES
(1,1),(1,2),(1,3),(1,4);


INSERT INTO "album_have" ("album_id", "song_id")
VALUES (
  (SELECT "id" FROM "albums" WHERE "name" = 'a7la w a7la'),
  (SELECT "id" FROM "songs" WHERE "name" = 'ma3ak qalby')
);

SELECT * FROM "songs_artist";


