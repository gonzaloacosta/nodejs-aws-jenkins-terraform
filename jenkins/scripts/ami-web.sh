cd terraform
ARTIFACT_WEB=`packer build -machine-readable packer-ami-web.json  |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID_WEB=`echo $ARTIFACT_WEB | cut -d ':' -f2`
echo 'variable "WEB_INSTANCE_AMI" { default = "'${AMI_ID_WEB}'" }' > amivar_web.tf
aws s3 cp amivar_web.tf s3://node-aws-jenkins-terraform-202103111200/amivar_web.tf
