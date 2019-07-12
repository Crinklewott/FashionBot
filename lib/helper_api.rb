module HelperAPI
    # Returns a role from the server based on the passed in name and event
  def get_role(event, role)
    event.server.roles.find do |r|
      r.name == role
    end
  end
end
