statusmsg = window.statusmsg = {}
# Fake OOP ftw!

# Hidden! This method will always make sure that the statusbox is in the
# center of the screen.
set_css = (msgbox) ->
  msgbox.css("position", "fixed")
        .css("left", ($(window).width() - $(msgbox).outerWidth()) / 2)

# The setup method.
# Note: this setup method will self-destruct once it is called
#       to prevent multiple boxes! (You will get an error on how
#       setup has been self-destructed)
statusmsg.setup = (append_to="body", id="statusmsg") ->
  statusmsg._id = id
  msgbox = $(document.createElement("div"))
  msgbox.addClass("statusmsg").attr("id", statusmsg._id)
  statusmsg._msgbox = msgbox

  $(append_to).append(msgbox)

  $(window).resize(() -> set_css(statusmsg._msgbox))
  $(window).resize()

  # We self destruct here. Yes. You can do this.
  statusmsg.setup = () ->
    throw "Error: setup has already been called!"

statusmsg.clear_events = () ->
  if statusmsg._timeoutid
    clearTimeout(statusmsg._timeoutid)
    statusmsg._timeoutid = undefined

  $(".closebtn", statusmsg).off("click")

statusmsg.display = statusmsg.open = (msg, closable, type="", autoclose=0, callback=() -> null) ->
  type = " " + type # Because we are concatenating this later

  statusmsg.clear_events()

  if closable
    msg += "<a href=\"#\" class=\"closebtn\">&times;</a>"
  
  statusmsg._msgbox.html(msg)
  statusmsg._msgbox.removeClass().addClass("statusmsg#{type}")
  
  set_css(statusmsg._msgbox)

  if closable
    $(".closebtn", statusmsg._msgbox).click((e) ->
      e.preventDefault()
      statusmsg.close()
    )

  if statusmsg._msgbox.css("display") == "none" or parseFloat(statusmsg._msgbox.css("opacity")) < 1
    statusmsg._msgbox.fadeIn(400, callback)
  else
    callback()

  if autoclose > 0
    statusmsg._timeoutid = setTimeout((() ->
      statusmsg.close()
    ), autoclose)

statusmsg.hide = statusmsg.close = (callback=() -> null) ->
  if statusmsg._msgbox.css("display") != "none"
    statusmsg._msgbox.fadeOut(400, callback)
  else
    callback()
  
  statusmsg.clear_events()
