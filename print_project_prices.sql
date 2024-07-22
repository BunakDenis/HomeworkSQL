delimiter #
drop procedure if exists show_project_prices#
    drop table if exists project_prices#
create procedure show_project_prices()
	begin
    
	declare count_projects int default 0;
    declare current_project_id int default 0;
    declare current_worker_id int default 0;
	declare current_price int default 0;
	declare salary_of_worker int default 0;
    declare max_count_project_workers int default 0;
    declare booleane_value int default 0;
    declare days_of_start_date int default 0;
    declare days_of_finish_date int default 0;
    declare termin_of_current_project int default 0;
    select count(*) from project_worker into max_count_project_workers;
    

    create temporary table project_prices (
    id int not null,
    name varchar(50),
    price int,
    primary key (id)
    );
    
    while (count_projects < max_count_project_workers) do
     
    select project_id from project_worker limit count_projects,1 into current_project_id;
	select worker_id from project_worker limit count_projects,1 into current_worker_id;
    select price from project_prices where id=current_project_id into current_price;
    select salary from worker where id=current_worker_id into salary_of_worker;
    select exists(select * from project_prices where (id=current_project_id)) into booleane_value;
    set days_of_start_date = date_format((select start_date from project where id=current_project_id), '%Y%m');
    set days_of_finish_date = date_format((select finish_date from project where id=current_project_id), '%Y%m');
    set termin_of_current_project = period_diff(days_of_finish_date, days_of_start_date);

		if booleane_value > 0 then update project_prices set price = price + (salary_of_worker * termin_of_current_project) where id=current_project_id;
								
		else 
			insert into project_prices (id, name, price) values
				(current_project_id, concat('project_', current_project_id), (salary_of_worker * termin_of_current_project));
		end if; 
        
       set count_projects = count_projects + 1;
    
    end while;
    
    select name, price from project_prices;
    
    end#

delimiter ;
call show_project_prices();