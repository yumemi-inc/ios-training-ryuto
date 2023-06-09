
## 概要

<!-- 箇条書きで良いので、簡素に記載をお願い致します。 -->

## レビュー観点

<!-- 
レビューアに確認してほしい事柄の記載をお願い致します。
特に、本PRにてレビュー対象外の内容があれば合わせて記載をお願い致します。

(例)
ビルドが通る状態となっているか
warnings が出力されないこと
デザインだけ組み込んだので、仕様についてはレビュー対象外として欲しい
このコミット xxxxxxxxx(commit hash) を主にレビューして欲しい
-->

## レビューレベル

<!-- どれかの打ち消し線を外してください。 -->

- ~~Lv0: まったく見ないでAcceptする~~
- ~~Lv1: ぱっとみて違和感がないかチェックしてAcceptする~~
- ~~Lv2: 仕様レベルまで理解して、仕様通りに動くかある程度検証してAcceptする~~
- ~~Lv3: 実際に環境で動作確認したうえでAcceptする~~

## スクリーンショット

<!-- 
画面表示に変化がある場合、添付や参照リンク及び変化内容の記載をお願い致します。
特に、動作やアニメーションなどもレビューして欲しい場合は、動作確認手順を書いたり、スクリーンショットの添付をお願い致します。

(例)
見た目に関する変更がないため省略します。
決定ボタンをタップ時に、表示変化があります。動画添付致します。

シミュレーターで録画するときのコマンド：
`$ xcrun simctl io booted recordVideo screen.mov`

Xcode12.5 以降であれば Command + R で可能

※動画がアップロードできないなどの場合、アニメーションGifに変換してアップロードしてもOKです

録画された動画をGifに変換するときのコマンド：
`$ ffmpeg -i screen.mov -vf "fps=15,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" screen.gif`

もしffmpegがインストールされていない場合、Homebrweから簡単にインストールできます。
-->

| before | after |
|--------|-------|
| XXXXXX | XXXXX |

## 備考

<!-- 他に伝えておきたいことがあれば記載をお願いいたします。 -->
