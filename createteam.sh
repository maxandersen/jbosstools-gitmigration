## script which creates a team under jbosstools
curl -u "maxandersen:$GITHUBPWD" https://api.github.com/orgs/jbosstools/teams -d '{"name":"$1", "permission":"push" }'