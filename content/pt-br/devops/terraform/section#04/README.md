# Section#04

## Terraform Basic
```
# Prepare your working directory for other commands
terraform init

# Check whether the configuration is valid
terraform validate

# Show changes required by the current configuration
terraform plan
terraform plan -out myplan

# Create or update infrastructure
terraform apply
terraform apply myplan

# Destroy previously-created infrastructure
terraform destroy

terraform -version

terraform -help


find . -name .terraform -type d | xargs rm -rf {}
find . -name .terraform.lock.hcl -type f | xargs rm -rf {}
find . -name terraform.tfstate -type f | xargs rm -rf {}
```

## HCL = HashCorp Configuration Language
Terraform Code Configuration block types include:
- Terraform Settings Block
- Terraform Provider Block
- Terraform Resource Block
- Terraform Data Block
- Terraform Input Variables Block
- Terraform Output Variables Block
- Terraform Local Variables Block
- Terraform Modules Block


```
terraform -h plan
```



### Block Module

### Block Outputs
```
output "hello_worlf" {
    description =   "Print Hello World"
    value       =   "Hello World"
}


output "web_server_ip" {
    description =   "Public IP Address"
    value       =   aws_instance.webapp.public_ip
    sensitive   =   false
}
```
terraform output 
terraform output -o json


### Block Comments
```
# Single comment
// also single comment
/*
multiple line for commands
here we can jump line
ok?
*/

```

### Terraform Provider Installation and Versioning
```

```

### Using Multiple Terraform Providers
```
terraform init -upgrade
```

### Generating an SSH Key using the Terraform TLS Provider
```
```

### Fetch, Version, and Upgrade Terraform Providers
```
## Version
terraform version

## fetch
terraform init -upgrade
```

### Terraform Provisoners
```
provisioner "local-exec" {
    command = "chmod 600 ${local_file.private_key_pem.filename}"
}

provisioner "remote-exec" {
    inline = [
        "sudo rm -rf /tmp",
        "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
        "sudo sh /tmp/assets/setup-web.sh"
    ]
}



terraform state show aws_instance.ubuntu_server
```