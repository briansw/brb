# Brb

Brb is an opinionated, light-weight framework for scaffolding an admin interface for Rails. The goal of Brb is to help generate a simple, consistent base to build more complex views using standard Rails conventions.

Brb includes authentication, [Pundit](https://github.com/elabs/pundit)-based authorization, and some form helpers.

Originally extracted from [harvarddesignmagazine.org](http://harvarddesignmagazine.org) and [building--block.com](http://building--block.com).

# Installation

`gem 'brb', git: 'git@github.com:briansw/brb.git'`

# Developing with Brb

Clone the Brb repo to your local machine:

```git clone git@github.com:briansw/brb.git```

In a shell `cd` to the host app's folder and write:

```
bundle config local.brb /path/to/brb
bundle config disable_local_branch_check true
```

# Generators

`rails g brb:install` to bootstrap the app (currently seed data and image and user models)

# Concerns

```ruby
def sluggable_field
  filed_to_generate_slug_from
end
```

# Misc.

The dropdown menu is ordered based on the order of routes added with `admin_for`.

The `Adminable` concern defines a method `self.to_title` which is responsible for displaying the name of the resource around the admin area.
