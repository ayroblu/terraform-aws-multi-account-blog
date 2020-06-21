resource aws_iam_group this {
  name = var.name
}
resource aws_iam_group_policy this {
  name   = "${var.name}_policy"
  group  = aws_iam_group.this.id
  policy = var.policy
}

