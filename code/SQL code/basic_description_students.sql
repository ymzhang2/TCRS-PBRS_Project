############################################################################################
#Basic description for some varialbes                                                      #
# a)Count the number of active students in each LEA, campus, classroom, and grade          #
# b)provide basic statistic for some variables by lea and campus                           #
############################################################################################

### roll up the number of active students in each LEA, campus, classroom, and grade
select studentGrade,leaID,campusID, classroomID,count(*)
from students
where status = 1
group by studentGrade, leaID, campusID, classroomID with rollup;

### count the number of active student in LEA
select leaID, count(*)
from students
where status = 1
group by leaID
order by count(*);

### count the number of active student in each campus
select campusID, count(*)
from students
where status =1
group by campusID
order by count(*) desc;

### count the number of active student in each classroom
select classroomID, count(*)
from students
where status =1
group by classroomID
order by count(*);

### count the number of active student in each grade
select studentGrade, count(*)
from students
where status =1
group by studentGrade;



# Provide statistics on race for active students by LEA and campus
select race,leaID, campusID, count(*) 
from students
where status =1
group by race,leaID, campusID;

# Provide statistics on gender active students by LEA and campus
select gender, leaID, campusID, count(*)
from students
where status = 1
group by gender,leaID, campusID ;

# Provide statistics on lunch status for active students by LEA and campus
select lunch, leaID, campusID, count(*)
from students
where status =1
group by lunch,leaID, campusID;

# Provide statistics on ethnicity for active students by LEA and campus
select ethnicity, leaID, campusID
from students
where status =1
group by ethnicity, leaID, campusID;

# Provide statistics on returning for active students by LEA and campus
select returning, leaID, campusID
from students
where status =1
group by returning, leaID, campusID;
