# A plugin for general documentation
class FashionBot
  def bot_pronouns(event)
    event.send_message "oh? this little thing? ```
You can add your pronouns as informational roles using the !addrole command.
The current pronoun role list includes: they/them, it/its, she/her, and he/him.

Please post here (Or DM @Crinkly Friend) if you'd like others added.

Example 1; adding a role:
  !addrole they/them

Example 2; removing a role:
  !delrole they/them

Using either of these commands on their own shows the list of roles you can add in the event this documentation is out of date.
```"
  end

  def bot_artrelay(event)
    event.send_message "here you go, hun ```
You can add yourself to an art relay in the #drawstuffs channel!
The idea? To help you bust out of art block by transforming the channel into an art relay race! (Except without the race part.)

If you post \"!addrotation\" in chat, you'll be added to the list of people who can be called by Gardevoir when an artist finishes their drawing.

Whenever you get called to the art relay, the next person won't be picked until you either @ Gardevoir with your art, or you remove yourself from the rotation with \"!delrotation\" if you really aren't feeling it.

If you are the only artist in the art rotation, Gardevoir will instead wait a random number of days before you're up again.

Have fun!
```"
  end
end
