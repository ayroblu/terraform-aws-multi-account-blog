variable name {
  type = string
}
variable policy {
  type = string
}
variable account_ids {
  description = "Parent account ids to allow access from"
  type        = list(string)
}
variable policy_arns {
  description = "Extra policies to attach"
  type        = list(string)
  default     = []
}
