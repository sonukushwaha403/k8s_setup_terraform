provider "aws" {
  region       =  "ap-south-1"
  profile      =  "default"
}

#launching ec2 instance for master
resource "aws_instance" "Master" {
  ami           =  "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  security_groups= [ "all-49" ]
  key_name= "terraform_key"

  tags = {
    Name = "sonu@k8s_masterTF"
  }
 connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/Sonu/Downloads/terraform_key.pem")
    host     = aws_instance.Master.public_ip
  }
  

  provisioner "file" {
    source      = "C:/Users/Sonu/OneDrive/Desktop/iiec/kubernetestf/script/"
    destination = "/home/ec2-user"
  }
  
  provisioner "remote-exec" {
    inline = [
       "sudo mv * /root" 
    ]
  }
}



resource "null_resource" "null1" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/Sonu/Downloads/terraform_key.pem")
    host     = aws_instance.Master.public_ip
  }
   

  provisioner "remote-exec" {
    inline = [
       "sudo bash /root/master.sh" 
    ]
  }
}

#launching ec2 instance for worker
resource "aws_instance" "worker1" {
  ami           =  "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  security_groups= [ "all-49" ]
  key_name= "terraform_key"

  tags = {
    Name = "sonu@k8s_workerTF"
  }
 connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/Sonu/Downloads/terraform_key.pem")
    host     = aws_instance.worker1.public_ip
  }
  

  provisioner "file" {
    source      = "C:/Users/Sonu/OneDrive/Desktop/iiec/kubernetestf/script/"
    destination = "/home/ec2-user"
  }
  
  provisioner "remote-exec" {
    inline = [
       "sudo mv * /root" 
    ]
  }
}



resource "null_resource" "null2" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/Sonu/Downloads/terraform_key.pem")
    host     = aws_instance.worker1.public_ip
  }
   

  provisioner "remote-exec" {
    inline = [
       "sudo bash /root/worker.sh" 
    ]
  }
}


