
### Variables for interacting with GitHub API
#export GITHUBPWD=
export GITHUBUSER=maxandersen


### Python setup for fastfilter
export PYTHONPATH=$(pwd)/git_fast_filter/:$PYTHONPATH
echo $PYTHONPATH

### 
export PATH=$(pwd):$PATH
echo $PATH

### Root dir where the resulting repositories will be
export NEWROOT=/Volumes/Photos/gits
