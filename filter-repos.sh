if [ -z "$NEWROOT" ] 
  then
    echo "NEWROOT need to be set to where repositories should be created."
  exit
fi

#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-hibernate "^hibernatetools.*|^birt.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-birt "^birt.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-base "^common.*|^tests.*|^runtime.*|^usage.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-freemarker "^freemarker.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-forge "^forge.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-deltacloud "^deltacloud.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-server "^archives.*|^as.*|^jmx.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-javaee "^cdi.*|^jsf.*|^jst.*|^seam.*|^struts.*|^vpe.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-jst "^jst.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-vpe "^vpe.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-portlet "^portlet.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-central "^maven.*|^examples.*|^central.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-webservices "^ws.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-xulrunner "^xulrunner\/.*"
#python filter_repo.py jbosstools-svn-mirror $NEWROOT/jbosstools-documentation "^documentation.*"
cd $NEWROOT
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c 'cd {} && git checkout master'
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c 'cd {} && git reset --hard && git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d && git reflog expire --expire=now --all && git gc --aggressive --prune=now'
find jbosstools-* -maxdepth 0 | xargs -n 1 -I {} bash -c "cd {} && git filter-branch --tag-name-filter cat --prune-empty -- --all"


