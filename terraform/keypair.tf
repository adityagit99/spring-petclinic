
resource "tls_private_key" "generatekey" {
algorithm =   "RSA"
rsa_bits = 2048
}

resource "aws_key_pair" "deploy-pub-key" {
  key_name   = "deployer-key"
  public_key =  tls_private_key.generatekey.public_key_pem

}

resource "local_file" "deploy-pri-key" {
  content = tls_private_key.generatekey.private_key_pem
  filename = "deploykey.pem"
  }