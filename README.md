# cicd10-production1
lets do this (No, It is Wrong, see below)
1- create a parameter on all template as PipelineID
with no default value
2- use it as suffix to all name/var/tag/exported,...
3- also export it when we create S3

We Do This
only use PipelineID as parameter on last stack to be exported when it's successful
Even if we set the parameter of other stack PipelineID we should not export it in them

Export with name PipelineID is already exported by stack xam-distro-474608141926. Rollback requested by user.

Seems we have to keep same distro-stack-name forand update the PipelineID
distro is last stack
if its update failed will stay the same
so we only need to depend on stack update for distro if successful then it has new PipelineID
,...
also sample CIRCLE_WORKFLOW_ID 878feef3-5126-4468-957e-6c2bcedf454f
too long we will get first parts ${CIRCLE_WORKFLOW_ID:0:7}