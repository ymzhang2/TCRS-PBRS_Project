SELECT * FROM ecrdata.ATC;
select atcon, atcunit
from ATC
where atcunit not between 1 and 6;

select * from attendance;
select id 
from attendance
where id is not null;

select * from students;

select status, studentFirst, ClassroomID
from students
where classroomID is NULL
order by 2;

select studentID, leaID
from students
where campusId = &cam_id;

select studentFirst, studentLast
from students
where studentLast like '_a%'
And campusId = 'DCS';

select studentFirst 'First', studentLast 'Last'
from students;

select studentId, studentFirst "First", studentLast "Last"

from students
where studentLast like 'D%' or studentLast like 'J%'
order by Last;

select count(studentFirst) 'Number', studentLast as Last, campusID 
from students
where leaId = 'AELPCS'
group by campusID

select distinct campusID
from students
where leaId = 'AELPCS';


