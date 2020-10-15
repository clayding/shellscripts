#!/bin/bash

SYNSETS_FILE=/root/workpoint/opencloud/imagenet/imagenet-data/imagenet_2012_train_synset_labels.txt
INPUT_PATH=/root/workpoint/opencloud/imagenet/ILSVRC2012_img_train_uncompressed_cropped/
OUTPUT_PATH=/root/workpoint/opencloud/imagenet/imagenet-data/train/

while read SYNSET; do
  echo "Processing: ${SYNSET}"

  # Create a directory and delete anything there.
  mkdir -p "${OUTPUT_PATH}/${SYNSET}"
  rm -rf "${OUTPUT_PATH}/${SYNSET}/*"

  # Uncompress into the directory.
  find ${INPUT_PATH} -name "${SYNSET}*" | xargs -i cp {} "${OUTPUT_PATH}/${SYNSET}"
  echo "Finished processing: ${SYNSET}"

done < "${SYNSETS_FILE}"
