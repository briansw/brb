###########################
### SEED USERS ############
###########################

User.create(
  first_name: 'Brian',
  last_name: 'Watterson',
  email: 'briansw@gmail.com',
  username: 'admin',
  password: '123',
  password_confirmation: '123',
  is_admin: true,
  is_sysop: true,
  active: true
)
