# gc      => git checkout master
# gc bugs => git checkout bugs

function gc {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}

# Telling you from where your commit come from
function gwhere()
{
COUNT=0; while [ `where_arg $1~$COUNT | wc -w` == 0 ]; do let COUNT=COUNT+1; done; echo "$1 is ahead of "; where_arg $1~$COUNT; echo "by $COUNT commits";};function where_arg() { git log $@ --decorate -1 | head -n1 | cut -d ' ' -f3- ;
}