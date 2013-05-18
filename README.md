[Pandoc] is not always easy to install. If you have ssh access to a server that has pandoc installed, you can use pandoc over ssh. For example,

    $ cat foo.markdown | ssh example.com "pandoc -t latex" > foo.tex

will pipe the content of your local file, `foo.markdown`, through the remote copy of pandoc, convert it to latex, and pipe the output into `foo.tex`.

There are two ways in which this is less than ideal. First, you need to pipe the local file using `cat`. You cannot just specify it on the command line in the usual way. Second, you if the output format is binary, like pdf, docx, epub, or odt, you'll need to find a way to get the remote copy of the binary file onto your local system.

That is where `ssh-pandoc-wrapper` comes in. Feed the script standard pandoc options in the usual way. It will figure out what needs to be piped where, and how to get those binary files onto your local system. Think of it as an ersatz version of `pandoc`, passing everything off the real version of pandoc on the remote server.

# Requirements

You need to have access to pandoc over ssh. The script itself is written in bash, and should not introduce any additional requirements.

# Installation

This is a simple script. Make sure it is executable, and put it in your path. On my iPad, I've renamed it `pandoc`.

# Local Files, Remote Files

This script deals with getting your local input file(s) piped into the remote copy of pandoc, and getting the output back to your local computer. It is not smart about the locations of templates or images.

All of the processing is done on the remote server. If pandoc needs to find images, it will be looking for them on the server. If it needs to find templates, it will be looking for them on the server.


 



[pandoc]: http://www.johnmacfarlane.net/pandoc/


