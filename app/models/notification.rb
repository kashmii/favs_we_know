class Notification < ApplicationRecord
  #スコープ(新着順)
	default_scope->{order(created_at: :desc)}

  belongs_to :member_request, optional: true
  belongs_to :room_report, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
