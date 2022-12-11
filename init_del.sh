#!/bin/bash
PipelineID0=`aws cloudformation list-exports \
--query "Exports[?Name=='PipelineID'].Value" --output text`

./delete.sh "xam-distro-${PipelineID0}"

aws s3 rm s3://${PipelineID0} --recursive

./delete.sh "xam-bkt-${PipelineID0}"

