# cicd10-production1
lets do this (No, It is Wrong, see below)
1- create a parameter on all template as PipelineID
with no default value
2- use it as suffix to all name/var/tag/exported,...
3- also export it when we create S3

We Do This
only use PipelineID as parameter on last stack to be exported when it's successful
Even if we set the parameter of other stack PipelineID we should not export it in them