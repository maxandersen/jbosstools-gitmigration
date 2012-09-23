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
export GHROOT=${GITHUB_ROOT:-user/repos}
# create in jbosstools organization
#export GITHUB_ROOT orgs/jbosstools/repos

JSON="{\"name\":\"scratch-$1\", \"description\":\"scratch test repo for $1 svn-git migration\"}"
curl -u "$GITHUBUSER:$GITHUBPWD" https://api.github.com/$GHROOT -d "$JSON"