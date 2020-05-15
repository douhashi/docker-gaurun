# docker-gaurun

## Usage

```
docker run --name gaurun -d \
    -p 1056:1056 \
    -v `pwd`/gaurun.toml:/gaurun/conf/gaurun.toml \
    -v `pwd`/cert.pem:/gaurun/conf/cert.pem \
    -v `pwd`/key.pem:/gaurun/conf/key.pem \
    douhashi/gaurun
```

