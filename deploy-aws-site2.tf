# Create aws vpc sites for site mesh group
resource "volterra_aws_vpc_site" "aws_site2" {
  name          = format("%s-2", var.projectPrefix)
  namespace     = "system"
  aws_region    = var.aws_region

  aws_cred {
      name = "przemek-aws"
      namespace = "system"
  }

  vpc {
    vpc_id = "${aws_vpc.pg-vpc2.id}"
  }

  instance_type = var.aws_instance_type
 
  ingress_egress_gw {
    sm_connection_pvt_ip = true
    aws_certified_hw  = "aws-byol-multi-nic-voltmesh"
    dynamic "performance_enhancement_mode" {
      for_each = var.l3_mode ? [1] : []
      content {
         perf_mode_l3_enhanced = true
      }
    }

    inside_static_routes {
      static_route_list {
        simple_static_route = "10.131.1.0/24"
      }
      static_route_list {
        simple_static_route = "10.131.4.0/24"
      }
      static_route_list {
        simple_static_route = "10.131.7.0/24"
      }
    }
    az_nodes {
      aws_az_name = format("%sa", var.aws_region)    
      outside_subnet {
         existing_subnet_id = aws_subnet.pg-vpc2-outside-az-a-subnet.id
      }    
      workload_subnet {
        existing_subnet_id = aws_subnet.pg-vpc2-workload-az-a-subnet.id
      }
      inside_subnet {
        existing_subnet_id = aws_subnet.pg-vpc2-inside-az-a-subnet.id
      }
    }
    az_nodes {
      aws_az_name = format("%sb", var.aws_region)       
      outside_subnet {
         existing_subnet_id = aws_subnet.pg-vpc2-outside-az-b-subnet.id
      }    
      workload_subnet {
        existing_subnet_id = aws_subnet.pg-vpc2-workload-az-b-subnet.id
      }
      inside_subnet {
        existing_subnet_id = aws_subnet.pg-vpc2-inside-az-b-subnet.id
      }
    }
    az_nodes {
      aws_az_name = format("%sc", var.aws_region
      )       
      outside_subnet {
         existing_subnet_id = aws_subnet.pg-vpc2-outside-az-c-subnet.id
      }    
      workload_subnet {
        existing_subnet_id = aws_subnet.pg-vpc2-workload-az-c-subnet.id
      }
      inside_subnet {
        existing_subnet_id = aws_subnet.pg-vpc2-inside-az-c-subnet.id
      }
    }

    global_network_list {
      global_network_connections {
        sli_to_global_dr {
          global_vn {
            name = format("%s-gn", var.projectPrefix)
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [ labels ]
  }

  logs_streaming_disabled   = true
}

resource "volterra_cloud_site_labels" "label2" {
  name = volterra_aws_vpc_site.aws_site2.name
    site_type = "aws_vpc_site"
    labels = {
      pg-perf-label = format("%s", var.projectPrefix)
    }
  ignore_on_delete = true
}

resource "volterra_tf_params_action" "aws_site2" {
  site_name        = volterra_aws_vpc_site.aws_site2.name
  site_kind        = "aws_vpc_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = false

  depends_on = [volterra_aws_vpc_site.aws_site2]
}