# Breakout

Breakout is a light framework for routing messages among web browsers and workers using WebSockets.

This repository provides a module to help create workers along with some example workers and JavaScripts. See the [EM-Breakout](https://github.com/steve9001/em-breakout) repository for the server component.

## Getting started

First, you should follow the instructions for getting started with the [EM-Breakout](https://github.com/steve9001/em-breakout) server.

Also, the JavaScript examples use the HTML5 API for WebSockets. This currently works on [Chrome](http://www.google.com/chrome/), but may or may not work on other browsers. As it is beyond the scope of Breakout to deal with the capabilities of various browsers, you may wish to install Chrome to enjoy a successful experience.

Next, in a new terminal, clone this repository and change to the examples directory. There are no dependencies for using the gem, but the example web app requires Sinatra, so make sure that is installed.

Before your browser can connect, you'll need to start a worker process by running the worker_app.rb file. (You're already running the em-breakout server, right?)

Then, after opening yet another terminal window and changing to the examples directory, you can run the web_app.rb file and point your browser to [http://localhost:4567](http://localhost:4567). Now you can try each example while examining the worker Ruby file and client JavaScript file.

* Echo: The browser sends a message with every keypress and displays every message received; the worker echoes every message received
* Ping: The worker sends a valid WebSocket URL in response to each message; using the URLs received from the worker, the browser continues to open additional WebSockets, and for each one displays the time it takes for each ping. After awhile, try running a second worker to speed up response times.
* Chat: A simple chatroom that demonstrates the notification feature. You should try using two browsers for this, however the example will not work correctly with multiple workers, as described in the chat.rb file.

## FAQ

* Q: How do I use this with a Rails project?
  A: The details depend on your deployment scenario, but the trickiest part should be adjusting the breakout.yml that is generated so that browsers and workers can connect to wherever the em-breakout server is running. The other steps include adding the breakout gem to your dependencies (you'll have to point it to Github until a gem is published), copying the echo.rb example worker and implementing your own do_work method (make sure your Rails environment is loaded in the worker so you can access models), copying the worker_app.rb to help run your workers, and using Breakout.browser_url in the appropriate view to allow your clients to connect to your workers.

## Copyright

Copyright (c) 2011 Steve Masterman. See LICENSE for details.

