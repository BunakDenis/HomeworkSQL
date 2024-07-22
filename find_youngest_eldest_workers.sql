select 'oldest' as type, name, birthday
from worker
where datediff(now(), birthday) > 29000

union

select 'youngest' as type, name, birthday
from worker
where datediff(now(), birthday) < 14000;