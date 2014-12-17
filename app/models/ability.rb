class Ability
  include CanCan::Ability

  def initialize(account)
    account ||= Account.new
    if account.is_manager?
        puts account.id
        puts account.manager_id
        puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        can :manage, Account, :id => account.id
        can :read, Manager, :id => account.manager_id
        can :manage, Child, :manager_id => account.manager_id
        can :read, Wallet, :account => { :child_id => account.manager.child_ids }
    elsif account.is_child?       # is_children
        can :manage, Account, :id => account.id
        can :read, Manager, :manager_id => account.child.manager_id
        can :manage, Child, :id => account.child_id
        can :manage, Wallet, :account_id => account.id
        puts "YYYYYYYYYYYYYYYYY"
    else
        puts "adasdasdasdasdasdsdasda"
        can :create, Manager
        can :create, Child
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
