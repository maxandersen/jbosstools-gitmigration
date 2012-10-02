## this will treat $1 as a repository and go through it and delete all branches and tags with empty content.

export GIT_DIR=$1/.git
export GIT_WORK_TREE=$1

echo Looking for empty branches in $1
git branch | while read BRANCH
do
 REALBRANCH=`echo "$BRANCH" | sed -e 's/\*//g'`
 NOFILES=`git ls-tree $REALBRANCH | wc -l | tr -d ' '`
# echo $NAME "$REALBRANCH" $NOFILES
 if [[ "$NOFILES" == "0" ]]
  then
     git branch -D $REALBRANCH 
  fi
done

git tag | while read BRANCH
do
 REALBRANCH=`echo "$BRANCH" | sed -e 's/\*//g'`
 NOFILES=`git ls-tree $REALBRANCH | wc -l | tr -d ' '`
# echo $NAME "$REALBRANCH" $NOFILES
 if [[ "$NOFILES" == "0" ]]
  then
     git tag -d $REALBRANCH 
  fi
done