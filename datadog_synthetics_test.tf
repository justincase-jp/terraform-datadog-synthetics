resource "datadog_synthetics_test" "default" {
  for_each = {
    for s in var.settings : s.request_definition.url => s
    if s.type == "default"
  }
  assertion {
    operator = "lessThan"
    target   = each.value.response.time
    type     = "responseTime"
  }
  assertion {
    operator = "is"
    target   = each.value.response.code
    type     = "statusCode"
  }
  locations = ["aws:ap-northeast-1"]
  message   = "${local.message} ${var.notify_slack_channel} ${var.pagerduty_service}"
  name      = "API test on ${each.value.request_definition.url}"
  options_list {
    tick_every = each.value.options_list.tick_every
    retry {
      count    = each.value.options_list.retry.count
      interval = each.value.options_list.retry.interval
    }
    monitor_options {
      renotify_interval = each.value.options_list.monitor_options.renotify_interval
    }
    scheduling {
      dynamic "timeframes" {
        for_each = each.value.options_list.scheduling.days

        content {
          day  = timeframes.value
          from = each.value.options_list.scheduling.from
          to   = each.value.options_list.scheduling.to
        }
      }
      timezone = each.value.options_list.scheduling.timezone
    }
  }
  request_definition {
    url    = each.value.request_definition.url
    method = each.value.request_definition.method
    body   = each.value.request_definition.body
  }
  request_headers = each.value.request_headers
  status          = each.value.status
  tags            = var.tags
  type            = "api"
}
