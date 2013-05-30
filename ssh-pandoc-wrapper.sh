#!/bin/sh
# 
server=user@example.com
# If you have a host configured in ~/.ssh/config, you can set server
# to the alias instead.

# Is the server variable configured?
if [ "$server" == 'user@example.com' ]; then
    echo "Script not configured:"
    echo "    edit line 3 of $0"
    exit
fi

opts="$@"

# Get some information about the input and output files
args=($(ssh "pandoc --dump-args $@"))

# Information about the output
output_file=${args[0]}

# Are we piping to stdout?
if [ $output_file == "-" ]; then
   pipe_output=true
fi

# Information about the input

# Were input files specified on the command line?
if [ ${#args[@]} -ge 2 ]; then
    input_files=""
    for (( i=1; i<${#args[@]}; i++ ));
    do
       input_files="$input_files ${args[$i]}"
       opts=$(echo $opts | sed s/${args[$i]}//)
    done
else
    input_files="-"
fi

if [ $pipe_output ]; then
    cat $input_files | ssh $server "pandoc $opts"
else
    cat $input_files | ssh $server "pandoc $opts; cat $output_file; rm $output_file" > $output_file
fi

