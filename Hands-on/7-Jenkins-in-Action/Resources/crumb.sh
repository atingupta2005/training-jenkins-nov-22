crumb=$(curl -u "jenkins:1234" -s 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
echo $crumb
curl -u "jenkins:1234" -H "$crumb" -X POST http://vmjenkins.northeurope.cloudapp.azure.com:8080/job/Day%202-CICD-1/build?delay=0sec
curl -u "jenkins:1234" -H "$crumb" -X POST http://vmjenkins.northeurope.cloudapp.azure.com:8080/job/day1-parameterized/buildWithParameters?P_Name=Atin
