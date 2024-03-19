# Postgresql disk/cache hit rate per table


```sql
with all_tables as (
    select  *
    from (
        select  'all'::text as table_name,
            sum((coalesce(heap_blks_read,0) + coalesce(idx_blks_read,0) + coalesce(toast_blks_read,0) + coalesce(tidx_blks_read,0))) as from_disk,
            sum((coalesce(heap_blks_hit,0) + coalesce(idx_blks_hit,0) + coalesce(toast_blks_hit,0) + coalesce(tidx_blks_hit,0))) as from_cache
        from pg_statio_all_tables  --> change to pg_statio_USER_tables if you want to check only user tables (excluding postgres's own tables)
    ) all_tables_subquery
    where (from_disk + from_cache) > 0 -- discard tables without hits
),
tables as (
    select  *
    from (
        select  relname as table_name,
            ((coalesce(heap_blks_read,0) + coalesce(idx_blks_read,0) + coalesce(toast_blks_read,0) + coalesce(tidx_blks_read,0)) ) as from_disk,
            ((coalesce(heap_blks_hit,0)  + coalesce(idx_blks_hit,0)  + coalesce(toast_blks_hit,0)  + coalesce(tidx_blks_hit,0))  ) as from_cache
        from pg_statio_all_tables --> change to pg_statio_user_tables if you want to check only user tables (excluding postgres's own tables)
        ) tables_subquery
    where (from_disk + from_cache) > 0 -- discard tables without hits
)
select table_.table_name as "table name",
    table_.from_disk as "disk hits",
    round((table_.from_disk::numeric / (table_.from_disk + table_.from_cache)::numeric)*100.0, 2) as "% disk hits",
    round((table_.from_cache::numeric / (table_.from_disk + table_.from_cache)::numeric)*100.0, 2) as "% cache hits",
    (table_.from_disk + table_.from_cache) as "total hits",
    round(((table_.from_disk::numeric / (all_tables_.from_disk)::numeric)) * 100.0, 2) as "% of total disk hits"
from tables as table_
cross join all_tables as all_tables_
order by table_.from_disk desc;
```
