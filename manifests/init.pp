class users {
  include stdlib

  $defaults = {
      'ensure'   => absent
  }

  # fetch list of users for the host
  $users = hiera_hash("site_users")

  create_resources(user, $users, $defaults)

  # fetch list of groups for the host
  $groups = hiera_hash("site_groups")

  create_resources(group, $groups, $defaults)

  # fetch list of sshkeys for the host
  $sshkeys = hiera_hash("site_sshkeys")

  create_resources(ssh_authorized_key, $sshkeys, $defaults)
}
