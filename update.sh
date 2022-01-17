#!/usr/bin/env bash
set -e

phpVersions='8.1 8 8.0 7 7.4 7.3'
distros='debian alpine'

for variant in $phpVersions; do
  for distro in $distros; do
    for type in 'default' 'xdebug'; do
      extraSed=''
      template="Dockerfile.template"
      dir="$variant"
      varientD=""

      if [ "$distro" != "debian" ]; then
        dir="$dir-$distro"
        varientD="-$distro"
        extraSed='
					'"$extraSed"'
					/##<debian>##/,/##<\/debian>##/d;
				'
      else
        extraSed='
					'"$extraSed"'
					/##<alpine>##/,/##<\/alpine>##/d;
				'
      fi

      if [ "$type" != "default" ]; then
        dir="$variant-$type"
      fi

      if [[ "$variant" == 5* ]]; then #php5
        extraSed='
					'"$extraSed"'
					/##<opencensus>##/,/##<\/opencensus>##/d;
				'
      else #php7
        extraSed='
					'"$extraSed"'
					/##<mcrypt>##/,/##<\/mcrypt>##/d;
				'
      fi

      if [ "$type" != "xdebug" ]; then
        extraSed='
					'"$extraSed"'
					/##<xdebug-enable>##/,/##<\/xdebug-enable>##/d;
				'
      fi

      rm -rf "$dir"
      mkdir -p "$dir"
      sed -E '
				'"$extraSed"'
				s/%%VARIANT%%/'"$variant-cli$varientD"'/;
			' $template >"$dir/Dockerfile"
    done
  done
done
