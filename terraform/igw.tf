resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "atlas-igw"
    Project     = "Atlas Platform"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}