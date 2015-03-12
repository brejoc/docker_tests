# Docker integration tests

This is a work in progress. Right there is just one rspec file, that will make sure the docker image has port 80 mapped to the local port 8080 and that port 8080 is indeed accessible.

# Dependencies

Of couse you'll need to install docker. Furthermore you'll need rspec and [docker-api](https://rubygems.org/gems/docker-api).

# Usage

Make sure that you have installed the dependencies and that docker is started: `service docker start`

You can exceute the test with this simple command:
```bash
rspec http_port/*
```
If your output looks like this, everything is fine:
```bash
...

Finished in 2.49 seconds (files took 0.27064 seconds to load)
3 examples, 0 failures

```
