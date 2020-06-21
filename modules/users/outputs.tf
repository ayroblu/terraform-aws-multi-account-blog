# 1. Install keybase and aws-vault
# 2. Decrypt secret access key:
#$ echo "${aws_iam_access_key.user.encrypted_secret}" | base64 --decode | keybase pgp decrypt
#...secret_access_key...
# 3. Execute command below:
#$ aws-vault add aiden
# 4. And input (stdin):
#Enter Access Key ID: ${aws_iam_access_key.user.id}
#Enter Secret Access Key: ...secret_access_key...

output names {
  description = "names"
  value       = aws_iam_user.user.*.name
}
output access_key_ids {
  description = "access key ids"
  value       = aws_iam_access_key.user.*.id
}
output access_key_encrypted_secrets {
  description = "access key secrets"
  value       = aws_iam_access_key.user.*.encrypted_secret
}
#output access_key_instructions {
#  description = "access key instructions"
#  value       = <<EOT
#%{for o in map("id", aws_iam_access_key.user.*.id, "encrypted_secret", aws_iam_access_key.user.*.encrypted_secret)}
#id ${o.id}
#secret ${o.encrypted_secret}
#%{endfor}
#EOT
#}
