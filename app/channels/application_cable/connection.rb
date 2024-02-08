module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection unless find_verified_user
    end

    private

      def find_verified_user
        if verified_user = User.find_by(id: cookies.encrypted[:user_id])
          self.current_user = env['warden'].user
        else
          reject_unauthorized_connection
        end
        
      end
  end
end
