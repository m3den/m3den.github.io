# Postgresql active queries

```sql
select query, now() - state_change, usename, pid, state, * 
from pg_stat_activity 
where state != 'idle' 
order by now() - state_change desc;
```