# Postgresql find broken files

```sql
with d0 as (
     select oid from pg_database where datname=current_database()
), d1 as (
select pg_ls_dir as fn,
   regexp_match(pg_ls_dir, '^([0-9]+)(.*)$') as match
from d0, pg_ls_dir('base/'||d0.oid)
order by 1
),
d2 as (
select fn, match[1] as base, match[2] as ext
from d1
where (fn NOT ILIKE 'pg_%')
),
d3 as (
select d.*,  pg_filenode_relation(0, base::oid) as relation
from d2 d
)
select fn, pg_size_pretty((pg_stat_file('base/'||d0.oid||'/'||fn)).size),(pg_stat_file('base/'||d0.oid||'/'||fn)).size
from d0, d3
where relation is null;
```

[ref](https://www.postgresql.org/message-id/4ae62ff0-f33e-2a26-79ff-dcaa39ee92ff%40erven.at)