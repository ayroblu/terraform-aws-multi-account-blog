resource aws_iam_role role {
  name = var.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        "AWS" = [
          for account_id in var.account_ids :
          "arn:aws:iam::${account_id}:root"
        ]
      }
    }]
  })
}

resource aws_iam_role_policy policy {
  name = var.name
  role = aws_iam_role.role.id

  policy = var.policy
}

resource aws_iam_role_policy_attachment attachment {
  count = length(var.policy_arns)

  role       = aws_iam_role.role.id
  policy_arn = var.policy_arns[count.index]
}
