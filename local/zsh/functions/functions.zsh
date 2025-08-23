# TWO
# Script to auto login to the GCloud CLI
# Usage: glogin [-f] [-q]
# -f    force login
# -q    quiet mode
glogin() {
    local force=false
    local quiet=false
    local opt

    # Parse options
    while getopts ":fq" opt; do
        case ${opt} in
            f ) force=true ;;
            q ) quiet=true ;;
            \? ) echo "Usage: glogin [-f] [-q]" >&2
                 return 1 ;;
        esac
    done

    # Check whether the identity token is valid
    if ! logged_in=$(yes | gcloud auth print-identity-token --verbosity=debug 2>&1 | grep 'POST /token .* 200'); then
        force=true
    fi

    if [[ $force == true ]]; then
        # User is not logged in or forced to login via -f flag
        if [[ $quiet == false ]]; then
            echo "Logging in to Google Cloud..."
            gcloud auth login --update-adc
        else
            # Invoke login command quietly in the background
            (gcloud auth login --update-adc >/dev/null 2>&1 &)
        fi
    else
        # User is already logged in
        if [[ $quiet == false ]]; then
            account=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
            echo "Already logged in to Google Cloud as $account."
        fi
    fi
}