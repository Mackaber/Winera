ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
    :address              => "smtp.zoho.com",
    :port                 => 23,
    :user_name            => "cuentas@winero.mx",
    :password             => "wineroftw",
    :authentication       => :login,
    :ssl                  => true,
    :tls                  => true,
    :enable_starttls_auto => true
}