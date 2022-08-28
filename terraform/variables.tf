variable "instance_name" {
    description = "Value of the name tag for the EC2 instance"
    type = string
    default = "TF-Variable-App-Server-Instance"
}

variable "team" {
    description = "WizeSpace team"
    type = string
    default = "wize-space-team"
}

variable "ssh_key_name" {
    description = "App Server SSH key"
    type = string
    default = "app_server_ssh_key"
}
