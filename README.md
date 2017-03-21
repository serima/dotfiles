# Got a new Macbook!
## Connect Hardware

1. Connect bluetooth mouse (Logicool M305)
2. Setting Keyboard
	1. システム環境設定 -> キーボード -> Bluetooth キーボードを設定
	2. 修飾キー
		* Internal Keyboard と Bluetooth キーボードどちらに関しても
			* Caps Lock キー を Control に割り当てる
			* Control キー を Caps Lock に割り当てる
	3. ショートカット
		* 入力ソース
			* 前の入力ソースを選択、入力メニューの次のソースを選択のチェックを外す
		* Spotlight
			* Spotlight 検索を表示のチェックを外す
		* キーボード
			* 次のウィンドウを操作対象にする を Ctrl + スペースに変更
		* フルキーボードアクセスで、「すべてのコントロール」にチェック
3. Setting Display
	1. 適切な配置を設定する
2. Setting Trackpad
	1. ポイントとクリック -> タップでクリックのチェックを外す
	2. ポイントとクリック -> 軌跡の速さを右から5番目の目盛りに
	3. スクロールとズーム -> スクロールの方向: ナチュラルのチェックを外す
4. Setting Mouse
	1. スクロールの方向: ナチュラル のチェックを外す
	2. 軌跡の速さ -> 右から6番目の目盛りに

## Change password

* システム環境設定 -> ユーザとグループ -> パスワードを変更
	* 大文字小文字記号数字を含む必要がある

## Change Dock Position

* システム環境設定 -> Dock -> 画面上の位置 : 右
* システム環境設定 -> Dock -> Dock を自動的に隠す／表示

## Setting Hot Corner

* システム環境設定 -> Mission Control -> ホットコーナー -> 右上 : デスクトップ

## Setting Spotlight

* Spotlight は使用しないので、すべてチェックを外す

## Setting Keyrepeat

```
$ defaults write -g InitialKeyRepeat -int 10
$ defaults write -g KeyRepeat -int 3
```

その後、再起動する。

## Install

### via App Store

#### 事前準備
* `r.shibayama@gmail.com` でログイン
* 利用可能なソフトウェアアップデートを行う
* 自動アップデートを入にする

#### Install Software

* Xcode
* Slack
* The Unarchiver
* Skitch
* Growl
* CotEditor
* Get Plain Text
* Bear

### via Browser

* GoogleChrome
* Fluid
* Alfred
* iTerm2
* MacZip4Win
* Karabiner
* Google 日本語入力
* PHPStorm
* BetterTouchTool
* VirtualBox
* Vagrant
* Sequel Pro
* Spectacle
* Near Lock
* Get Plain Text
* Marp
* Shift
* ⌘英かな

## Software settings

### Finder

* 環境設定 -> 一般 -> 新規 Finder ウィンドウで次を表示を変更
* 環境設定 -> サイドバー -> r_shibayama などホームディレクトリを表示するように変更

### BetterTouchTool

* Basic Settings -> Launch BetterTouchTool on startup
* http://ryomac.blog.fc2.com/blog-entry-89.html

### Alfred

* Hotkey を Cmd + Space に変更

### GoogleChrome

* `j02521` としてログインすることで拡張機能や履歴などが同期される
* 環境設定 -> ダウンロード保存先をデスクトップに変更

### ⌘英かな

* ログイン後にこのアプリを起動

### iTerm2

* 事前に Ricty をインストールしておく必要がある
* Preference -> Profiles -> Text -> Regular Font -> Ricty 12pt (Anti-aliased)
* Preference -> Profiles -> Text -> Double-Width Characters -> Treat ambiguous-width characters as double width をオンに
* Preference -> Terminal -> Notifications -> Scilence bell をオンに
* Preference -> General -> Native full screen windows をオフに

### PHPStorm

* Preference -> Appearance & Behavior -> Appearance -> UI Options -> Theme: Darcula
* Preference -> Editor -> Colors & Fonts -> Font -> Scheme
	* Monokai を Save As して Monokai Copy にする
	* Primary font を Ricty に変更
* Preference -> Plugins -> IdeaVIM
* Preference -> Editor -> Appearance -> Show line numbers をオンに

## Setup Development Environment

### 鍵の設置

```
$ mkdir ~/.ssh
$ mv ~/Desktop/id_rsa* ~/.ssh

### GitHub のアクセストークン設定

* 二段階認証設定済みなので、https 経由で pull/push できるように設定を行う必要がある
* See : http://qiita.com/usamik26/items/c655abcaeee02ea59695
```

### Xcode

* 起動させ、Agree だけしておく

### Install Command Line Tools

```
$ xcode-select --install
```

### Install Homebrew

```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install zsh

```
$ brew install zsh
```

* Next step : http://qiita.com/nenokido2000/items/763a4af5c161ff5ede68

### Install golang

```
$ brew install go
```

### Install q

```
$ brew install q
```

* `.zshrc` に `GOPATH=~` と定義してある

### Install ghq + peco

```
$ brew install peco
$ brew install ghq

$ git config --global ghq.root ~/src
```

* See also http://qiita.com/ysk_1031/items/8cde9ce8b4d0870a129d
* Super alias is http://qiita.com/itkrt2y/items/0671d1f48e66f21241e2

### Install byobu

```
$ brew install byobu
```

### Install ssh-copy-id

```
$ brew install ssh-copy-id
```

* See also http://byobu.co

### Install Ricty

```
$ brew tap sanemat/font
$ brew install Caskroom/cask/xquartz
$ brew install ricty
$ cp -f /usr/local/Cellar/ricty/4.1.0_2/share/fonts/Ricty*.ttf ~/Library/Fonts/
$ fc-cache -vf
```

#### for external display

```
$ defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
```

### dotfiles

```
$ cd
$ git clone git://github.com/serima/dotfiles.git 
$ bash ./dotfiles/create_symlink.sh
$ cd dotfiles
$ git submodule init
$ git submodule update
$ vim
(open vim and type :NeoBundleInstall to retrieve plugins)
```
