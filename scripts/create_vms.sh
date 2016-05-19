#!/bin/bash

NUMBER_OF_VMS="${1}"
CPUS_PER_VM="${2}"
PROJECT_NAME="brave-set-92418"
NAME_PREFIX="naspb"
MACHINE_PREFIX="n1-highmem"
SOURCE_SNAPSHOT="naspb-new-1"
DISC_SIZE="20"
ZONE="us-central1-b"

if [ -z "${NUMBER_OF_VMS}"  ] || [ -z "${CPUS_PER_VM}" ]; then
  echo "usage: ${0} NUMBER_OF_VMS CPUS_PER_VM" 1>&2
  exit 1
fi

echo "Creating ${MACHINE_PREFIX}-${CPUS_PER_VM}x${NUMBER_OF_VMS}..."
for vm_num in `seq "${NUMBER_OF_VMS}"`; do
  vm_name="${NAME_PREFIX}-${CPUS_PER_VM}-${vm_num}"
  machine_type="${MACHINE_PREFIX}-${CPUS_PER_VM}"
  gcloud compute --project "${PROJECT_NAME}" disks create "${vm_name}" --source-snapshot "${SOURCE_SNAPSHOT}" --zone "${ZONE}" --size "${DISC_SIZE}" --type "pd-ssd"
  gcloud compute --project "${PROJECT_NAME}" instances create "${vm_name}" --machine-type "${machine_type}" --zone "${ZONE}" --network "default" --disk "name=${vm_name},device-name=${vm_name},mode=rw,boot=yes,auto-delete=yes"
done
