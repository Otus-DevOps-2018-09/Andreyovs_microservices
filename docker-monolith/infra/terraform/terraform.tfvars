project = "infra-219714"
public_key_path = "~/.ssh/appuser.pub"
private_key_path = "~/.ssh/appuser"
disk_image = "reddit-db-base-1542196174"
count = "1"
provision_var = "0"
files_puma_service = "../files/puma.service"
files_deploy_sh = "../files/deploy.sh"
db_disk_image = "reddit-db-base-1542196174"
app_disk_image = "reddit-app-base-1542195708"
db_internal_ip = "${module.db.db_internal_ip}"
