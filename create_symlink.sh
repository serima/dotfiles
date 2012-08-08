#!/bin/sh
cd $(dirname $0)
for dotfile in .?*; do
	case $dotfile in
		*.elc)
			continue;;
		..)
			continue;;
		.git)
			continue;;
		*)
			ln -Fis "$PWD/$dotfile" $HOME
			;;
	esac
done

cd
mkdir tmp
touch tmp/yanktmp
chmod -R 777 tmp
