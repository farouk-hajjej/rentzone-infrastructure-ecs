# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "farouk-terraform-remote-state"
    # the key is the unique name terraform we use to store our stae file
    # the best practice, name the key the same name of the projetc
    key            = "test-website-ecs.tfstate"
    region         = "us-east-1"
    profile        = "terraform-user"
  }
}