DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"


bundle exec jekyll clean
bundle exec jekyll build

open -a "Google Chrome" "http://127.0.0.1:4000/"
bundle exec jekyll serve --incremental
