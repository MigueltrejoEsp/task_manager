defmodule TaskManager.Organizations.Membership do
  use Ash.Resource,
    otp_app: :task_manager,
    domain: TaskManager.Organizations,
    data_layer: AshSqlite.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshAuthentication]

  sqlite do
    table "memberships"
    repo TaskManager.Repo
  end

  multitenancy do
    strategy :attribute
    attribute :organization_id
  end

  actions do
    defaults [:read, :destroy, create: [:role, :user_id, :organization_id], update: []]
  end

  attributes do
    uuid_primary_key :id

    attribute :role, :atom do
      constraints one_of: [:owner, :admin, :member]
      default :member
      public? true
    end


    attribute :joined_at, :utc_datetime_usec do
      default &DateTime.utc_now/0
      allow_nil? false
      public? true
    end

    timestamps()
  end

  identities do
    identity :unique_membership, [:user_id, :organization_id]
  end

  relationships do
    belongs_to :organization, TaskManager.Organizations.Organization
    belongs_to :user, TaskManager.Accounts.User
  end
end
