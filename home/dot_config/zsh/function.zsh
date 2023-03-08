whichbrew=$(which brew)

function brew() {
    if [[ $1 == "install" ]]; then
        $whichbrew "$@"
        if [[ -n $HOMEBREW_BUNDLE_FILE ]]; then
            echo "Generating Brewfile..."
            $whichbrew bundle dump --force --describe
        else
            echo "Impossible to generate Brewfile, HOMEBREW_BUNDLE_FILE isn't set"
        fi
    else
        $whichbrew "$@"
    fi
}
