# TODO Configure rack-attack gem
# https://expeditedsecurity.com/blog/ultimate-guide-to-rack-attack/

class Rack::Attack
  throttle("ahoy/ip", limit: 20, period: 1.minute) do |req|
    if req.path.start_with?("/ahoy/")
      req.ip
    end
  end
end