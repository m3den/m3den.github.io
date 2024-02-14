# Postgresql find unused indexes

```sql
SELECT
    idstat.relname AS TABLE_NAME,
    indexrelname AS index_name,
    idstat.idx_scan AS index_scans_count,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size_prt,
    pg_relation_size(indexrelid) AS index_size,
    tabstat.idx_scan AS table_reads_index_count,
    tabstat.seq_scan AS table_reads_seq_count,
    tabstat.seq_scan + tabstat.idx_scan AS table_reads_count,
    n_tup_upd + n_tup_ins + n_tup_del AS table_writes_count,
    pg_size_pretty(pg_relation_size(idstat.relid)) AS table_size_prt,
    pg_relation_size(idstat.relid) AS table_size
FROM
  pg_stat_user_indexes AS idstat
JOIN
    pg_indexes
    ON
    indexrelname = indexname
    AND
    idstat.schemaname = pg_indexes.schemaname
JOIN
    pg_stat_user_tables AS tabstat
    ON
    idstat.relid = tabstat.relid
WHERE
    indexdef !~* 'unique'
    and idstat.idx_scan = 0
ORDER BY
    pg_relation_size(indexrelid) DESC;
```

When considering candidates for deletion, you must check:

- Maybe the table is not used or planner avoids the index for some other reason?
- How much space does the index take? Maybe he is not worth the attention at the moment?
- What is the number of sequential scans of the table? You may need to add additional fields to the index to prevent sequential scans.

---

[ref](https://dmitry-naumenko.medium.com/how-to-define-unused-indexes-in-postgresql-471da6f6f33f)
