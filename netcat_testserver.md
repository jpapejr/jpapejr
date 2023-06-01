`netcat` can be used to setup a small, easily available http server for smoke-testing networks since we
cannot always trust ICMP-based methods.

**Step 1**

Create a file called `index.http` with the following contents: 

```
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Server: netcat!

<!doctype html>
<html><body><h1>A webpage served by netcat</h1></body></html>
```


**Step 2**

Run the following command in your terminal. Make sure you run it from the same location/directory where you
saved the file you created in `Step 1`. 

`while true; do cat index.http | nc -l 8000; done`



Now you should be able to issue `curl` commands or browser requests to test connectivity to your target host:port
where the `netcat` server is listening.
