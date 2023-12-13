# Python profiling pyinstrument

[Github](https://github.com/joerick/pyinstrument)

```bash
pip install pyinstrument
```

```python
from pyinstrument import Profiler

profiler = Profiler()
profiler.start()

# code you want to profile

profiler.stop()

profiler.print()
```

![Alt text](pyinstrument.png)