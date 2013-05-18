## The Goal

[Pandoc] is not always easy to install. If you have ssh access to a server that has pandoc installed, you can use pandoc over ssh. For example,

    $ cat foo.markdown | ssh example.com "pandoc -t latex" > foo.tex

will pipe the content of your local file, `foo.markdown`, through the remote copy of pandoc, convert it to latex, and pipe the output into `foo.tex`.

There are two ways in which this is less than ideal. First, you need to pipe the local file using `cat`. You cannot just specify it on the command line in the usual way. Second, if the output format is binary, like pdf, docx, epub, or odt, you'll need to find a way to get the remote copy of the binary file onto your local system.

That is where `ssh-pandoc-wrapper` comes in. Feed the script standard pandoc options in the usual way. It will figure out what needs to be piped where, and how to get those binary files onto your local system. Think of it as an ersatz local installation of `pandoc`, that passes the real work off to the version of pandoc on the remote server.

## Requirements

You need to have access to pandoc over ssh. The script itself is written in bash, and should not introduce any additional requirements. My intent is that it be usable on any POSIX system. My own use cases: a jailbroken iPad and a Raspberry Pi.

## Installation

This is a simple script. Make sure it is executable, and put it in your path. On my iPad, I've renamed it `pandoc`. That way, other tools that call pandoc will call it instead.

## Configuration

You need to set the value of `server` on line 3 of the script to the URL or ssh alias for your server. I have an alias for my server in ~/.ssh/config, so I set server to this alias.

## Local Files, Remote Files

This script gets your local input file(s) piped into the remote copy of pandoc, and gets the output back to your local computer. It does not try to push other local stuff to the remote server. So local images and templates, for example, will not be sent to the server. 

[pandoc]: http://www.johnmacfarlane.net/pandoc/


