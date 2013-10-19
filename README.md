Awesome Statusmsg
=================

Awesome Statusmsg is just a status message box similar to the gmail's sending
box. I have used and modified this library too many times for it not to be
its own project as all my projects that includes this have a 
different/customized version of it.

Originally this thing came from [humanmsg](http://code.google.com/p/humanmsg/).
I ported it to coffeescript (and my build chain coffeecrispt, which kinda sucks)
and made enough modifications that I think it deserve a new name.. However I 
currently don't have anything creative for this.. So feel free to suggest!

The warning, error, success, info classes' color themes are stole from bootstrap

Demo: http://c.thekks.net/statusmsg/

**License**: Apache 2

Running Instructions
--------------------

First of all, you need jQuery (as of right now 1.8.x), which is included here.
You then need to grab statusmsg.js and statusmsg.css then put it into whatever
directories you store these files and link to them. You probably want to
minify them, or maybe even embed it.

Modification Instructions
-------------------------

To modify the script, feel to modify either the .js or .coffee file. However,
if you want to submit a pull request, please modify the .coffee file. Source
should be fairly self explanatory.

Feel free to add stuff into the .css.

Documentations
--------------

Since this is now a jQuery plugin, you use it with jQuery (include it after
jQuery)

This library uses a singleton approach, as there is no need for multiple copies
of this as of yet. It is recommended that you base all operations on $("body").

Before you start using the plugin, you must first initialize it with

    $("body").statusmsg();

You could pass in `{id: "your-id"}` into the function to specify your custom
id for the status message box.

There are 2 actions that you will ever need to call: `open` (`display` is an 
alias), `close` (`hide` is an alias).
 - `open`: To open the message box. There are 5 arguments (1 required):
    - `msg`: required, this is an html string that's suppose to be inside
             the message box. This should only have 1 line!
    - `closable`: if `true` (or something like `"closable"`, anything that
                  is accepted as true in JavaScript), the message box will be
                  user closable. This is done via an x mark on the right of the
                  message box and when clicked the message box will be closed.
                  Defaults to `undefined`.
    - `type`: The type of the message box. Essentially this adds an additional
              class to the message box. Some predefined ones are: `warning`,
              `error`, `success`. Defaults to nothing and it will have a 
              greenish background. (Check demo for details)
    - `autoclose`: The number of milliseconds until the message box closes
                   itself. If it is 0, message box will be shown until `close`
                   is called. Defaults to 0. If another call is made to either
                   `open` or `close`, the timeout event to close the message box
                    will be autocleared.
    - `unsafe`: Whether to use `.text()` or `.html()` to put the message inside
                the message box. Defaults to false, which means it will use 
                `.text()`
    - `callback`: A callback function that takes nothing that gets called
                  when the box faded in. If the box is already visible, it
                  will be called immediately.
 - `close`: Close the message box, there are 1 argument (0 required):
    - `callback`: A callback function that takes no argument that will get 
                  called when the box fades out. If the box is already
                  invisible, it will be called immediately.

The `open` and `close` is passed as a string to the `$("body").statusmsg`
function as the first argument. Other arguments are passed in as a plain JS
object.

Check `demo.html` for example usage and demo.

If you want additional `type` for your message boxes, just create a new css
definition for `.statusmsg.<your_type_here>` and pass `"<your_type_here>"` into
the function
