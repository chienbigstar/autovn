module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :ip

    def connect
      if cookies[:token] && (user = User.find_by(token: cookies[:token]))
        self.current_user = user
        self.ip = cookies[:ip]
      else
        reject_unauthorized_connection
      end
    end
  end
end
