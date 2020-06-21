provider aws {
  region = "eu-west-2"
}

# ------------- Org Accounts ----------------
resource aws_organizations_organization team_name {
  feature_set = "CONSOLIDATED_BILLING"
}

resource aws_organizations_account team_name {
  name  = "team-name"
  email = "team-name@example.com"
}

resource aws_organizations_account team_name_dev {
  name      = "team-name-dev"
  email     = "team-name-dev@example.com"
  role_name = "admin"
}

# --------------- Groups -----------------
module group_admin {
  source = "../modules/groups"
  name   = "admin"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

module group_dev_rw {
  source = "../modules/groups"
  name   = "dev_rw"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sts:AssumeRole"
      Resource = "arn:aws:iam::${aws_organizations_account.team_name_dev.id}:role/${module.role_dev_rw.name}"
    }]
  })
}

module group_dev_ro {
  source = "../modules/groups"
  name   = "dev_ro"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sts:AssumeRole"
      Resource = "arn:aws:iam::${aws_organizations_account.team_name_dev.id}:role/${module.role_dev_ro.name}"
    }]
  })
}

# --------------- Users -----------------
module users {
  source = "../modules/users"
  user_details = list({
    user_name    = "team_boss"
    keybase_name = "team_boss"
    groups       = [module.group_admin.name]
    }, {
    user_name    = "smart_dev"
    keybase_name = "smart_dev"
    groups       = [module.group_dev_ro.name]
  })
}

# --------------- Roles -----------------
provider aws {
  region = "eu-west-2"
  alias  = "dev"

  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.team_name_dev.id}:role/admin"
  }
}

module role_dev_rw {
  providers = { aws = aws.dev }

  source      = "../modules/env_role"
  name        = "dev_rw"
  account_ids = [aws_organizations_account.team_name.id]
  policy = jsonencode({
    Version : "2012-10-17"
    Statement : [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
      }, {
      Effect   = "Deny"
      Action   = ["iam:*", "cloudtrail:*", "workspaces:*"]
      Resource = "*"
    }]
  })
}

module role_dev_ro {
  providers = { aws = aws.dev }

  source      = "../modules/env_role"
  name        = "dev_ro"
  account_ids = [aws_organizations_account.team_name.id]
  policy = jsonencode({
    Version : "2012-10-17"
    Statement : [{
      Effect   = "Deny"
      Action   = ["iam:*", "cloudtrail:*", "workspaces:*"]
      Resource = "*"
    }]
  })
  policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}
