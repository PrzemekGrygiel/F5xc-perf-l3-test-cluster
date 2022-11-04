data "aws_caller_identity" "current" {}

resource "aws_vpc_peering_connection" "peer-1-2" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.pg-vpc2.id
  #peer_region   = var.aws_region
  vpc_id        = aws_vpc.pg-vpc1.id
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
  auto_accept               = true
}

#TBD - add proper value for "var.serviceOutsideRouteTable"

#resource "aws_route" "vpc-1-outside-rt1" {
#  route_table_id            = var.serviceOutsideRouteTable
#  destination_cidr_block    = "10.2.101.0/24"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
#}
#resource "aws_route" "vpc-1-outside-rt2" {
#  route_table_id            = var.serviceOutsideRouteTable
#  destination_cidr_block    = "10.2.111.0/24"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
#}
#resource "aws_route" "vpc-1-outside-rt3" {
#  route_table_id            = var.serviceOutsideRouteTable
#  destination_cidr_block    = "10.2.121.0/24"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
#}

#resource "aws_route" "vpc-2-outside-rt1" {
#  route_table_id            = var.serviceOutsideRouteTable
#  destination_cidr_block    = "10.1.101.0/24"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
#}
#resource "aws_route" "vpc-2-outside-rt2" {
#  route_table_id            = var.serviceOutsideRouteTable
#  destination_cidr_block    = "10.1.111.0/24"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
#}
#resource "aws_route" "vpc-2-outside-rt3" {
#  route_table_id            = var.serviceOutsideRouteTable
#  destination_cidr_block    = "10.1.121.0/24"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer-1-2.id
#}


