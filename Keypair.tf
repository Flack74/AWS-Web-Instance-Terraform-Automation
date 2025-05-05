resource "aws_key_pair" "dov-key" {
  key_name   = "dov-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOexhCGqG20a2ouClog/Rtll7tHN73C262zHGG4XpzPj flack@archlinux"
}