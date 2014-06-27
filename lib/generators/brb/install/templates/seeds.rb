###########################
### SEED USERS ############
###########################

User.create(
  first_name: 'Admin',
  last_name: 'Admin',
  email: 'hello@world.com',
  username: 'admin',
  password: '123',
  password_confirmation: '123',
  is_admin: true,
  is_sysop: true,
  active: true
)
