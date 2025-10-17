# docker-unifi-api-browser

A Dockerfile and continer build for unifi browser <https://github.com/Art-of-WiFi/UniFi-API-browser>

<!-- BADGIE TIME -->
<!-- END BADGIE TIME -->

[![Source Code](https://img.shields.io/badge/source-GitHub-blue.svg?style=flat)](https://github.com/interoperable/dockerfile-unifi-api-browser)
[![GitHub License](https://img.shields.io/github/license/interoperable/dockerfile-unifi-api-browser)](./License)
![Github last-commit](https://img.shields.io/github/last-commit/interoperable/dockerfile-unifi-api-browser)
![01_lint_dockerfile workflow](https://github.com/interoperable/dockerfile-unifi-api-browser/actions/workflows/01_lint_dockerfile.yml/badge.svg?label=build&style=flat-square&branch=main)
![02_release_please workflow](https://github.com/interoperable/dockerfile-unifi-api-browser/actions/workflows/02_release_please.yml/badge.svg?label=build&style=flat-square&branch=main)
![03_ci workflow](https://github.com/interoperable/dockerfile-unifi-api-browser/actions/workflows/03_ci.yml/badge.svg?label=build&style=flat-square&branch=main)
![nightly](https://github.com/interoperable/dockerfile-unifi-api-browser/actions/workflows/nightly.yml/badge.svg?label=build&style=flat-square&branch=main)
[![Latest version](https://img.shields.io/github/tag/interoperable/dockerfile-unifi-api-browser.svg?label=release&style=flat&maxAge=3600)](https://github.com/interoperable/dockerfile-unifi-api-browser/tags)
[![GitHub issues](https://img.shields.io/github/issues/interoperable/dockerfile-unifi-api-browser.svg)](https://github.com/interoperable/dockerfile-unifi-api-browser/issues)
![Github stars](https://badgen.net/github/stars/interoperable/dockerfile-unifi-api-browser?icon=github&label=stars)
[![GitHub forks](https://img.shields.io/github/forks/interoperable/dockerfile-unifi-api-browser.svg)](https://github.com/interoperable/dockerfile-unifi-api-browser/network)
![Github forks](https://badgen.net/github/forks/interoperable/dockerfile-unifi-api-browser?icon=github&label=forks)

[![Docker Pulls](https://badgen.net/docker/pulls/interoperable/unifi-api-browser?icon=docker&label=pulls)](https://hub.docker.com/r/interoperable/unifi-api-browser)
[![Docker pulls](https://img.shields.io/docker/pulls/interoperable/unifi-api-browser.svg?style=plastic)](https://hub.docker.com/r/interoperable/unifi-api-browser)
[![Docker Stars](https://badgen.net/docker/stars/interoperable/unifi-api-browser?icon=docker&label=stars)](https://hub.docker.com/r/interoperable/unifi-api-browser/)
[![Docker Image Size](https://badgen.net/docker/size/interoperable/unifi-api-browser?icon=docker&label=image%20size)](https://hub.docker.com/r/interoperable/unifi-api-browser/)
[![Docker Automated build](https://img.shields.io/docker/automated/interoperable/unifi-api-browser.svg)](https://hub.docker.com/v2/repositories/interoperable/unifi-api-browser/autobuild/)
[![Docker pulls](https://img.shields.io/docker/pulls/interoperable/unifi-api-browser.svg?style=plastic)](https://registry.hub.docker.com/v2/repositories/interoperable/unifi-api-browser/)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/interoperable/dockerfile-unifi-api-browser/issues)


Includes support for UniFiOS on UDMP - see note on ports

The API Browser lets you pull raw, JSON formatted data from the API running on your controller.

## Required Environment Variables
 To run this container you will need to define the following variables:

|Environment Variable|Default|Explanation|
|---|---|---|
|USER|Your unifi username|Your username on unifi console - consider creating a restricted user|
|PASSWORD|Your unifi password|clear text unifi password|
|UNIFIURL|https://192.168.1.1|URL to your controller *without* the port or trailing / on the URL|
|PORT|443|Port if you changed the port unifi is running on - default env var setting 443 is now the default for UDM / UDMP for older UniFiOS based controllers change to 8443 controllers|
|DISPLAYNAME|My Site Name|Arbitrary name you want to refer to this site as in API Browser|
|NOAPIBROWSERAUTH|0| use to disable browser auth|
|APIBROWSERUSER|admin|username to secure the API Browser instance|
|APIBROWSERPASS|see note|Note: Generate a SHA512 of the password you want and put here, you can use a tool like https://abunchofutils.com/u/computing/sha512-hash-calculator/ by default the password is 'admin' i.e. c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec|

## Getting Running
To get started this is the minimum number of options, be sure to append each envar with the required text (esp the SHA512):

`docker run --name unifiapibrowser -p:8000:8000 -e USER= -e PASSWORD= -e UNIFIURL= -e APIBROWSERPASS=    scyto/unifibrowser`

This will run the container on host port 8000/tcp.

## Using Docker Compose / Stack

This is the fastest way to get running for unifios and doesn't require the use of the hash
```
version: '3.8'
services:
  unifi-api-browser:
    ports:
    - 8010:8000
    environment:
      USER: unifi console local account 
      PASSWORD: unifi console password
      NOAPIBROWSERAUTH: 1 # disables auth to apibrowser
      UNIFIURL: https://192.168.1.1
      PORT: 443
      DISPLAYNAME: Home
    image: interoperable/unifi-api-browser
 ```   

## Using Multiple Unifi Controllers

Unifi-API-Browser supports multiple controllers.  To use them copy the users.php and config.php into a host directory and the map them into the container with the additional following command line options:

`-v <YourHostPath>/config.php:/UniFi-API-browser/config/config.php` 

and

`-v <YourHostPath>/config.php:/UniFi-API-browser/config/users.php`

Editing these files is beyond the scope of this readme.md but both contain good instructions

### Feedback
If you find any issues please log them at the github repo https://github.com/interoperable/docker-unifi-api-browser/issues
