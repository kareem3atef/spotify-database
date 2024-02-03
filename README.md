# Design Document

Kareem Atef

## Scope



* it's for tracking music in an audio streaming company like spotify
* it contains basic information like the tracks and albums for the artists
* what is not included ?? >> how many plays for the track , how many minutes does the user spent on the app and so on, it's a basic implementation for database

## Functional Requirements

* CRUD operations for all the entites in the database
* you can know the tracks for an artists , the albums , the liked trakcs
    by a user , the playlist created by a user

## Representation
Entities are captured in SQLite tables with the following schema.
[![](https://mermaid.ink/img/pako:eNptUTFuwzAM_IrAOfmA5q6dugVaGJuOhUimQUktAst_ryIrbYJYE3V3PB7IBTruCTSQfFi8CHozqfJQog1Rrfl4zIsKPF2UVjPJwPKqyFwV6M7J3yXCfeqoSSq48rPHiN-NTYGkkrw8zLQa2Dn-eRe0bmeve91t-D5b6x3nnCs9O7y5bXgnhLE5_MGvAUYM7xOeLLYIcABP4tH2ZbPLvcFAHMmTAV3Ks8PuasBMaxFiivx1mzrQURIdIM19CdGOAXpAFwo643Ri_v9TbyPL53a7esL1F0PsmYI?type=png)](https://mermaid.live/edit#pako:eNptUTFuwzAM_IrAOfmA5q6dugVaGJuOhUimQUktAst_ryIrbYJYE3V3PB7IBTruCTSQfFi8CHozqfJQog1Rrfl4zIsKPF2UVjPJwPKqyFwV6M7J3yXCfeqoSSq48rPHiN-NTYGkkrw8zLQa2Dn-eRe0bmeve91t-D5b6x3nnCs9O7y5bXgnhLE5_MGvAUYM7xOeLLYIcABP4tH2ZbPLvcFAHMmTAV3Ks8PuasBMaxFiivx1mzrQURIdIM19CdGOAXpAFwo643Ri_v9TbyPL53a7esL1F0PsmYI)

### Entities
The database includes the following entities:

#### user

the `user` table includes
* `id` integer , autoincremental and the primary key of the table
* `fisrt_name` can not by null
* `last_name`
* `age`
* `date_birth`
* `gender` (m ,f)

#### artist

the `artist` table includes
* `id` integer , autoincremental and the primary key of the table
* `first_name` can not be null
* `last_name`
* `age` calculated from the date of birth
* `date_birth`
* `gender` (m ,f)

#### song

the `song` table includes
* `id` integer , autoincremental and the primary key of the table
* `name` can not be null
* `year` the year of the release

#### album
the `album` table includes
* `id` integer , autoincremental and the primary key of the table
* `name` can not be null
* `year` the year of the release
* `produced_by` foreign key references to the artist_id

#### playlist
the `playlist` table includes
* `id` integer , autoincremental and the primary key of the table
* `name` can not be null
* `created_by` foreign key references to the user_id


### Relationships
the follow relationships are ~one to many~ relationship
* the `album` can be produced by single `artist`
* the `playlist` can be created by single `user`

there are ~many to many~ relationships also between the enteties need to be represented by tables
the `performed` table represent the relation between the song and the artist , may be there are songs that performed by more than one artist like the feat between Cairokee and Abulbaset hamouda which is Elseka shemal fe shemal
* `artist_id` foreign key references to the artist_id
* `song_id` foreign key references to the song_id
 the two attributes are the primary key of the table

the `album_have` table represent the relation between the album and the songs included
* `album_id` foreing key references to the album_id
* `song_id` foreign key references to the song_id
the two attributes are the primary key of the table

the `user_liked_songs` table represent the relation between the song which liked by the users
* `user_id` foreign key references to the user_id
* `song_id` foreing key references to the song_id
the two attributes are the primary key of the table

the `user_liked_album` table represent the relation between the album which liked by the users
* `user_id` foreign key references to the user_id
* `album_id` foreing key references to the album
the two attributes are the primary key of the table

the `user_liked_playlist` table represent the relation between the playlist which liked by the users *note that the playlist created by user and liked by another users*
* `user_id` foreign key references to the user_id
* `playlist_id` foreing key references to the playlist
the two attributes are the primary key of the table

the `follow_artist` teble represnts the users follow artist relationship
* `user_id` foreing key references to the user_id
* `artist_id` foreign key references to the artist_id
the two attributes are the primary key of the table

the `follow_user` teble represnts the users follow users relationship
*note that the users can follow each others*
* `first_user_id` foreing key references to the user_id who follow
* `second_user_id` foreing key references to the user_id who get followed by the first user
the two attributes are the primary key of the table



## Optimizations

indexes are created on the `songs name` and `artists name` and `albums name` to speed the retrieval of them

view created to
* aggregate the likes of songs , albums `likes_songs` , `likes_albums` , `playlists`
* simplify the relation between the artist and the song `songs_artist`
* partitioning the songs by the year
 --on creating haha--


## Limitations

* the schema assume that the songs inserted are not heavy operation beacuse of the index
