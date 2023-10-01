. ./assert.sh
. /usr/bin/opentelemetry_shell.sh

zsh auto/fail_no_auto.shell
assert_equals 0 $?
sleep 3
assert_equals "zsh auto/fail_no_auto.shell" "$(cat $OTEL_TRACES_LOCATION | jq '. | select(.resource.attributes."process.command" == "zsh auto/fail_no_auto.shell")' | jq -r '.name')"
assert_equals "SpanKind.INTERNAL" $(cat $OTEL_TRACES_LOCATION | jq -r '.kind')
zsh auto/fail.shell 42
assert_equals 42 $?
