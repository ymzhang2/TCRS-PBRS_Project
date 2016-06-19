select * from students;
# find names of students who are at campus and their gender are missing
select concat(studentFirst, ",", studentLast)as Name, gender, leaID
from students
where gender='' or gender is NULL and status = 1;

### count students' gender is missing and then group by leaID
select count(*), gender, leaID
from students
where gender = "" or gender is NULL and status = 1
group by leaId;

### count the#of students of each race level
select count(*), race
from students
where status = 1
group by race;

## find student who are on campus or race is missing, blank or N and then group by classroomID 
select count(*), leaID, campusID, classroomID
from students
where race='N' or race= "" or race  is NULL and status = 1
group by leaID,campusID,classroomID;

### count the # of student with different leaID
select count(*), leaID
from students
where status = 1
group by leaID;
### count the # of students whose lunch status is missing and then group by campus ID and leaID
select count(*),lunch,leaID, campusID
from students
where status = 1 and lunch="" or lunch is NULL
group by lunch, leaID, campusID;

# The ration of student in pk grade and those in ps grade
select studentGrade, count(*)
from students
where status = 1
group by studentGrade;

### Find student whose studentGrade status is IN and then group by leaID and campusID
select studentGrade, count(*), leaID, campusID
from students
where status = 1 and studentGrade = "IN"
group by studentGrade, leaID, campusID;

### find student whose studentGrade status is null and then group by leaID and campusID
select studentGrade, count(*), leaID, campusID
from students
where status = 1 and studentGrade is null
group by studentGrade, leaId, campusID;

### 