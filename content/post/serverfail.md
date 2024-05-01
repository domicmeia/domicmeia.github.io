+++
title = "Testing a simulated external server failure"
date = 2024-05-01T20:35:49+09:00
tags = ["Linux", "Troubleshooting"]
summary = "to verify that the Directory Proxy Server redirects LDAP requests appropriately."
+++
> This post was written for `studying`. There maybe a lot wrong going on.

## 목차
* [Testing external server communication](#testing-external-server-communication)
* [To run a simulated external server failure](#to-run-a-simulated-external-server-failure)

---

# Testing external server communication
---
Run the **ldapseasrch** command to test communications on the ds-central-01 serverTask.
```bash
root@proxy-east-01: bin/ldapsearch --port 389 --bindDN "cn=directory manager" \
--bindPassword password \ 
--baseDN "dc=example,dc=com,ds-backend-server=ds-central-01.example.com:389" \ 
--searchScope base "(objectclass=*)"    
```

---

# To run a simulated external server failure
---

1. Stop the `ds-east-01.example.com:389` and `ds-east-02.example.com:389` server instances and test searches through `proxy-east-01.example.com`
2. Perform several searches against the Directory Proxy Server and verify activity in each of the servers in the east location, `ds-east-01 and ds-east-02`, by looking at the access logs.

```bash
root@proxy-east-01: bin/ldapsearch --bindDN "cn=Directory Manager" \
--bindPassword password --baseDN "dc=example,dc=com" \
--searchScope base --useStartTLS "(objectclass=*)"
```

- `bin/ldapsearch`: Executes the binary file `ldapsearch`, which is used to connect to and search an LDAP server.
- `--bindDN "cn=Directory Manager"`: Specifies the Distinguished Name (DN) of the user to bind when connecting to the LDAP server. In this case, it's "cn=Directory Manager".
- `--bindPassword password`: Specifies the password to use when binding to the LDAP server. In this case, it's "password". While not recommended for security reasons, the password is provided in plain text here for convenience.
- `--baseDN "dc=example,dc=com"`: Specifies the Base DN (Distinguished Name) where the search will start. In this case, it's "dc=example,dc=com".
- `--searchScope base`: Sets the scope of the search. "Base" indicates that the search will be performed within the specified Base DN only.
- `--useStartTLS`: Establishes a secure connection using TLS (Transport Layer Security).
- `"(objectclass=*)"`: Specifies the filter for LDAP objects to search. Here, it's set to search for all objects.

3. Stop the Directory Server instance on `ds-east-01.example.com` and `ds-east-02.example.com` using the **stop-server** command and immediately retry the searches in step 2.
There should be no errors or noticeable delay in processing the search.

```bash
root@proxy-east-01: bin/stop-server

root@proxy-east-01: bin/ldapsearch \ 
--bindDN "cn=Directory Manager" --bindPassword password \ 
--baseDN "dc=example,dc=com" --searchScope base --useStartTLS \ 
"(objectclass=*)" 
```

4. Check the access log to confirm that requests made to these servers are routed to the central servers because these servers are the first failover location in the failover list for the ds-east-01 and ds-east-02 servers.
5. Restart the Directory Server instance on ds-east-01.example.com and ds-east-02.example.com.
6. Check their access logs to ensure that traffic is redirected back from the failover servers.