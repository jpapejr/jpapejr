Switch your Flask run command from 

```
if __name__ == '__main__':
    app.run(debug=False/True)
```

to 

```
from werkzeug.serving import run_simple
run_simple('<HOST>', <PORT>, app)
```

and you'll be able to debug properly from Jupyter Lab's debugger
