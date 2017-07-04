class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    @user && @user.id == @record.id ? true : false
    # scope.where(:id => record.id).exists?
  end

  def edit?
    @user && @user.id == @record.id ? true : false
  end

  def update?
    @user && @user.id == @record.id ? true : false
  end

  # def destroy?
  #   false
  # end
  #
  # def create?
  #   false
  # end
  #
  # def new?
  #   create?
  # end
  #

  #
  # def index?
  #   false
  # end

  # def scope
  #   Pundit.policy_scope!(user, record.class)
  # end
  #
  # class Scope
  #   attr_reader :user, :scope
  #
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     scope
  #   end
  # end
end
