DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"


arch -x86_64 bundle exec jekyll clean
arch -x86_64 bundle exec jekyll build

open -a "Google Chrome" "http://127.0.0.1:4000/"
arch -x86_64 bundle exec jekyll serve
