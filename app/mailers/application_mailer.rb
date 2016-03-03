class ApplicationMailer < ActionMailer::Base
  default from: ENV["RESERVATION_EMAIL"]
  layout 'mailer'
end
