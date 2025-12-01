CREATE TABLE PostImage (
    image_id INT NOT NULL AUTO_INCREMENT,
    post_id INT NOT NULL,
    img_path VARCHAR(255) NOT NULL,
    PRIMARY KEY (image_id),
    FOREIGN KEY (post_id) REFERENCES Post(post_id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;