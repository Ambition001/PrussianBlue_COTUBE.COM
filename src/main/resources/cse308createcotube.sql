
CREATE TABLE Account (
    username VARCHAR(255) ,
    password VARCHAR(255) NOT NULL ,
    security_question INTEGER NOT NULL, #Number corresponds to which question VARCHAR(1000) NOT NULL,
    security_answer VARCHAR(1000) NOT NULL,
    profile_pic_path VARCHAR(1000) NOT NULL,
    account_role INTEGER NOT NULL, #0 = user, 1 = adminVARCHAR(65) NOT NULL,
    PRIMARY KEY (username) );
    
CREATE TABLE FollowUser(
	follower_username VARCHAR(255),
    following_username VARCHAR(255),
    follow_time DATETIME,
    PRIMARY KEY (follower_username , following_username),
    FOREIGN KEY (follower_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (following_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);
        
CREATE TABLE Folder(
	folder_id INTEGER,
	username VARCHAR(255),
    folder_name VARCHAR(255),
    folder_type INTEGER, #0 = FAVORITE, 1 = series VARCHAR(255),
    visibility INTEGER, #0 = private, 1 = public
    PRIMARY KEY(folder_id),
	FOREIGN KEY (username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Panel(
	panel_id INTEGER,
    author VARCHAR(255),
    canvas_path VARCHAR(1000),
    title_word VARCHAR(65), #ONLY FOR GAMECOMICS
    date_created DATETIME,
    PRIMARY KEY (panel_id),
	FOREIGN KEY (author) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Comic(
	comic_id INTEGER,
    comic_type INTEGER, #0 = REGULAR, 1 = GAME
    title VARCHAR(255),
    status INTEGER, #0 = non-published, 1 = published, 2 = censored VARCHAR(255),
    date_published DATETIME,
    PRIMARY KEY (comic_id));

CREATE TABLE Series(
	series_id INTEGER,
    series_name VARCHAR(255),
    folder_id INTEGER,
    PRIMARY KEY (series_id),
	FOREIGN KEY (folder_id) REFERENCES Folder (folder_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE RegularComic(
	regular_comic_id INTEGER,
    series_id INTEGER, #If not part of series, pass NULL
    thumbnail_path VARCHAR(1000),
    description VARCHAR(1000),
    panel_id INTEGER,
    PRIMARY KEY(regular_comic_id),
	FOREIGN KEY (panel_id) REFERENCES Panel (panel_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (series_id) REFERENCES Series (series_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE
	);

CREATE TABLE FollowSeries(
	follower_username VARCHAR(255),
    series_id INTEGER,
    follow_time DATETIME,
	PRIMARY KEY (follower_username , series_id),
    FOREIGN KEY (follower_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (series_id) REFERENCES RegularComic (series_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Views(
	comic_id INTEGER,
    viewer_username VARCHAR(255),
    view_time DATETIME,
    PRIMARY KEY(comic_id, viewer_username),
	FOREIGN KEY (comic_id) REFERENCES Comic (comic_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (viewer_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Likes(
	comic_id INTEGER,
    liker_username VARCHAR(255),
    like_time DATETIME,
    PRIMARY KEY(comic_id, liker_username),
	FOREIGN KEY (comic_id) REFERENCES Comic (comic_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (liker_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Comments(
	comic_id INTEGER,
    comment_number INTEGER,
    commenter_username VARCHAR(255),
    comment_time DATETIME,
    comment VARCHAR(255),
    status VARCHAR(255),
    PRIMARY KEY(comic_id, comment_number),
	FOREIGN KEY (comic_id) REFERENCES Comic (comic_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (commenter_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Tag(
	regular_comic_id INTEGER,
    comic_tag VARCHAR(255),
    PRIMARY KEY(regular_comic_id, comic_tag),
	FOREIGN KEY (regular_comic_id) REFERENCES RegularComic (regular_comic_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

CREATE TABLE Favorite(
	comic_id INTEGER,
    favoriter_username VARCHAR(255),
    favorite_time DATETIME,
    favorite_folder_id INTEGER,
    PRIMARY KEY(comic_id, favoriter_username),
    FOREIGN KEY (comic_id) REFERENCES Comic (comic_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (favorite_folder_id) REFERENCES Folder (folder_id)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	FOREIGN KEY (favoriter_username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);
/*
CREATE TABLE GameComic(

CREATE TABLE Notification(
	notification_id INTEGER,
	username VARCHAR(255),
    notification VARCHAR(1000),
    notification_time DATETIME,
    PRIMARY KEY(notification_id),
    FOREIGN KEY (username) REFERENCES Account (username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE);

#Folder table - Username, FolderName, type(series, favorite)