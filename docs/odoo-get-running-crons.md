# Odoo get running crons (ir.cron)

```sql
with active_cron_info as (  
   select substring(query from 'id in \((\d+)\)')::int as cron_id,  
          query,  
          pid as pid,  
          usename as username,  
          application_name as app_name,  
          client_addr as client_addr,  
          state as state,  
          now() at time zone 'utc' - state_change at time zone 'utc' as time  
   from pg_catalog.pg_stat_activity  
   where query ilike '%ir_cron%FOR NO KEY UPDATE SKIP LOCKED%'  
)  
select  
      cron.id,  
      cron.cron_name,  
       cron_info.time,  
       cron_info.username,  
       cron_info.app_name,  
       cron_info.client_addr,  
       cron_info.state,  
       cron_info.pid  
from ir_cron as cron  
inner join active_cron_info as cron_info  
    on cron_info.cron_id = cron.id;
```