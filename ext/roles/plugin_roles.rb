require 'yaml'
require 'set'

# A plugin to manage assignable roles
class FashionBot
  def roles_initialize
    @assignable_roles = Set.new(YAML.load_file(File.join(__dir__, 'roles.yaml')))
  end

  # Allows users to add roles to themselves from a whitelist
  def bot_addrole(event, role=nil)
    if role.nil?
      event.send_message <<-MESSAGE
      the roles i'll let you play with are #{@assignable_roles.to_a.join ", "}
      MESSAGE
    else
      addrole(event, role)
    end
  end

  # Allows users to remove roles from themselves from a whitelist
  def bot_delrole(event, role=nil)
    if role.nil?
      event.send_message <<-MESSAGE
      the roles i'll let you remove are #{@assignable_roles.to_a.join ", "}
      MESSAGE
    else
      delrole(event, role)
    end
  end

  private

  # Actually adding the role to the user
  def addrole(event, role)
    if @assignable_roles.include? role then
      if event.message.author.roles.find {|r| r.name == role}
        event.send_message("but you already have that role sweetie")
      else
        event.message.author.add_role get_role(event, role)
        event.send_message("mhm! role added, you're now #{role}")
      end
    else
      event.send_message("i'm sorry honey, but i can't give you that role")
    end
  end

  # Actually deleting the role from the user
  def delrole(event, role)
    if @assignable_roles.include? role then
      if event.message.author.roles.find {|r| r.name == role}
        event.message.author.remove_role get_role(event, role)
        event.send_message("alright hun, #{role} removed")
      else
        event.send_message("i don't see that role, you sure have an imagination sometimes, hun")
      end
    else
      if event.message.author.roles.find {|r| r.name == role}
        event.send_message("only big kids can touch that role, cutie pie")
      else
        event.send_message("tsk tsk tsk!")
      end
    end
  end
end
