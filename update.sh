#!/usr/bin/env bash
set -e

declare -A pecl=(
  ['redis']='2.2.8'
  ['apcu']='4.0.11'
  ['memcached']='2.2.0'
  ['xdebug']='2.5.5'
)

for variant in '5' '5.5' '7' '7.2' '7.3' '7.4'; do
  for type in 'default' 'xdebug'; do
    template="Dockerfile.template"
    if [ "$type" != "default" ]; then
      dir="$variant-$type"
    else
      dir="$variant"
    fi
    rm -rf "$dir"
    mkdir -p "$dir"
    extraSed=''

    if [[ "$variant" = 5* ]]; then
      for package in "${!pecl[@]}"; do
        extraSed='
          '"$extraSed"'
          s/pecl install -o -f '"$package"' /pecl install -o -f '"$package-${pecl[$package]}"' /
        '
      done
      extraSed='
        '"$extraSed"'
        /##<apcu_bc>##/,/##<\/apcu_bc>##/d;
      '
    else
      extraSed='
        '"$extraSed"'
        /##<mcrypt>##/,/##<\/mcrypt>##/d;
      '
    fi

    if [ "$variant" != "7.4-rc" ]; then
      extraSed='
        '"$extraSed"'
        /##<libonig>##/,/##<\/libonig>##/d;
      '
    fi

    if [ "$type" != "xdebug" ]; then
      extraSed='
        '"$extraSed"'
        /##<xdebug>##/,/##<\/xdebug>##/d;
      '
    fi
    sed -E '
      '"$extraSed"'
      s/%%VARIANT%%/'"$variant"'/;
    ' $template > "$dir/Dockerfile"
  done
done
