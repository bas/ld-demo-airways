output "launchdarkly_api_key" {
  value = launchdarkly_project.terraform.environments[0].api_key
  sensitive = true
}

output "launchdarkly_client_side_id" {
  value = launchdarkly_project.terraform.environments[0].client_side_id
  sensitive = true
}