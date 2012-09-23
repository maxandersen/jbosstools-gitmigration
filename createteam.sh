## script which creates a team under jbosstools

if [ -z "$GITHUBUSER" ] 
  then
    echo "GITHUBUSER need to be set."
  exit
fi

if [ -z "$GITHUBPWD" ] 
  then
    echo "GITHUBPWD need to be set."
  exit
fi

curl -u "$GITHUBUSER:$GITHUBPWD" https://api.github.com/orgs/jbosstools/teams -d '{"name":"$1", "permission":"push" }'