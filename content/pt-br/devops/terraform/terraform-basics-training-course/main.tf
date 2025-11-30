resource "local_file" "pet" {
    filename = "${path.module}/pet.txt"
    content  = "This is a local file created by Terraform."
    file_permission = "0700"
}