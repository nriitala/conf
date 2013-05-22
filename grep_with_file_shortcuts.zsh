#!/usr/bin/env zsh
function grep_with_file_shortcuts()
{
  #appendlinenumber=0
  #while getopts "v:" option
  #do
    #case $option in
      #v)
        #appendlinenumber=1
        #(( $# = $# - 1 ))
        #;;
  #esac
  #done

  if [[ "$#" -eq 1 ]]; then
    results=(${(f)"$(grep -rn $1)"} )
  else
    results=(${(f)"$(grep -rn $1 $2)"} )
  fi
  i=1
  for line in $results
  do
    echo "[$i] $line"
    if [[ $# -eq 2 && -f $2 ]]; then 
      file_path=($2(:A))
    else
      file_path=(${line%%:*}(:A))
    fi
    e="e$i"
    #v="v$i"
    #if [[ appendlinenumber -eq 1 ]]; then
      #line_number="+${${line#*:}%:*}"
      #export $v="line_number"
    #fi
    export $e="$file_path"
    (( i = i + 1 ))
  done
}


alias gg="exec_scmb_expand_args grep_with_file_shortcuts"
