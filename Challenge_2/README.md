We can call the Azure API from the isntace using any script(Bash/PS) to get the data -

Example(Bash) : 
```
#!/bin/bash

sudo apt-get install curl
sudo apt-get install jq

host_url="http://169.254.169.254/"
query_param="api-version=2021-02-01&format=json"

# Take endpoint as user input

printf "Choose endpoint - \n 1: /metadata/attested \n 2: /metadata/identity \n 3: /metadata/instance \n 4: /metadata/loadbalancer  \n 5: /metadata/scheduledevents \n\nYour Choice:  " 
read scase

case $case in
1)
endpoint="/metadata/attested"
;;

2)
endpoint="/metadata/identity"
;;

3)
endpoint="/metadata/instance"
;;

4)
endpoint="/metadata/loadbalancer"
;;

5)
endpoint="/metadata/scheduledevents"
;;

*)
endpoint="/metadata/versions"
;;
esac

# Build calling URL
calling_url=$host_url$endpoint"?"$query_param

# Instance call
curl -H Metadata:True --noproxy "*" $calling_url | jq .
```
