SELECT    students.name, ( SELECT count(*)
                           FROM applications
                           WHERE applications.student_id = students.id )
                           AS application_count
FROM      students
ORDER BY  application_count DESC,
          students.name
