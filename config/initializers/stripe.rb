Rails.configuration.stripe = {
  :publishable_key => 'pk_test_tVfU51CqRgQJDbA8AkNADxOI',
  :secret_key      => 'sk_test_f3Bg9B9plFggI2jqau5bcvd6'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]