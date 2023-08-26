#!/bin/bash

files_to_copy=${@:1:$#-1}

dest_dir=${@: -1}

if [ "$(hostname)" = server1 ]; then
  ssh vagrant@server2 "mkdir -p $dest_dir"
else
  ssh vagrant@server1 "mkdir -p $dest_dir"
fi

total_byes=0

for file_to_copy in ${files_to_copy[@]}; do
  file_size=$(stat -c%s "$file_to_copy")
  total_bytes=$(($total_bytes + $file_size))

  if [ "$(hostname)" = server1 ]; then
    scp -q "$file_to_copy" "server2:$dest_dir"
  else
    scp -q "$file_to_copy" "server1:$dest_dir"
  fi
done

echo "$total_bytes"
