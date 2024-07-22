select client.name, count(project.client_id) as project_count
from client
left join project on client.id=project.client_id
group by client.name
having project_count > 2;