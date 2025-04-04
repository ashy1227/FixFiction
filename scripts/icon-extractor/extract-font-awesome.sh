#!/usr/bin/env sh

if [ ! -f FontAwesome.tar.gz ]; then
	wget "https://github.com/Rush/Font-Awesome-SVG-PNG/archive/refs/tags/1.1.5.tar.gz" -O FontAwesome.tar.gz || {
		echo "Failed to download FontAwesome."
		exit 1
	}
fi
if [ ! -d FontAwesome/ ]; then
	mkdir -p FontAwesome/
	tar -xvzf FontAwesome.tar.gz --strip-components=1 -C FontAwesome/ || {
		echo "Failed to extract FontAwesome."
		exit 1
	}
fi

# cat icons.html | grep -oP '(?<=data-icon-type="font-awesome" class="bookshelf-icon-element fa fa-).*?(?="></span>)' | tr '\n' ' '
icons="bolt book bookmark certificate check times clock-o cog exclamation eye film gamepad globe heart lock music road search star thumbs-up thumbs-down thumb-tack smile-o meh-o frown-o trash-o user youtube-play "

mkdir -p Svg/white/font-awesome/
mkdir -p Svg/black/font-awesome/
for icon in $icons; do
	cp -a "FontAwesome/white/svg/$icon.svg" "Svg/white/font-awesome/fa-$icon.svg"
done

cp -a Svg/white/font-awesome/ Svg/black/
white_files="Svg/white/font-awesome/*"
black_files="Svg/black/font-awesome/*"
for file in $white_files; do
	sed -i "s/#fff/#ffffff/g" $file
done
for file in $black_files; do
	sed -i "s/#fff/#000000/g" $file
done