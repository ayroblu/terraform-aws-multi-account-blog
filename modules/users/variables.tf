variable user_details {
  type = list(object({ user_name = string, groups = list(string), keybase_name = string }))
}
