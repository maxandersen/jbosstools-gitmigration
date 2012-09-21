# garbage collect
git reset --hard

# 	HEAD is now at [some commitid] [some commit message]
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all

# this might take >3 mins
git gc --aggressive --prune=now
