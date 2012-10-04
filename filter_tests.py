#!/usr/bin/env python

import sys
from git_fast_filter import Blob, Reset, FileChanges, Commit, FastExportFilter
from git_fast_filter import get_commit_count, get_total_objects
import re
import datetime

if len(sys.argv) != 3:
  raise SystemExit("Syntax:\n  %s SOURCE_REPO TARGET_REPO")
source_repo = sys.argv[1]
target_repo = sys.argv[2]
regexp = re.compile('^[^/]*/[^/]*/[^/]*\.bot.*')

start = datetime.datetime.now()

total_objects = get_total_objects(source_repo)  # blobs + trees
total_commits = get_commit_count(source_repo)
object_count = 0
commit_count = 0

def print_progress():
  global object_count, commit_count, total_objects, total_commits
  print "\rRewriting commits... %d/%d  (%d objects)" \
        % (commit_count, total_commits, object_count),

def my_blob_callback(blob):
  global object_count
  object_count += 1
  print_progress()
  
def my_commit_callback(commit):
  global commit_count
  commit_count += 1
  print_progress()
  new_file_changes = []
  for change in commit.file_changes:
      if regexp.match(change.filename):
        change.filename = re.sub('^[^/]*/[^/]*/org','tests/org',change.filename)
        new_file_changes.append(change)
        #print commit.branch + ":" + change.filename

  commit.file_changes = new_file_changes
  
filter = FastExportFilter(blob_callback   = my_blob_callback,
                          commit_callback = my_commit_callback)
filter.run(source_repo, target_repo)

end = datetime.datetime.now()

print "End : " + str(end-start)

