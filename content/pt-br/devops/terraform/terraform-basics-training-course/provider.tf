terraform {
    required_providers {
        local = {
            version = "~> 2.5.0"
            source  = "hashicorp/local"
        }
    }
    
    required_version = ">= 1.0.0"
}