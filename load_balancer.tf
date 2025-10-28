resource "aws_lb" "prod_lb" {
name = "finalexam-prod-lb"
internal = false
load_balancer_type = "application"
subnets = [aws_subnet.public.id]
security_groups = [aws_security_group.ssh_http.id]
}


resource "aws_lb_target_group" "prod_tg" {
name = "finalexam-prod-tg"
port = 80
protocol = "HTTP"
vpc_id = aws_vpc.main.id
health_check {
path = "/"
port = "80"
}
}


resource "aws_lb_listener" "prod_listener" {
load_balancer_arn = aws_lb.prod_lb.arn
port = "80"
protocol = "HTTP"
default_action {
type = "forward"
target_group_arn = aws_lb_target_group.prod_tg.arn
}
}


resource "aws_lb_target_group_attachment" "prod1" {
target_group_arn = aws_lb_target_group.prod_tg.arn
target_id = aws_instance.production1.id
port = 80
}


resource "aws_lb_target_group_attachment" "prod2" {
target_group_arn = aws_lb_target_group.prod_tg.arn
target_id = aws_instance.production2.id
port = 80
}
