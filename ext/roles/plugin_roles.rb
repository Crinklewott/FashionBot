require 'yaml'
require 'set'

# A plugin to manage assignable roles
class FashionBot
  def roles_initialize
    @assignable_roles = Set.new(YAML.load_file('roles.yaml'))
  end

  # Allows users to add roles to themselves from a whitelist
  def bot_addrole(event, role)
    return unless @assignable_roles.include? role

    event.message.author.add_role get_role(event, role)
  end

  # Allows users to remove roles from themselves from a whitelist
  def bot_delrole(event, role)
    return unless @assignable_roles.include? role

    event.message.author.remove_role get_role(event, role)
  end

  private

  # Returns a role from the server based on the passed in name and event
  def get_role(event, role)
    event.server.roles.find do |r|
      r.name == role
    end
  end
end
