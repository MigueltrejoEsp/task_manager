defmodule TaskManager.Repo.Migrations.AddedMemberships do
  @moduledoc """
  Updates resources based on their most recent snapshots.
  """

  use Ecto.Migration

  def up do
    create table(:memberships, primary_key: false) do
      add :user_id, references(:users, column: :id, name: "memberships_user_id_fkey", type: :uuid)

      add :organization_id,
          references(:organizations,
            column: :id,
            name: "memberships_organization_id_fkey",
            type: :uuid
          )

      add :updated_at, :utc_datetime_usec, null: false
      add :inserted_at, :utc_datetime_usec, null: false
      add :joined_at, :utc_datetime_usec, null: false
      add :role, :text
      add :id, :uuid, null: false, primary_key: true
    end

    create unique_index(:memberships, [:organization_id, :user_id, :organization_id],
             name: "memberships_unique_membership_index"
           )
  end

  def down do
    drop_if_exists unique_index(:memberships, [:organization_id, :user_id, :organization_id],
                     name: "memberships_unique_membership_index"
                   )

    raise "SQLite does not support dropping foreign key constraints. " <>
            "You will need to manually recreate the `memberships` table without the `memberships_organization_id_fkey` constraint. " <>
            "See https://www.techonthenet.com/sqlite/foreign_keys/drop.php for guidance."

    raise "SQLite does not support dropping foreign key constraints. " <>
            "You will need to manually recreate the `memberships` table without the `memberships_user_id_fkey` constraint. " <>
            "See https://www.techonthenet.com/sqlite/foreign_keys/drop.php for guidance."

    drop table(:memberships)
  end
end
