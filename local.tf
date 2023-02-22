locals {
  mention_to = var.is_mention_channel ? "<!channel>" : ""

  message = <<EOM
{{^is_recovery}}WebサイトまたはAPIの監視が異常値を検知しました。
アクセスできなかったり、リクエストが失敗している可能性があります。
応急処置・お客様へのご連絡をお願いします。エンジニアが不在の場合、まずは疎通確認を行って下さい。 ${local.mention_to} {{/is_recovery}}
{{#is_recovery}}WebサイトまたはAPIが正常に戻りました。
お客様へのご連絡・ポストモーテムの作成をお願いします。{{/is_recovery}}
EOM

  settings = defaults(var.settings, {
    request_headers = {}
  })
}
