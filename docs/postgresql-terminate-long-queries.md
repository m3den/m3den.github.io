# Postgresql terminate long active queries

```sql
select pg_terminate_backend(pid)
from pg_stat_activity
where state != 'idle' and now() - state_change > '5 minutes'::interval and usename = '<USER>'
;
```
