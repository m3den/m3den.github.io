# Odoo: How to identify user by session_id from cookie

1. Open session directory
2. `ls | grep <session_id>`
3. `less <file_...>.sess`

Example of response:

```
<80>^E<95><D0>^@^@^@^@^@^@^@}<94>(<8C>^Edebug<94><8C>^@<94><8C>^Bdb<94><8C>^DDATABASE<94><8C>^Cuid<94>M;
<8C>^Elogin<94><8C>^H<USER_LOGIN><94><8C>^Msession_token<94><8C>@11111111111111111111111111111111111111111111111111111111111111111<94><8C>^Gcontext<94>}<94>(<8C>^Dlang<94><8C>^Eru_RU<94><8C>^Btz<94><8C>^MEurope/Moscow<94><8C>^Cuid<94>M;
u<8C>^Egeoip<94>}<94>u.
```

You can use USER_LOGIN to identify user
