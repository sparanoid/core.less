core.less
=========

A starter kit built with [Bootstrap Loader](http://github.com/sparanoid/bootstrap-loader) for quick front-end development. Packages are managed by [Bower](http://github.com/twitter/bower).

Basic Usage
-----------

You need to install Bower fisrt. [More information about Bower](http://github.com/twitter/bower).

    npm install bower -g

Navigate to your project root and install core.less

    bower install core.less

Creating a node-static Server for Current Directory
---------------------------------------------------

Install node-static

    npm install node-static

Creating a file server for current directory

    touch app.js

Use the following code as your static web server, change the server root and port if you want to.

    var static = require('node-static');

    var file = new(static.Server)('./');

    require('http').createServer(function (request, response) {
        request.addListener('end', function () {
            file.serve(request, response);
        });
    }).listen(4000);

Fire it up

    node app

Author
------

**Tunghsiao Liu**

+ http://twitter.com/tunghsiao
+ http://github.com/sparanoid