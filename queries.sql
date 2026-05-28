-- =========================================
-- BASIC RETRIEVAL AND FILTERING
-- =========================================

-- Query 1
-- Purpose:
-- List all active students with ID, name, email, batch, and admission date.

SELECT
s.student_id,
s.full_name,
s.email,
b.batch_name,
s.admission_date
FROM students s
JOIN batches b
ON s.batch_id = b.batch_id
WHERE s.status = 'active';

-- =========================================

-- Query 2
-- Purpose:
-- Find students whose email is missing or invalid.

SELECT
student_id,
full_name,
email
FROM students
WHERE email IS NULL
OR email NOT LIKE '%@%.%';

-- =========================================

-- Query 3
-- Purpose:
-- List all Easy and Medium problems.

SELECT
problem_id,
title,
difficulty
FROM problems
WHERE difficulty IN ('Easy', 'Medium');

-- =========================================

-- Query 4
-- Purpose:
-- Display latest 20 submissions.

SELECT
submission_id,
student_id,
problem_id,
status,
submitted_at
FROM submissions
ORDER BY submitted_at DESC
LIMIT 20;

-- =========================================

-- Query 5
-- Purpose:
-- Find unsuccessful submissions.

SELECT
submission_id,
student_id,
problem_id,
status
FROM submissions
WHERE status <> 'successful';

-- =========================================
-- JOINS
-- =========================================

-- Query 6
-- Purpose:
-- Display submission details with student and problem info.

SELECT
sub.submission_id,
s.full_name,
p.problem_title,
sub.language,
sub.status,
sub.score,
sub.submitted_at
FROM submissions sub
JOIN students s
ON sub.student_id = s.student_id
JOIN problems p
ON sub.problem_id = p.problem_id;

-- =========================================

-- Query 7
-- Purpose:
-- Display all students and their enrollments.

SELECT
s.student_id,
s.full_name,
c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id;

-- =========================================

-- Query 8
-- Purpose:
-- Count enrolled students per course.

SELECT
c.course_id,
c.course_name,
COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- =========================================

-- Query 9
-- Purpose:
-- Display test case results with student and problem info.

SELECT
tr.test_result_id,
s.full_name,
p.problem_title,
tr.test_case_id,
tr.status
FROM test_results tr
JOIN submissions sub
ON tr.submission_id = sub.submission_id
JOIN students s
ON sub.student_id = s.student_id
JOIN problems p
ON sub.problem_id = p.problem_id;

-- =========================================

-- Query 10
-- Purpose:
-- Students enrolled but never submitted solutions.

SELECT DISTINCT
s.student_id,
s.full_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN submissions sub
ON s.student_id = sub.student_id
WHERE sub.submission_id IS NULL;

-- =========================================
-- AGGREGATION AND HAVING
-- =========================================

-- Query 11
-- Purpose:
-- Count submissions by status.

SELECT
status,
COUNT(*) AS total_submissions
FROM submissions
GROUP BY status;

-- =========================================

-- Query 12
-- Purpose:
-- Average score per problem.

SELECT
p.problem_id,
p.problem_title,
AVG(sub.score) AS avg_score
FROM submissions sub
JOIN problems p
ON sub.problem_id = p.problem_id
GROUP BY p.problem_id, p.problem_title;

-- =========================================

-- Query 13
-- Purpose:
-- Students with more than 50 submissions.

SELECT
s.student_id,
s.full_name,
COUNT(sub.submission_id) AS total_submissions
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id, s.full_name
HAVING COUNT(sub.submission_id) > 50;

-- =========================================

-- Query 14
-- Purpose:
-- Problems with success rate below 40%.

SELECT
p.problem_id,
p.problem_title,
ROUND(
SUM(CASE WHEN sub.status = 'successful' THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS success_rate
FROM problems p
JOIN submissions sub
ON p.problem_id = sub.problem_id
GROUP BY p.problem_id, p.problem_title
HAVING ROUND(
SUM(CASE WHEN sub.status = 'successful' THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) < 40;

-- =========================================

-- Query 15
-- Purpose:
-- Top 10 most attempted problems.

SELECT
p.problem_id,
p.problem_title,
COUNT(sub.submission_id) AS attempts
FROM problems p
JOIN submissions sub
ON p.problem_id = sub.problem_id
GROUP BY p.problem_id, p.problem_title
ORDER BY attempts DESC
LIMIT 10;

-- =========================================
-- SUBQUERIES
-- =========================================

-- Query 16
-- Purpose:
-- Students whose average score exceeds overall average.

SELECT
s.student_id,
s.full_name,
AVG(sub.score) AS avg_score
FROM students s
JOIN submissions sub
ON s.student_id = sub.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(sub.score) >
(
SELECT AVG(score)
FROM submissions
);

-- =========================================

-- Query 17
-- Purpose:
-- Problems never attempted.

SELECT
p.problem_id,
p.problem_title
FROM problems p
WHERE p.problem_id NOT IN
(
SELECT DISTINCT problem_id
FROM submissions
);

-- =========================================

-- Query 18
-- Purpose:
-- Students enrolled but never submitted.

SELECT
s.student_id,
s.full_name
FROM students s
WHERE s.student_id IN
(
SELECT student_id
FROM enrollments
)
AND s.student_id NOT IN
(
SELECT DISTINCT student_id
FROM submissions
);

-- =========================================

-- Query 19
-- Purpose:
-- Students who submitted in both Python and Java.

SELECT
s.student_id,
s.full_name
FROM students s
WHERE s.student_id IN
(
SELECT student_id
FROM submissions
WHERE language = 'Python'
)
AND s.student_id IN
(
SELECT student_id
FROM submissions
WHERE language = 'Java'
);

-- =========================================

-- Query 20
-- Purpose:
-- Second highest score for a problem.

SELECT DISTINCT score
FROM submissions
WHERE problem_id = 101
ORDER BY score DESC
LIMIT 1 OFFSET 1;
