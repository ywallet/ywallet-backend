class Ability
  include CanCan::Ability

  def initialize(account)
    account ||= Account.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    if account.is_manager?

        puts "MANAGER MANAGER MANAGER MANAGER"
        #manager pode consultar os seus dados da sua conta e alterá-los
        can :read, Manager, :id => account.manager_id
        can :update, Manager, :id => account.manager_id   

        #manager pode consultar e alterar os dados dos seus filhos
        can :crud, Child, :manager_id => account.manager_id

        #manager pode criar, ler, atualizar, destruir regras do(s) filho(s)
        can :crud, Rule, :account => { :child_id => account.manager.child_ids }

        #manager pode criar e atualizar tokens do coinbase
        can :crud, BitcoinAccount, :account_id => account.id

    elsif account.is_child?       # is_children

        puts "CHILD CHILD CHILD CHILD"
        #crianca pode consultar os seus dados da sua conta e alterá-los
        can :read, Child, :id => account.child_id
        can :update, Child, :id => account.child_id

        #crianca pode consultar os dados do seu manager
        can :read, Manager, :id => account.child.manager_id

        #crianca pode consultar as suas regras
        can :read, Rule, :account_id => account.id

        #crianca pode criar e atualizar poupanças
        can :crud, Saving, :child_id => account.child_id
        
    else

        puts "GUEST GUEST GUEST GUEST"
        can :create, Manager
        #can :create, Child
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
