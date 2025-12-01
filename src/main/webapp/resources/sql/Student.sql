CREATE TABLE Student (
    student_id VARCHAR(9) NOT NULL,
    nickname VARCHAR(20) NOT NULL,
    password VARCHAR(100) NOT NULL,
    PRIMARY KEY (student_id)
) DEFAULT CHARSET=utf8;