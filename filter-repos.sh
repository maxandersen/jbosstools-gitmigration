if [ -z "$NEWROOT" ] 
  then
    echo "NEWROOT need to be set to where repositories should be created."
  exit
fi

ORIGINAL_REPO=jbosstools-full-svn-mirror

echo Running filter_repo for each repository

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-base "^common.*|^tests.*|^runtime/.*|^usage.*"

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-server "^archives.*|^as.*|^jmx.*"

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-freemarker "^freemarker.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-hibernate "^hibernatetools.*\/"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-birt "^birt.*"

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-xulrunner "^xulrunner\/.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-jst "^jst.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-vpe "^vpe.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-forge "^forge.*"

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-javaee "^cdi.*|^jsf.*|^seam.*|^struts.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-deltacloud "^deltacloud.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-portlet "^portlet.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-webservices "^ws.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-central "^maven.*|^examples.*|^central.*"

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-documentation "^documentation.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-gwt "^gwt.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-bpel "^bpel.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-jbpm "^jbpm.*|^flow.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-runtime-soa "^runtime-soa.*"

python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-maven-plugins "^build/tycho-plugins.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-build "^build/parent.*|^build/target-platform.*|^build/target-platforms.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-build-sites "^build/aggregate.*|^build/results.*"
python filter_repo.py $ORIGINAL_REPO $NEWROOT/jbosstools-build-continous "^build/util.*|^build/emma.*|^build/jacoco.*"


python filter_tests.py $ORIGINAL_REPO $NEWROOT/jbosstools-integration-tests 

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

echo second Garbage collecting just to be sure.....
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c 'cd {} && git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now'

