output "cluster_name" {
value = google_container_cluster.primary.name
}


output "kube_endpoint_private" {
value = google_container_cluster.primary.private_cluster_config[0].private_endpoint
}

