# Linux crontab

Crontab guru - [https://crontab.guru/](https://crontab.guru/)


List crons:

```sh
crontab -l
```

Edit crons:

```sh
crontab -e
```

Example:

```bash
*/3 * * * * /scripts/script.sh
```
