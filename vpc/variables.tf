variable "AWS_REGION" {
    default = "us-east-1"
}

variable "ami" {
    type = map 

    default = {
        us-east-1 = "ami-09d3b3274b6c5d4aa"
    }
}

variable "public_key" {
    default = "~/.ssh/id_github_rsa.pub"
}

variable "private_key" {
    default = "~/.ssh/id_github_rsa"
}

variable "instance_types" {
    type = list(any)
    default = ["t2.micro", "t2.nano", "t2.small"]
}