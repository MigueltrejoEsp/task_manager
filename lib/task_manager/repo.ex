defmodule TaskManager.Repo do
  use AshSqlite.Repo,
    otp_app: :task_manager
end
