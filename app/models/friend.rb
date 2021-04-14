class Friend < ApplicationRecord
	def not_friends
		potential = []
		User.all.each do |user|
			if(self.friends_with?(user) != true && self != user && self.friends.include?(user) != true && self.pending_friends.include?(user) != true && self.requested_friends.include?(user) != true)
				potential << user
			end
		end
		potential
	end
	def self.friends_with(friend)
		find_relation(self, friend, status: 2).any?

    end
    def self.find_relation(friendable, friend, status: nil)
      where relation_attributes(friendable, friend, status: status)
    end
 def self.relation_attributes(one, other, status: nil)
      attr = {
        friendable_id: one.id,
        friendable_type: one.class.base_class.name,
        friend_id: other.id
      }

      if status
        attr[:status] = status
      end

      attr
    end
end
