CREATE INDEX "enrollments_by_student_id" ON "enrollments" ("student_id");
CREATE INDEX "enrollments_by_course_id" ON "enrollments" ("course_id");

CREATE INDEX "courses_by_semester" ON "courses" ("semester");
CREATE INDEX "courses_by_department" ON "courses" ("department");

CREATE INDEX "satisfy_requirements" ON "satisfies" ("requirement_id");
CREATE INDEX "satisfy_course" ON "satisfies" ("course_id");
