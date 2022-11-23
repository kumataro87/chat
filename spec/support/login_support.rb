module LoginSupport
  module System
    def log_in(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
  end

  module Request
    def log_in(user)
      post user_session_path params: { user: { email: user.email,
                                                  password: user.password}}
    end

    def logged_in?
      !session[:user_id].nil?
    end
  end
end
 
RSpec.configure do |config|
  config.include LoginSupport::System,  type: :system
  config.include LoginSupport::Request, type: :request

end