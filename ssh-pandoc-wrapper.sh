#!/bin/sh
# Change this to the URL or alias of your ssh server:
server=example.com

opts="$@"

# Get some information about the input and output files
args=($(pandoc --dump-args $@))
# Information about the output
output_file=${args[0]}
if [ $output_file == "-" ]; then
   pipe_output=true
fi
# information about the input
if [ ${#args[@]} -ge 2 ]; then
    # We have input files
    input_files=""
    for (( i=1; i<${#args[@]}; i++ ));
    do
       input_files="$input_files ${args[$i]}"
       opts=$(echo $opts | sed s/${args[$i]}//)
    done
else
    # input is from STDIN
    read line
    input_text="$line"
    while read line; do
        input_text="$input_text\n$line"
    done
fi

# Let's get to work
if [ $input_files ]; then
    if [ $pipe_output ]; then
        cat $input_files | ssh $server "pandoc $opts"
    else
        cat $input_files | ssh $server "pandoc $opts; cat $output_file; rm $output_file" > $output_file
    fi
else
    if [ $pipe_output ]; then
        echo "$input_text" | ssh $server "pandoc $opts"
    else
        cat "$input_text" | ssh $server "pandoc $opts; cat $output_file; rm $output_file" > $output_file
    fi
fi
