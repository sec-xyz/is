## audit notes

### Golang
**Finding:** 
[G201/G202](https://securego.io/docs/rules/g201-g202.html) - SQL query construction using format string/string concatenation
Where: postgres/repository.go 24, postgres/repository.go 52

**Associated vulnerability**
SQL injection is one of the top security issues developers make and the consequences of this can be severe. Using the format string function in the fmt Golang package to dynamically create an SQL query can easily create a possibility for SQL injection. The reason is that the format string function doesn't escape special characters like ' and it's easy to add second SQL command in the format string.

**OWASP Top 10**

**Remediation**

### Dockerfile
Suggestion: Use arguments JSON notation for CMD and ENTRYPOINT arguments

Motivation: CMD should almost always be used in the form of CMD [“executable”, “param1”, “param2”…]
The shell form prevents any CMD or run command line arguments from being used, but has the disadvantage that your ENTRYPOINT will be started as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable will not be the container’s PID 1 - and will not receive Unix signals - so your executable will not receive a SIGTERM from docker stop .
