resource "aws_s3_bucket" "s3" {
    bucket = "devopsart-terraform-101"

    tags = {
        Name = "devopsart-terraform-101"
    }
}