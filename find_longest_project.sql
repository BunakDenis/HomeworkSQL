select 'project A' as name, period_diff(date_format(finish_date, '%Y%m'), date_format(start_date, '%Y%m')) as month_count
from project
group by month_count
order by month_count desc
limit 1;