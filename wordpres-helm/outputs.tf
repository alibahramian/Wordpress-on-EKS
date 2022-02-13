output "lb_ip" {
  description = "wordpress lb ip"
  value       = kubernetes_service.wordpress.load_balancer_ingress[0].hostname
}
