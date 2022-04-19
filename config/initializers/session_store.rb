if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_classroom', domain: 'classroom-json-api'
  else
    Rails.application.config.session_store :cookie_store, key: '_classroom'
end