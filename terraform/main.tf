terraform {
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "~> 2.0"
    }
  }
}

provider "launchdarkly" {
  access_token = var.access_token
}

resource "launchdarkly_project" "terraform" {
  key  = var.project
  name = var.project

  environments {
    key   = "development"
    name  = "Development"
    color = "2DA44E"
    tags  = ["terraform"]
  }

  environments {
    key   = "production"
    name  = "Production"
    color = "BE3455"
    tags  = ["terraform"]
    approval_settings {
      can_review_own_request     = false
      can_apply_declined_changes = false
      min_num_approvals          = 1
      required_approval_tags     = ["approvals-required"]
    }
  }

  tags = [
    "terraform"
  ]

  default_client_side_availability {
    using_environment_id = true
    using_mobile_key     = false
  }
}

resource "launchdarkly_feature_flag" "enable_fast_cache" {
  project_key = launchdarkly_project.terraform.key
  key         = "enableFastCache"
  name        = "Enable Fast Cache"
  description = "This flag controls the use of the fast cache"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Available"
    description = "Enables the fast cache"
  }
  variations {
    value       = "false"
    name        = "Unavailable"
    description = "Disables the fast cache"
  }

  defaults {
    on_variation  = 0
    off_variation = 1
  }

  tags = [
    "terraform",
  ]
}

resource "launchdarkly_feature_flag" "flight_db" {
  project_key = launchdarkly_project.terraform.key
  key         = "flightDb"
  name        = "Select flight database"
  description = "This flag controls the flight database selection"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Postgres"
    description = "Enable the Postgres flight database"
  }
  variations {
    value       = "false"
    name        = "Redis"
    description = "Enable the Redis flight database"
  }

  defaults {
    on_variation  = 0
    off_variation = 1
  }

  tags = [
    "terraform",
  ]
}

resource "launchdarkly_feature_flag" "launch_club_loyalty" {
  project_key = launchdarkly_project.terraform.key
  key         = "launchClubLoyalty"
  name        = "Launch Club Loyalty"
  description = "This flag controls the visibility of the Launch Club loyalty program"

  variation_type = "boolean"
  variations {
    value       = "true"
    name        = "Available"
    description = "Enables the Launch Club loyalty program"
  }
  variations {
    value       = "false"
    name        = "Unavailable"
    description = "Disables the Launch Club loyalty program"
  }

  defaults {
    on_variation  = 0
    off_variation = 1
  }

  tags = [
    "terraform",
  ]
}

resource "launchdarkly_metric" "otel-global-5xxs" {
  project_key         = launchdarkly_project.terraform.key
  name                = "OTEL: global 5XXs"
  key                 = "otel-global-5xxs"
  description         = ""
  kind                = "custom"
  is_numeric          = false
  success_criteria    = "LowerThanBaseline"
  unit                = ""
  randomization_units = ["user"]
  event_key           = "otel.http.5XX"
  tags                = ["terraform"]
}

resource "launchdarkly_metric" "otel-http-latency" {
  project_key         = launchdarkly_project.terraform.key
  name                = "OTEL: HTTP latency"
  key                 = "otel-http-latency"
  description         = ""
  kind                = "custom"
  is_numeric          = true
  success_criteria    = "LowerThanBaseline"
  unit                = "ms"
  randomization_units = ["user"]
  event_key           = "otel.http.latency"
  tags                = ["terraform"]
}

resource "launchdarkly_metric" "otel-get-apiairportsroute-latency" {
  project_key         = launchdarkly_project.terraform.key
  name                = "OTEL: GET /api/airports/route latency"
  key                 = "otel-get-apiairportsroute-latency"
  description         = ""
  kind                = "custom"
  is_numeric          = true
  success_criteria    = "LowerThanBaseline"
  unit                = "ms"
  randomization_units = ["user"]
  event_key           = "http.latency;method=GET;route=/api/airports/route"
  tags                = ["terraform"]
}

resource "launchdarkly_metric" "otel-5xxs-on-apiairportsroute" {
  project_key         = launchdarkly_project.terraform.key
  key                 = "otel-5xxs-on-apiairportsroute"
  name                = "OTEL: 5XXs on /api/airports/route"
  description         = ""
  kind                = "custom"
  is_numeric          = false
  success_criteria    = "LowerThanBaseline"
  unit                = ""
  randomization_units = ["user"]
  event_key           = "http.5XX;method=GET;route=/api/airports/route"
  tags                = ["terraform"]
}

resource "launchdarkly_segment" "friends_and_family" {
  key         = "friends-and-family"
  project_key = launchdarkly_project.terraform.key
  env_key     = "development"
  name        = "Friends And Family"
  description = "Friends and family segment"
  tags        = ["terraform"]

  rules {
    clauses {
      attribute    = "key"
      op           = "startsWith"
      values       = ["jenn"]
      negate       = false
      context_kind = "user"
    }
  }
}

