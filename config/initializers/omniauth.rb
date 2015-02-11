Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :coinbase, '694fc2f618facf30b3b41726ee6d0ac04c650669ca3d114cb0bae4223cecade3', '3e7cfd07d829211ac50dd6486fe677ca76e965f25ad7d68e67e845e0d4a213e7', scope: 'user,balance,addresses,send:bypass_2fa,transfer,transactions'
end