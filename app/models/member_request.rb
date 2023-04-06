class MemberRequest < ApplicationRecord

  belongs_to :applicant, class_name: 'User', foreign_key: :appricant_id
  belongs_to :room
  has_many :notifications, dependent: :destroy

  enum status: {
    pending: 0,
    allowed: 1,
    denied: 2,
  }, _prefix: true

  def allowed!
    transaction do
      status_allowed!
      checked_and_make_notification

      # 新メンバーにroom_idを付与
      new_member = User.find(appricant_id)
      new_member.update!(room_id: room_id)
    end
  end

  def denied!
    transaction do
      status_denied!
      checked_and_make_notification
    end
  end

  private

  def checked_and_make_notification
    # 元の通知をcheckedにする
    this_notification = Notification.find_by(
      visitor_id: appricant_id,
      visited_id: room.room_founder.founder_id
    )
    this_notification.update!(checked: 1)

    # OK/Noを伝えるための通知作成
    new_notification = self.notifications.build(
      visitor_id: room.room_founder.founder_id,
      visited_id: appricant_id,
      action: 'request_answer'
    )
    new_notification.save!
  end
end
