terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "VPC_1" {
  cidr_block = "172.16.0.0/26"
}

resource "aws_vpc" "VPC_2" {
  cidr_block = "10.0.0.0/26"
}

resource "aws_subnet" "VPC_1_SUBNET" {
  vpc_id = aws_vpc.VPC_1.id
  cidr_block = "172.16.0.0/26"
}

resource "aws_subnet" "VPC_2_SUBNET" {
  vpc_id = aws_vpc.VPC_2.id
  cidr_block = "10.0.0.0/26"
}

resource "aws_internet_gateway" "CUSTOM_INTERNET_GATEWAY" {
  
}

resource "aws_route" "VPC_1_ROUTE_TABLE" {
  route_table_id = aws_vpc.VPC_1.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.CUSTOM_INTERNET_GATEWAY
}

resource "aws_route" "VPC_2_ROUTE_TABLE" {
  route_table_id = aws_vpc.VPC_2.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.CUSTOM_INTERNET_GATEWAY
}

resource "aws_vpc_peering_connection" "VPC_1_TO_VPC_2" {
  vpc_id = aws_vpc.VPC_1.id
  peer_vpc_id = aws_vpc.VPC_2.id
}

resource "aws_instance" "VPC_1_INSTANCE" {
  ami = "ami-04c0ab8f1251f1600"
  instance_type = "t2.micro"
  key_name = "keyPairOregon"
}

resource "aws_instance" "VPC_2_INSTANCE" {
  ami = "ami-04c0ab8f1251f1600"
  instance_type = "t2.micro"
  key_name = "keyPairOregon"
}



