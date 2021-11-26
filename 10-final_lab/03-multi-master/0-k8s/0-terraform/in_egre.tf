#regras para haproxy
resource "aws_security_group_rule" "leandromiranda_sgr_haproxy_1" {
  type              = "ingress"
  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_haproxy_2" {
  type             = "ingress"
  description      = "Master 1 acessa haproxy"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_master_main.id
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_haproxy_3" {
  type             = "ingress"
  description      = "Masters 2 e 3 acessam haproxy"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_haproxy_4" {
  type             = "ingress"
  description      = "Workers acessam haproxy"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_workers.id
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_haproxy_5" {
  type              = "egress"
  description       = "Acesso a internet"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_haproxy.id
}

#regras para master 1
resource "aws_security_group_rule" "leandromiranda_sgr_master_1_1" {
  type              = "ingress"
  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_master_main.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_1_2" {
  type             = "ingress"
  description      = "Haproxy acessa master 1"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_haproxy.id
  security_group_id = aws_security_group.acessos_g4_master_main.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_1_3" {
  type             = "ingress"
  description      = "Masters 2 e 3 acessam master 1"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_master_main.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_1_4" {
  type             = "ingress"
  description      = "Workers acessam master 1"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_workers.id
  security_group_id = aws_security_group.acessos_g4_master_main.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_1_5" {
  type              = "egress"
  description       = "Acesso a internet"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_master_main.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_1_6" {
  type             = "ingress"
  description      = "Referencia circular"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_master_main.id
  security_group_id = aws_security_group.acessos_g4_master_main.id
}

#regras para master 2 e 3
resource "aws_security_group_rule" "leandromiranda_sgr_master_2_1" {
  type              = "ingress"
  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_2_2" {
  type             = "ingress"
  description      = "Haproxy acessa master 2 e 3"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_haproxy.id
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_2_3" {
  type             = "ingress"
  description      = "Master 1 acessa masters 2 e 3"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_master_main.id
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_2_4" {
  type             = "ingress"
  description      = "Workers acessam master 2 e 3"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_workers.id
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_2_5" {
  type              = "egress"
  description       = "Acesso a internet"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_masters.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_master_2_6" {
  type             = "ingress"
  description      = "Referencia circular"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_masters.id
}

#regras para workers
resource "aws_security_group_rule" "leandromiranda_sgr_workers_1" {
  type              = "ingress"
  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_workers_2" {
  type             = "ingress"
  description      = "Haproxy acessa workers"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_haproxy.id
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_workers_3" {
  type             = "ingress"
  description      = "Master 1 acessa workers"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_master_main.id
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_workers_4" {
  type             = "ingress"
  description      = "Masters 2 e 3 acessam workers"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_g4_masters.id
  security_group_id = aws_security_group.acessos_g4_workers.id
}

resource "aws_security_group_rule" "leandromiranda_sgr_workers_5" {
  type              = "egress"
  description       = "Acesso a internet"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.acessos_g4_workers.id
}
