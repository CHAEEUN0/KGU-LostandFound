CREATE TABLE Comment (
    comment_id INT NOT NULL AUTO_INCREMENT,
    post_id INT NOT NULL,
    student_id VARCHAR(9) NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    PRIMARY KEY (comment_id),
    FOREIGN KEY (post_id) REFERENCES Post(post_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
) DEFAULT CHARSET=utf8;