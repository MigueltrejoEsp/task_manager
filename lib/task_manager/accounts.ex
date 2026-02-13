defmodule TaskManager.Accounts do
  use Ash.Domain,
    otp_app: :task_manager

  resources do
    resource TaskManager.Accounts.Token
    resource TaskManager.Accounts.User
  end
end
