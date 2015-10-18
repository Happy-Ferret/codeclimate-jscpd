http://blog.codeclimate.com/blog/2015/07/07/build-your-own-codeclimate-engine/

# Testing locally

Build docker container
```
docker build --rm -t codeclimate/codeclimate-jscpd .
```

Enable engine in .codeclimate.yml
```
engines:
  jscpd:
    enabled: true
```

Run engine
```
codeclimate analyze --dev
```
