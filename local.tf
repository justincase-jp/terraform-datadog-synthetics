locals {
  mention_to = var.is_mention_channel ? "<!channel>" : ""

  message = <<EOM
{{^is_recovery}}外形監視にて異常を検知しました
Datadogから各種メトリクスを確認し原因の特定をお願いします ${local.mention_to} {{/is_recovery}}
{{#is_recovery}}外形監視が正常な値に戻りました
必要があれば障害報告書の記入をお願いします{{/is_recovery}}
EOM

  settings = defaults(var.settings, {
      request_headers = {}
    })
}
