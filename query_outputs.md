his file is where many students lose marks.

You MUST include:

purpose
sample output
validation note
# Query Outputs and Validation

---

## Query 1 — Active Students

### Purpose

List all active students with batch information.

### Sample Output

| student_id | full_name    | batch_name  |
| ---------- | ------------ | ----------- |
| 101        | Aditi Sharma | DS-Batch-1  |
| 102        | Rahul Verma  | Web-Batch-2 |

### Validation

The output only includes students whose status is marked as `active`. Students with inactive or suspended status do not appear.

---

## Query 8 — Course Enrollment Counts

### Purpose

Count enrolled students per course.

### Sample Output

| course_name | total_students |
| ----------- | -------------- |
| DBMS        | 120            |
| DSA         | 210            |

### Validation

Courses with no enrollments still appear because LEFT JOIN was used.

---

## Query 14 — Low Success Rate Problems

### Purpose

Identify difficult problems.

### Sample Output

| problem_title     | success_rate |
| ----------------- | ------------ |
| Graph Traversal X | 28.40        |

### Validation

The problem appears frequently in failed submissions, making the low success rate logically reasonable.
