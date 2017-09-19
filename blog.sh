function blog {
    # Find a way to get the location of the script
    $DIR=$(pwd)
    $EXPDIR="/Users/scarroll/Documents/workspace/sebastiancarroll.github.io"
    if [[ $DIR != $EXPDIR ]]; then
        echo "Must be called from instide the blog dir"
        # TODO: Could just move there? Maybe good idea?
        exit 1;
    fi

    if [[ $# -gt 0 ]]; then
        echo "Usage: blog [command] [args...]"
        exit 1;
    fi

    ruby ./Thorscript.rb $@
}
