class Ability
  include CanCan::Ability

  def initialize user
    return can :read, [Tour, Review] if user.blank?
    return can :manage, :all if user.admin?
    can :read, [Tour, Review]
    can :create, [Review, Comment, Like, Booking]
    can [:read, :edit, :update, :destroy], Review, user_id: user.id
    can :destroy, Like, user_id: user.id
    can [:index, :change_status], Booking, user_id: user.id
  end
end
