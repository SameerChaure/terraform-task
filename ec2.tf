# key pair
resource "aws_key_pair" "deployer"{
               key_name = "terra-key"
               public_key = file("/home/ubuntu/terraform-project/terraform-projects/keys/terra-key.pub") 
}

# default vpc

resource "aws_default_vpc" "default"{
}

# security group

resource "aws_security_group" "terrasecure"{
             name = "allow ports"
             description = "This security group is to open port for ec2 "
             vpc_id = aws_default_vpc.default.id  # interpollation (its  means you access any resource internally using their resource type and reference name)

# inbound rule         
       ingress{
          description = "This is for ssh"
          from_port = 22
          to_port = 22
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        }

# outbound rule

    egress{
         description = "This is for outgoing traffic"
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]

     }

}

resource "aws_instance" "name"{
               ami = "ami-084568db4383264d4"
               instance_type = "t2.micro"
               key_name = aws_key_pair.deployer.key_name
               security_groups = [aws_security_group.terrasecure.name]
               tags ={
                Name = "terra-demo"
              }

}
