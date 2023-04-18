class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :room, optional: true
  has_one :member_request, foreign_key: :appricant_id, dependent: :destroy
  has_many :reports, foreign_key: :writer_id, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :name, presence: true, length: { in: 2..40 }
  validates :email, presence: true, length: { maximum: 255 }

  # 通知関連
  # 部屋申請時の通知
  def create_notification_member_request!(current_user, request)
    if current_user.request_allowed == true
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'member_request',
        member_request_id: request.id
      )
      notification.save if notification.valid?
    end
  end

  def destroy_notification_member_request!(current_user)
    notification = Notification.find_by(["visitor_id = ? and action = ? ", current_user.id, 'member_request'])
    notification.destroy
  end

end
