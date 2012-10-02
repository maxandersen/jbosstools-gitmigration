## script which creates a repo 

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

# create in own user
#export GHROOT=${GITHUB_ROOT:-user/repos}
# create in jbosstools organization
export GHROOT=orgs/jbosstools/repos

JSON="{\"name\":\"$1\", \"description\":\"$2 repo for $1 svn-git migration\"}"
curl -u "$GITHUBUSER:$GITHUBPWD" https://api.github.com/$GHROOT -d "$JSON"

#delete repos
#find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} curl -u "maxandersen:$GITHUBPWD" https://api.github.com/repos/maxandersen/temp-{} -X DELETE