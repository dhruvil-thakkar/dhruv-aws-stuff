
resource "aws_directory_service_directory" "bar" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  edition  = "Standard"
  type     = "MicrosoftAD"
     
  vpc_settings {
    vpc_id     = "vpc-04a0d8740d7bf122d"
    subnet_ids = ["subnet-0cfc7a07719290654","subnet-009c3d4150783bb08"]
  }
}

resource "aws_fsx_windows_file_system" "example" {
  active_directory_id = aws_directory_service_directory.bar.id
  #kms_key_id          = aws_kms_key.example.arn
  storage_capacity    = 32
  subnet_ids          = ["subnet-0cfc7a07719290654"]
  throughput_capacity = 64
}