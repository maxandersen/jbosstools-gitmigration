if [ -z "$NEWROOT" ] 
  then
    echo "NEWROOT need to be set to where repositories should be created."
  exit
fi

echo Running filter_repo for each repository

python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-hibernate "^hibernatetools.*\/"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-birt "^birt.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-base "^common.*|^tests.*|^runtime.*|^usage.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-freemarker "^freemarker.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-forge "^forge.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-deltacloud "^deltacloud.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-server "^archives.*|^as.*|^jmx.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-javaee "^cdi.*|^jsf.*|^jst.*|^seam.*|^struts.*|^vpe.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-jst "^jst.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-vpe "^vpe.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-portlet "^portlet.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-central "^maven.*|^examples.*|^central.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-webservices "^ws.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-xulrunner "^xulrunner\/.*"
python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-documentation "^documentation.*"
python filter_tests.py jbosstools-svn-mirror $NEWROOT/jbosstools-integration-tests 

cd $NEWROOT

echo Checking out master.....
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c 'cd {} && git checkout master'

echo Garbage collecting.....
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c 'cd {} && git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now'

echo Removing empty commits....
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c "cd {} && git filter-branch --tag-name-filter cat --prune-empty -- --all"

#creating dir to make it not be filtered.
mkdir $NEWROOT/jbosstools-integration-tests/site

echo subdirectory filter for repo with just one root directory....
find jbosstools-* -type d -maxdepth 0 -links 4 -exec bash -c "cd {} && pwd &&  git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter * -f -- --all" \;

echo (second) Garbage collecting just to be sure.....
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c 'cd {} && git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now'

