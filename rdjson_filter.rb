# frozen_string_literal: true
# original implementation: https://github.com/tk0miya/action-steep

require 'json'

DIAGNOSTIC_ENTRY = %r{^([^:]+):(\d+): (.*)\s+(https://srb.help/(\d{4}))$}.freeze
END_MARKER = /^(Errors: \d+|No errors! Great job.)$/.freeze

diagnostics = []

while (line = gets)
  case line
  when DIAGNOSTIC_ENTRY
    m = Regexp.last_match
    diagnostics << { path: m[1], line: m[2].to_i, messages: ["#{m[3]}\n"], url: m[4], code: m[5] }
  when END_MARKER
    break
  else
    diagnostics.last[:messages] << line if diagnostics.last
  end
end

rdjson = {
  source: {
    name: 'sorbet',
    url: 'https://github.com/sorbet/sorbet',
  },
  severity: 'ERROR',
  diagnostics:
    diagnostics.map do |d|
      {
        message: d[:messages].join.strip,
        location: {
          path: d[:path],
          range: {
            start: {
              line: d[:line],
            },
          },
        },
        severity: 'ERROR',
        code: {
          value: d[:code],
          url: d[:url],
        },
      }
    end,
}

puts rdjson.to_json
