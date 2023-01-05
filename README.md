# docker-duoauthproxy

# docker-pocketbase
UNOFFICIAL Duo Auth Proxy Docker Image

[DuoAuthProxy](https://duo.com/docs/ldap#overview) is a LDAP proxy provided by [Duo](https://duo.com/).

DuoAuthProxy only runs on port 1636 to provide SSL communication, if SSL Key and Cert are not provided a self sign certificate is used.

## Docker Run
```bash
docker run --name duoauthproxy \
    -p 1636:1636 \
    -e CONFIG_LDAP_HOST='ldap.jumpcloud.com' \
    -e CONFIG_LDAP_SERVICE_ACCOUNT_USERNAME='username' \
    -e CONFIG_LDAP_SERVICE_ACCOUNT_PASSWORD='password' \
    -e CONFIG_LDAP_SEARCH_DN='ou=Users,o=xxxxxxxxx,dc=jumpcloud,dc=com' \
    -e CONFIG_LDAP_BIND_DN='uid=username,ou=Users,o=xxxxxxxxx,dc=jumpcloud,dc=com' \
    -e DUO_IKEY='XXXXXXXXXXXXXXXXXXXXX' \
    -e DUO_SKEY='YYYYYYYYYYYYYYYYYYYYYYYYYY' \
    -e DUO_API_HOST='api-xxxxxxxx.duosecurity.com' \
    -v <path>:/config/ \
    adobotec/duoauthproxy:latest 
```
## Docker Compose

docker-compose.example.yaml

```bash
version: '3.7'

services:
  pocketbase:
    image: adobotec/duoauthproxy:latest 
    restart: unless-stopped
    ports:
      - 1636:1636
    volumes:
      - config-vol:/config/
    environment:
      - CONFIG_LDAP_HOST='ldap.jumpcloud.com'
      - CONFIG_LDAP_SERVICE_ACCOUNT_USERNAME='username'
      - CONFIG_LDAP_SERVICE_ACCOUNT_PASSWORD='password'
      - CONFIG_LDAP_SEARCH_DN='ou=Users,o=xxxxxxxxx,dc=jumpcloud,dc=com'
      - CONFIG_LDAP_BIND_DN='uid=username,ou=Users,o=xxxxxxxxx,dc=jumpcloud,dc=com'
      - DUO_IKEY='XXXXXXXXXXXXXXXXXXXXX'
      - DUO_SKEY='YYYYYYYYYYYYYYYYYYYYYYYYYY'
      - DUO_API_HOST='api-xxxxxxxx.duosecurity.com'
volumes:
  config-vol:
```

## Environment Variables
| Variable                                | Description              | Default            |
| --------------------------------------- | ------------------------ | ------------------ |
| CONFIG_DEBUG                            | Duo LDAP Proxy Debug     | false              |
| CONFIG_LDAP_HOST                        | LDAP Host                | REQUIRED           |
| CONFIG_LDAP_SERVICE_ACCOUNT_USERNAME    | LDAP Service Username    | REQUIRED           |
| CONFIG_LDAP_SERVICE_ACCOUNT_PASSWORD    | LDAP Service Password    | REQUIRED           |
| CONFIG_LDAP_SEARCH_DN                   | LDAP Search DN           | REQUIRED           |
| CONFIG_LDAP_BIND_DN                     | LDAP Service Usernane DN | REQUIRED           |
| CONFIG_LDAP_SSL_VERIFY                  | LDAP SSL Verify          | true               |
| CONFIG_LDAP_TRANSPORT                   | LDAP Transport           | ldaps              |
| CONFIG_LDAP_AUTH_TYPE                   | LDAP Auth Type           | plain              |
| CONFIG_LDAP_PORT                        | LDAP Port                | 636                |
| CONFIG_LDAP_HOST_2                      | LDAP Extra Host 2        | OPTIONAL           |
| CONFIG_LDAP_HOST_3                      | LDAP Extra Host 3        | OPTIONAL           |
| CONFIG_LDAP_HOST_4                      | LDAP Extra Host 4        | OPTIONAL           |
| CONFIG_LDAP_HOST_5                      | LDAP Extra Host 5        | OPTIONAL           |
| DUO_IKEY                                | DUO IKEY                 | REQUIRED           |
| DUO_SKEY                                | DUO SKEY                 | REQUIRED           |
| DUO_API_HOST                            | DUO API HOST             | REQUIRED           |
| CONFIG_EXEMPT_PRIMARY_BIND              | Exempt Primary Bind      | false              |
| CONFIG_EXEMPT_OU_1                      | Exempt OU 1              | OPTIONAL           |
| CONFIG_EXEMPT_OU_2                      | Exempt OU 2              | OPTIONAL           |
| CONFIG_EXEMPT_OU_3                      | Exempt OU 3              | OPTIONAL           |
| CONFIG_EXEMPT_OU_4                      | Exempt OU 4              | OPTIONAL           |
| CONFIG_ALLOW_UNLIMITED_BINDS            | Allow Unlimited Binds    | true               |
| CONFIG_FAILMODE                         | Failmode                 | safe               |
| SSL_SELF_SIGN                           | Self Sign Cert Proxy     | true               |