## The Problem and the Solution

[Pandoc] is not easy to install in every environment. One way to use pandoc without having it installed is to use a copy installed on a remote server over ssh. For example,

    $ cat foo.markdown | ssh example.com "pandoc -t html"

will pipe the content of your local file, `foo.markdown`, through the remote copy of pandoc, convert it to html, and return the output on standard out, where you can do what you want with it.

Binary output (pdf, docx, odt, epub) is slightly more complicated, because pandoc will not pipe binary files to standard out,

    $ cat foo.markdown | ssh example.com "pandoc -o foo.docx; cat foo.docx; rm foo.docx" > foo.docx

`ssh-pandoc-wrapper.sh` makes all of this more convenient. It handles the task of piping input over ssh, passing options off to the remote copy of pandoc, and fetching a remote output file, if one is produced.

Place the script in your path, and rename it `pandoc`. Edit the `server` variable on line 3 to point to your ssh server. Now you have an ersatz local copy of pandoc, that passes all the real work off the your remote server. For example, all of these commands should work just as expected:

    $ pandoc foo.markdown -t html
    $ cat foo.markdown bar.markdown | pandoc --numbered-sections > foobar.html
    $ pandoc foo.markdown -o foo.docx

The script worries about passing local input to the remote server and getting remote output back. All other options are passed through to the remote server. If you use options that reference additional files, like `--css`, `--template`, and `--bibliography`, those files need to be on the remote server. For example,

    $ pandoc foo.markdown --bibliography=papers.bib -o foo.html

will only work if `papers.bib` is in the remote working directory.

## Requirements

You need to have access to pandoc over ssh. The script itself is written in bash.

## Installation

Make the script executable, put it in your path, rename it `pandoc`. Edit line 3 with your ssh server information.

[pandoc]: http://www.johnmacfarlane.net/pandoc/


