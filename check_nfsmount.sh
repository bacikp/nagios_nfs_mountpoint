#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <nfs_mount>"
  exit 3
fi

NFS_MOUNT=${1}
CHECK_FILE=".nfs_check_file"

function check_err () {
  if [ ${RV} -eq 0 ]; then
    return
  fi
  echo "NFS mountpoint ${NFS_MOUNT} not mounted properly."
  exit 2
}

mount | grep -q ${NFS_MOUNT}
RV=${?}
check_err ${RV}

cd ${NFS_MOUNT}
RV=${?}
check_err ${RV}

if [ -f ${CHECK_FILE} ]; then
  echo "Check file ${CHECK_FILE} already exists."
  exit 1
fi

touch ${CHECK_FILE}
RV=${?}
check_err ${RV}
rm ${CHECK_FILE}

echo "NFS mountpoint ${NFS_MOUNT} mounted properly."
exit 0

