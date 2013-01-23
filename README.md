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

There are 3 functions that you will ever need to call: `setup`, `open`, `close`.

 - `setup`: You need to the environment by calling `statusmsg.setup()` on `onload`. There
            are 2 arguments (0 required):
    - `append_to`: The jQuery selector to append the message box div to. 
                   defaults to `"body"`
    - `id`: The id of the message box div, defaults to `statusmsg`. Note, this
            is not a selector!
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
    - `callback`: A callback function that takes nothing that gets called
                  when the box faded in. If the box is already visible, it
                  will be called immediately.
 - `close`: Close the message box, there are 1 argument (0 required):
    - `callback`: A callback function that takes no argument that will get 
                  called when the box fades out. If the box is already
                  invisible, it will be called immediately.

For historical purposes, `display` aliases to `open` and `hide` aliases to 
`open`. (So you can call `statusmsg.display` and `statusmsg.hide` instead of
`statusmsg.open` and `statusmsg.close`)

Check `demo.html` for example usage and demo.

If you want additional `type` for your message boxes, just create a new css
definition for `.statusmsg.<your_type_here>` and pass `"<your_type_here>"` into
the function
