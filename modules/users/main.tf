resource aws_iam_user user {
  count = length(var.user_details)

  name = var.user_details[count.index].user_name
}
resource aws_iam_access_key user {
  count = length(var.user_details)

  user    = aws_iam_user.user[count.index].name
  pgp_key = "keybase:${var.user_details[count.index].keybase_name}"
}

resource aws_iam_user_group_membership user {
  count = length(var.user_details)

  user = aws_iam_user.user[count.index].name

  groups = var.user_details[count.index].groups
}
