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
      })
      request_headers = optional(object({
        Authorization = optional(string)
      }))
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
      })
      status  = string
    })
  )
}

variable "is_mention_channel" {
  type = bool
}

variable "notify_slack_channel" {
  type = string
}