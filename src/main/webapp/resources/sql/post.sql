CREATE TABLE Post (
    post_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    student_id VARCHAR(9) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    PRIMARY KEY (post_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
) DEFAULT CHARSET=utf8;