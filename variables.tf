variable "env" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "settings" {
  type = list(
    object({
      type = string
      request_definition = object({
        url    = string
        method = string
        body   = optional(string)
      })
      request_headers = optional(
        object({
          Authorization = optional(string)
          Content-Type  = optional(string)
        })
        # TODO: Terraform v1.3でmodifierによるデフォルト値のセットがサポートされたら使う
        # https://discuss.hashicorp.com/t/request-for-feedback-optional-object-type-attributes-with-defaults-in-v1-3-alpha/40550
        # }), {}
      )
      response = object({
        time = number
        code = number
      })
      options_list = object({
        tick_every = number
        retry = object({
          count    = number
          interval = number
        })
        monitor_options = object({
          renotify_interval = number
        })
        scheduling = optional(
          object({
            days     = list(number)
            from     = string
            to       = string
            timezone = string
          })
        )
      })
      status = string
    })
  )
}

variable "is_mention_channel" {
  type = bool
}

variable "notify_slack_channel" {
  type = string
}

variable "pagerduty_service" {
  type = string
  default = ""
}
