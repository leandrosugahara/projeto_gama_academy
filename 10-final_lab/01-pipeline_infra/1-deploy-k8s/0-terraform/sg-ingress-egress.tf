
# resource "aws_security_group_rule" "hproxy_k8s_ingress_ssh" {
#   type              = "ingress"
#   description       = "SG rule allowing access to SSH for HPROXY SG."
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_haproxy.id
# }

# resource "aws_security_group_rule" "hproxy_k8s_ingress_masters" {
#   type             = "ingress"
#   description      = "SG rule allowing masters SG to access HPROXY SG."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_masters.id
#   security_group_id = aws_security_group.acessos_g4_haproxy.id
# }

# resource "aws_security_group_rule" "hproxy_k8s_ingress_workers" {
#   type             = "ingress"
#   description      = "SG rule allowing workers SG to access HPROXY SG."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_workers.id
#   security_group_id = aws_security_group.acessos_g4_haproxy.id
# }

# resource "aws_security_group_rule" "hproxy_k8s_egress_all" {
#   type              = "egress"
#   description       = "SG rule allowing access to external networks and Internet for HPROXY SG."
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_haproxy.id
# }

# resource "aws_security_group_rule" "master_k8s_ingress_ssh" {
#   type              = "ingress"
#   description       = "SG rule allowing access to SSH for Master SG."
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_masters.id
# }

# resource "aws_security_group_rule" "master_k8s_ingress_hproxy" {
#   type             = "ingress"
#   description      = "SG rule allowing HPROXY SG to access Master SG."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_haproxy.id
#   security_group_id = aws_security_group.acessos_g4_masters.id
# }

# resource "aws_security_group_rule" "master_k8s_egress_all" {
#   type              = "egress"
#   description       = "SG rule allowing access to external networks and Internet for Master SG."
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_masters.id
# }

# resource "aws_security_group_rule" "worker_k8s_ingress_ssh" {
#   type              = "ingress"
#   description       = "SG rule allowing access to SSH for Master SG."
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_workers.id
# }


# resource "aws_security_group_rule" "worker_k8s_ingress_masters" {
#   type             = "ingress"
#   description      = "SG rule allowing Master SG to access Worker SG."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_workers.id
#   security_group_id = aws_security_group.acessos_g4_workers.id
# }

# resource "aws_security_group_rule" "worker_k8s_ingress_hproxy" {
#   type             = "ingress"
#   description      = "SG rule allowing HPROXY SG to access Worker SG."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_haproxy.id
#   security_group_id = aws_security_group.acessos_g4_workers.id
# }

# resource "aws_security_group_rule" "worker_k8s_egress_all" {
#   type              = "egress"
#   description       = "SG rule allowing access to external networks and Internet for Worker SG."
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_workers.id
# }

# resource "aws_security_group_rule" "masters_k8s_ingress_master_main" {
#   type             = "ingress"
#   description      = "SG masters to master main."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_master_main.id
#   security_group_id = aws_security_group.acessos_g4_masters.id
# }

# resource "aws_security_group_rule" "master_main_k8s_ingress_haproxy" {
#   type             = "ingress"
#   description      = "SG master main to haproxy."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_haproxy.id
#   security_group_id = aws_security_group.acessos_g4_master_main.id
# }

# resource "aws_security_group_rule" "master_main_k8s_ingress_workers" {
#   type             = "ingress"
#   description      = "SG master main to workers."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_workers.id
#   security_group_id = aws_security_group.acessos_g4_master_main.id
# }

# # acessos_g4_masters
# # acessos_g4_master_main


################# teste #################

# resource "aws_security_group_rule" "front_k8s_ingress_ssh" {
#   type              = "ingress"
#   description       = "SG rule allowing access to SSH for Kubernetes Frontend SG."
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.sg_k8s_front.ids
# }

# resource "aws_security_group_rule" "front_k8s_ingress_http" {
#   type              = "ingress"
#   description       = "SG rule allowing access to HTTP for Kubernetes Frontend SG."
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.sg_k8s_front.id
# }

# resource "aws_security_group_rule" "front_k8s_ingress_https" {
#   type              = "ingress"
#   description       = "SG rule allowing access to HTTPS for Kubernetes Frontend SG."
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.sg_k8s_front.id
# }

# resource "aws_security_group_rule" "front_k8s_egress_all" {
#   type              = "egress"
#   description       = "SG rule allowing access to external networks and Internet for Kubernetes Frontend SG."
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.sg_k8s_front.id
# }

#### HAPROXY ####

resource "aws_security_group_rule" "hproxy_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for HPROXY SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

# resource "aws_security_group_rule" "hproxy_k8s_ingress_tcp" {
#   type              = "ingress"
#   description       = "SG rule allowing access to TCP for HPROXY SG."
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_haproxy.id
# }

resource "aws_security_group_rule" "hproxy_k8s_ingress_masters" {
  type             = "ingress"
  description      = "SG rule allowing masters SG to access HPROXY SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

resource "aws_security_group_rule" "hproxy_k8s_ingress_workers" {
  type             = "ingress"
  description      = "SG rule allowing workers SG to access HPROXY SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_workers.id
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

resource "aws_security_group_rule" "hproxy_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for HPROXY SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

#### Masters ####
resource "aws_security_group_rule" "master_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for Masters SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_masters.id
}

# resource "aws_security_group_rule" "master_k8s_ingress_tcp" {
#   type              = "ingress"
#   description       = "SG rule allowing access to TCP for Masters SG."
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_masters.id
# }

resource "aws_security_group_rule" "master_k8s_ingress_hproxy" {
  type             = "ingress"
  description      = "SG rule allowing HPROXY SG to access Masters SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_haproxy.id
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "master_k8s_ingress_masters" {
  type             = "ingress"
  description      = "SG rule allowing Master SG to access Masters SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "master_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for Masters SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_masters.id
}

#### Workers ####

resource "aws_security_group_rule" "worker_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for Workers SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_workers.id
}

# resource "aws_security_group_rule" "worker_k8s_ingress_tcp" {
#   type              = "ingress"
#   description       = "SG rule allowing access to TCP for Workers SG."
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#   security_group_id = aws_security_group.acessos_g4_workers.id
# }

resource "aws_security_group_rule" "worker_k8s_ingress_masters" {
  type             = "ingress"
  description      = "SG rule allowing Master SG to access Workers SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "worker_k8s_ingress_hproxy" {
  type             = "ingress"
  description      = "SG rule allowing HPROXY SG to access Workers SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_haproxy.id
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "worker_k8s_ingress_workers" {
  type             = "ingress"
  description      = "SG rule allowing Worker SG to access Workers SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_workers.id
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "worker_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for Worker SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_workers.id
}

# resource "aws_security_group_rule" "masters_k8s_ingress_master_main" {
#   type             = "ingress"
#   description      = "SG masters to master main."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_master_main.id
#   security_group_id = aws_security_group.acessos_g4_masters.id
# }

# resource "aws_security_group_rule" "master_main_k8s_ingress_haproxy" {
#   type             = "ingress"
#   description      = "SG master main to haproxy."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_haproxy.id
#   security_group_id = aws_security_group.acessos_g4_master_main.id
# }

# resource "aws_security_group_rule" "master_main_k8s_ingress_workers" {
#   type             = "ingress"
#   description      = "SG master main to workers."
#   from_port        = 0
#   to_port          = 0
#   protocol         = "all"
#   source_security_group_id = aws_security_group.acessos_g4_workers.id
#   security_group_id = aws_security_group.acessos_g4_master_main.id
# }

#acessos_g4_master_main
#acessos_g4_masters