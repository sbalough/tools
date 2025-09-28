#
# Stuff that we only want to load up once on login
#

_sd="$(dirname "$BASH_SOURCE")"
for f in "os" "io"; do
    . "${_sd}/${f}.bash"
done

