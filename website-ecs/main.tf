# Create vpc
module "create_vpc" {
    source                                              = "../modules/vpc"

    #List all of variables here
    region                                              = var.region
    project_name                                        = var.project_name
    environment                                         = var.environment
    vpc_cidr                                            = var.vpc_cidr
    public_subnet_az1_cidr                              = var.public_subnet_az1_cidr
    public_subnet_az2_cidr                              = var.public_subnet_az2_cidr
    private_app_subnet_az1_cidr                         = var.private_app_subnet_az1_cidr
    private_app_subnet_az2_cidr                         = var.private_data_subnet_az2_cidr
    private_data_subnet_az1_cidr                        = var.private_data_subnet_az1_cidr
    private_data_subnet_az2_cidr                        = var.private_data_subnet_az2_cidr

  
}


# Create Nat Gateways
module "Create_nat_gateway" {
    source                                              = "../modules/nat-gateway"

    #List all of variables here
    public_subnet_az1_id                                = module.create_vpc.public_subnet_az1_id
    internet_gateway                                    = module.create_vpc.internet_gateway
    public_subnet_az2_id                                = module.create_vpc.public_subnet_az2_id
    vpc_id                                              = module.create_vpc.vpc_id
    private_app_subnet_az1_id                           = module.create_vpc.private_app_subnet_az1_id
    private_data_subnet_az1_id                          = module.create_vpc.private_data_subnet_az1_id
    private_app_subnet_az2_id                           = module.create_vpc.private_app_subnet_az2_id
    private_data_subnet_az2_id                          = module.create_vpc.private_data_subnet_az2_id



  
}

# Create  Security groupe
module "Create_security_group" {
    source                                              = "../modules/security-groups"

    #List all of variables here
    vpc_id                                              = module.create_vpc.vpc_id
    

  
}


# Create  ECS Tasks Execution Role
module "ecs-tasks-execution-role" {
    source                                              = "../modules/ecs-tasks-execution-role"

    #List all of variables here
    project_name                                        = module.create_vpc.project_name
  
}

# Create  SSL Certificate
module "acm" {
    source                                              = "../modules/acm"

    #List all of variables here
    # var.varibalbe_name because this is a new variable
    domain_name                                         = var.domain_name
    alternative_name                                    = var.alternative_name
}


# Create  Application Load Balancer
module "application_load_balancer" {
    source                                              = "../modules/alb"

    #List all of variables here
    project_name                                        = module.create_vpc.project_name
    environment                                         = module.create_vpc.environment
    alb_security_group_id                               = module.Create_security_group.alb_security_group_id
    public_subnet_az1_id                                = module.create_vpc.public_subnet_az1_id
    public_subnet_az2_id                                = module.create_vpc.public_subnet_az2_id
    vpc_id                                              = module.create_vpc.vpc_id
    certificate_arn                                     = module.acm.certificate_arn
}