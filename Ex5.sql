CREATE TABLE students (
                          student_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          major VARCHAR(50)
);

CREATE TABLE courses (
                         course_id SERIAL PRIMARY KEY,
                         course_name VARCHAR(100),
                         credit INT
);

CREATE TABLE enrollments (
                             student_id INT REFERENCES students(student_id),
                             course_id INT REFERENCES courses(course_id),
                             score NUMERIC(5,2),

                             PRIMARY KEY (student_id, course_id)
);

SELECT
    s.full_name AS "Tên sinh viên",
    c.course_name AS "Môn học",
    e.score AS "Điểm"
FROM students s
         JOIN enrollments e
              ON s.student_id = e.student_id
         JOIN courses c
              ON c.course_id = e.course_id;

SELECT
    s.student_id,
    s.full_name,
    AVG(e.score) AS average_score,
    MAX(e.score) AS highest_score,
    MIN(e.score) AS lowest_score
FROM students s
         JOIN enrollments e
              ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name;

SELECT
    s.major,
    AVG(e.score) AS average_score
FROM students s
         JOIN enrollments e
              ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

SELECT
    s.full_name,
    c.course_name,
    c.credit,
    e.score
FROM students s
         JOIN enrollments e
              ON s.student_id = e.student_id
         JOIN courses c
              ON c.course_id = e.course_id;


SELECT
    s.student_id,
    s.full_name,
    AVG(e.score) AS average_score
FROM students s
         JOIN enrollments e
              ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (
    SELECT AVG(score)
    FROM enrollments
);