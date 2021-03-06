#
# Privileges are non-database backed objects that, when created and destroyed,
# actually add or remove user roles specified by its attributes.
#
class Privilege
  extend ActiveModel::Naming

  include ActiveModel::Model
  attr_accessor :name, :resource_gid

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities


  def self.from_role(role)
    self.new(name: role.name, resource_gid: role.resource_gid)
  end

  # Returns the resource this privilege specifies with its resource gid.
  def resource
    GlobalID::Locator.locate(resource_gid)
  end
end
