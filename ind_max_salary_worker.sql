select name, salary
from worker
where salary in (
select max(salary) as salary from worker
);