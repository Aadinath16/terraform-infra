

resource "google_project_service" "project_apis" {
    for_each = toset(var.api_list)
    project = var.project_id
    service = each.key
    disable_on_destroy = false
}
  
