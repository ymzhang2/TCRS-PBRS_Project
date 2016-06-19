# Write scripts to query the students table and dectect missing or incorrect
# find how the missing value distributed
# form the name list of students who have missing or incorrect value by  variables including gender, race, grade, lunch,ethnicity and returning


#####################################################################
###                check missing value in gender                  ###
#####################################################################
###count the number of active student for each gender level
select gender, count(*)
from students
where status = 1
group by gender; ## there are 215 missing value for gender

###  how the missing value of gender for active student distribute
select  gender, leaID,campusID,classroomID, count(*)
from students
where (gender = "" or gender is NULL) and status = 1
group by leaId, campusId, classroomID with rollup;


### the name list of active students who have missing value for gender
select studentID, studentFullName, leaID, campusID,classroomID, gender
from students
where (gender='' or gender is NULL) and status = 1
order by leaID, campusID, classroomID;


#####################################################################
###                 check missing value in race                   ###
#####################################################################
### count the number of active students for each race level
select count(*), race
from students
where status = 1
group by race
order by count(*) DESC; ### there are 531 missing values and 31 Ns which are errors.

## find where the missing value come from for active student 
select  leaID, campusID, classroomID,race, count(*)
from students
where (race= "" or race  is NULL) and status =1
group by leaID,campusID,classroomID with rollup;


### find where the N(uncorrect race category) come from for active students
select leaID, campusID, classroomID, race,count(*) 
from students
where race='N' and status = 1
group by leaID,campusID,classroomID;


### name list of the active students whose race are uncorrect or null
select studentId,studentFullName, leaID, campusID, classroomID,race
from students
where (race='N'or race= "" or race is NULL) and status = 1
order by leaID, campusID, classroomID;

#####################################################################
###                ccheck missing value in lunch                  ###
#####################################################################
### count the number of active students for each lunch level
select lunch, count(*)
from students
where status = 1
group by lunch; ### there are 484 missing value

## how the missing value for lunch distribute
select lunch,leaID, campusID, count(*)
from students
where status = 1 and (lunch="" or lunch is NULL)
group by lunch, leaID, campusID
order by leaID, campusID;

### name list of students whose lunch state is null
select studentID, studentFullName, leaID, campusId, classroomId, lunch
from students
where status = 1 and (lunch = "" or lunch is NULL)
order by leaId, campusId, classroomId;

#####################################################################
###                check missing value in grade                   ###
#####################################################################
# check students' grade status
select studentGrade, count(*)
from students
where status = 1
group by studentGrade
order by count(*) desc; ## only 10 missing value 

### how the missing value distribute
select studentGrade, leaID, campusID,classroomID,count(*)
from students
where status = 1 and (studentGrade = "" or studentGrade is NULL)
group by studentGrade, leaID, campusID, classroomID;
#####################################################################
###              check missing value in ethnicity                 ###
#####################################################################
### check missing value in ethnicity
select ethnicity, count(*)
from students
where status =1 
group by ethnicity;# there are 554 missing value

###  how the missing value of ethnicity distribute?
select ethnicity, leaId, campusID,classroomID,count(*)
from students
where status =1 and (ethnicity is NULL or ethnicity = "")
group by leaID, campusId,classroomID 
order by leaID, campusID,classroomID;

### name list of students whose ethnicity are nulls
select studentID, studentFullName, leaId, campusID, classroomID
from students
where status =1 and (ethnicity="" or ethnicity is NULL)
order by leaID, campusID, classroomID;
#####################################################################
###              check missing value in retrunning                ###
#####################################################################
### check missing value for retrunning 
select returning, count(*)
from students
where status=1
group by returning;## no missing value find

####################################################################
###                    detect uncorrect data                     ###
####################################################################
####verify that if status is inactive, the classroom and campus ids should be blank
select  classroomID, campusID, status
from students
where status =0
group by campusID, classroomID; ### it shows there are some uncorrect data 

#### find the name list of the above uncorrect data. 
select studentID, studentFullName, classroomID, campusID, status
from students
where status = 0 and (campusID!="" or campusID is Not NULL or classroomID!="" or classroomID is NOT NULL);
