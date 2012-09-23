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

xargs -n 1 -I {} curl -u "$GITHUBUSER:$GITHUBPWD" https://api.github.com/$GHROOT -d '{"name":"scratch-{}", "description":"scratch test repo for {} svn-git migration"}' 
