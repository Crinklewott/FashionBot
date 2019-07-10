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
end
