class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #

    #TODO: Definir De manera correcta CanCan y las habilidades de los usuarios y del admin
       user ||= User.new # guest user (not logged in)
       if user.role == "GOD"
         can :manage, :all
       else
         if user.role == "bizowner"
           can :show
           can :confirm
           can :create, Business
           can :update, Business do |business|
             business.try(:user) == user
           end
           can :destroy, Business do |business|
             business.try(:user) == user
           end
           can :history, Business
         else
           can :register
           can :show, Card
         end
       end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
