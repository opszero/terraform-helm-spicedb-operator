provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

module "spicedb-operator" {
  source         = "./../"
  name           = "test"
  instance_class = "db.t3.micro"
  vpc_id         = "vpc-0a443368cc8b9a149" # add vpc id here
  subnet_ids     = ["subnet-03be56fd3c2156912", "subnet-0530b0a32e9b8b573"]
  password       = "jhcjsahcjqKDJ35XJHNN"
  allowed_ip     = ["0.0.0.0/0"]
  preshared_key  = "cnkcASMcisdkfiwujcf9IR"
}
