class UserAuthorizer < ApplicationAuthorizer

  # Only admins and wizards at the current unit may create users.
  def self.creatable_by?(user, options)
    user.has_role?(:admin, options[:unit]) ||
    user.has_role?(:wizard, options[:unit])
  end

  # Admins and wizards may list users. This applies to UserController#index only.
  def self.readable_by?(user, options)
    user.has_role?(:admin, options[:unit]) ||
    user.has_role?(:wizard, options[:unit])
  end

  # Users can see themselves, admins and wizards of a unit can see users at the unit.
  def readable_by?(user)
    user == resource ||
    user.has_role?(:admin, resource.unit) ||
    user.has_role?(:wizard, resource.unit)
  end

  # Updating has the same rules as reading.
  def updatable_by?(user)
    user == resource ||
    user.has_role?(:admin, resource.unit) ||
    user.has_role?(:wizard, resource.unit)
  end

  # Only admins and wizards of the unit are able to delete users.
  def deletable_by?(user)
    user.has_role?(:admin, resource.unit) ||
    user.has_role?(:wizard, resource.unit)
  end
end
