###
Copyright (C) Shuhao Wu 2013
http://shuhaowu.com
Licensed under Apache 2
###
$ = jQuery

# Hidden! This method will always make sure that the statusbox is in the
# center of the screen.
set_css = (msgbox) ->
  msgbox.css("position", "fixed").css("left",(($(window).width() - msgbox.outerWidth()) / 2))

statusmsg =
  init: ((options={}) ->
    statusmsg.id = options.id or "statusmsg"
    statusmsg.msgbox = $(document.createElement("div")).addClass("statusmsg")
                          .attr("id", statusmsg.id)
    this.append(statusmsg.msgbox)
    $(window).resize(() -> set_css(statusmsg.msgbox))
    $(window).resize()
  )
  open: ((msg, options={}) ->
    closable = options.closable or false
    type = " " + (options.type or "")
    autoclose = options.autoclose or 0
    callback = options.callback or () -> null
    unsafe = options.unsafe || false

    if closable
      msg += "<a href=\"#\" class=\"closebtn\">&times;</a>"

    if unsafe
      statusmsg.msgbox.html(msg)
    else
      statusmsg.msgbox.text(msg)

    statusmsg.msgbox.removeClass().addClass("statusmsg#{type}")

    set_css(statusmsg.msgbox)

    if closable
      $(".closebtn", statusmsg.msgbox).click((e) ->
        e.preventDefault()
        statusmsg.close()
      )

    if statusmsg.msgbox.css("display") == "none" or parseFloat(statusmsg.msgbox.css("opacity")) < 1
      statusmsg.msgbox.fadeIn(400, callback)
    else
      callback()

    if autoclose > 0
      statusmsg._timeoutid = setTimeout((() -> statusmsg.close()), autoclose)

  )
  close: ((options={}) ->
    callback = options.callback or () -> null
    if statusmsg.msgbox.css("display") != "none"
      statusmsg.msgbox.fadeOut(400, callback)
    else
      callback()

    statusmsg.clear_events()
  )
  clear_events: (() ->
    if statusmsg._timeoutid
      clearTimeout(statusmsg._timeoutid)
      statusmsg._timeoutid = undefined
      $(".closebtn", statusmsg).off("click")
  )

statusmsg["display"] = statusmsg["open"]
statusmsg["close"] = statusmsg["close"]

$.fn.extend(
  statusmsg: (action) ->
    if statusmsg[action]
      return statusmsg[action].apply(this, Array.prototype.slice.call(arguments, 1))
    else if typeof action == "object" or not action
      return statusmsg.init.apply(this, arguments)
    else
      $.error("Method #{action} does not exist on jQuery.statusmsg")
)
