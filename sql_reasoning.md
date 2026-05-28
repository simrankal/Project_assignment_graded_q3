# SQL Reasoning

## LEFT JOIN vs INNER JOIN

Query Used:
Students and enrollments query.

Reason:
LEFT JOIN is more appropriate because we want to include students even if they are not enrolled in any course.

If INNER JOIN were used, unenrolled students would disappear from the output.

---

## HAVING vs WHERE

Query Used:
Students with more than 50 submissions.

Reason:
`HAVING` is required because filtering happens after aggregation using `COUNT()`.

`WHERE COUNT(...) > 50` would be invalid.

---

## Subquery Usage

Query Used:
Students whose average score exceeds overall average.

Reason:
The subquery calculates the overall average score first.
The outer query compares each student's average against it.

---

## Duplicate Record Risk

Query Used:
Course enrollment counts.

Risk:
If duplicate enrollment rows exist for the same student-course pair, counts become inflated.

Possible Solution:
Use:

```sql id="gk9q77"
COUNT(DISTINCT e.student_id)
```

---

## Edge Case Considered

Query Used:
Problems never attempted.

Edge Case:
If NULL problem IDs exist in submissions, `NOT IN` may behave unexpectedly.

Safer alternative:

```sql id="e22d4h"
NOT EXISTS
```
