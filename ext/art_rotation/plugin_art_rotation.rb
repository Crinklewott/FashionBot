# An art-rotation plugin
class FashionBot
  def art_rotation_initialize
    @art_rotation_config = YAML.load_file(File.join(__dir__, 'rotation_config.yaml'))
    @art_rotation_threads = Hash.new

    @bot.mention(in: @art_rotation_config[:channel]) do |event|
      art_rotation_mention(event) unless event.message.attachments.empty?
    end
  end

  # Allows users to add themselves to the art rotation
  def bot_addrotation(event)
    event.message.author.add_role get_role(event, @art_rotation_config[:role])
    event.send_message("alright sweetie, i'll call you when it's your turn")

    others = event.channel.users.find do |u|
      u.role? get_role(event, @art_rotation_config[:role]) and u.id != event.user.id
    end

    unless others
      event.send_message("looks like you're the first one up too, so go right ahead!")
      event.message.author.add_role get_role(event, @art_rotation_config[:active_role])
    end
  end

  # Allows users to remove themselves from the art rotation
  def bot_delrotation(event)
    end_user_thread(event.author.id)

    event.message.author.remove_role get_role(event, @art_rotation_config[:role])
    event.send_message("aww alright darling, but don't get into too much trouble")

    if event.message.author.role? get_role(event, @art_rotation_config[:active_role])
      event.message.author.remove_role get_role(event, @art_rotation_config[:active_role])

      others = event.channel.users.find do |u|
        u.role? get_role(event, @art_rotation_config[:role]) and u.id != event.user.id
      end

      if others
        next_user(event)
      else
        event.send_message("guess that's all for the art rotation for now")
      end
    end
  end

  private

  # A listener for when this bot is mentioned in the art room with an image
  def art_rotation_mention(event)
    if event.author.roles.find {|role| role.name == @art_rotation_config[:role]}
      if event.author.roles.find {|role| role.name == @art_rotation_config[:active_role]}
        event.send_message("ohh, well done!")
        end_user_thread(event.author.id)
        next_user(event)
      else
        event.send_message("that's lovely! but it's not your turn, cutie")
      end
    else
      event.send_message("oh. did you want to join too, honey? you can with `!addrotation`")
    end
  end

  # Assigns the active role to the next user, or delays if it's just one person doing it
  def next_user(event)
    user = event.channel.users.select do |u|
      u.role? get_role(event, @art_rotation_config[:role]) and
        not u.role? get_role(event, @art_rotation_config[:active_role])
    end.sample

    if user.nil?
        event.send_message("...i don't see anyone else though, so i'll wait before calling again, okay sweetie?")
        delayed_user_call(event)
    else
      event.send_message("you're up, <@#{user.id}>!")
      event.author.remove_role get_role(event, @art_rotation_config[:active_role])
      user.add_role get_role(event, @art_rotation_config[:active_role])
    end
  end

  # A version of next_user that delays the call
  def delayed_user_call(event)
    @art_rotation_threads[event.author.id] = Thread.new do
      sleep 60 * 60 * 24 * (rand(7) + 1)
      event.send_message("<@#{event.author.id}> alright, if you'd still like to go, go for it!")
    end
  end

  # End a watcher thread for a user
  def end_user_thread(user_id)
    thread = @art_rotation_threads[user_id]
    return if thread.nil?

    thread.exit
    @art_rotation_threads.delete(user_id)
  end
end
