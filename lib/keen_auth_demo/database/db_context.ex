# This code has been auto-generated
# Changes to this file will be lost on next generation

defmodule KeenAuthDemo.Database.DbContext do
  @moduledoc """
  This module contains functions for calling DB's stored procedures.
  Functions of this module uses `query/2` function of Repo that you have provided (`db_config` key of configuration)
  """

  require Logger

  import Elixir.KeenAuthDemo.Repo, only: [query: 2]

  @spec auth_ensure_user_from_provider(
          binary(),
          binary(),
          binary(),
          binary(),
          binary(),
          binary(),
          any()
        ) ::
          {:error, any()}
          | {:ok, [KeenAuthDemo.Database.Models.AuthEnsureUserFromProviderItem.t()]}
  def auth_ensure_user_from_provider(
        created_by,
        provider,
        provider_uid,
        username,
        display_name,
        email,
        user_data
      ) do
    Logger.debug("Calling stored procedure", procedure: "ensure_user_from_provider")

    query(
      "select * from auth.ensure_user_from_provider($1, $2, $3, $4, $5, $6, $7)",
      [created_by, provider, provider_uid, username, display_name, email, user_data]
    )
    |> KeenAuthDemo.Database.Parsers.AuthEnsureUserFromProviderParser.parse_auth_ensure_user_from_provider_result()
  end

  @spec auth_get_tenant_permissions(binary(), integer()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.AuthGetTenantPermissionsItem.t()]}
  def auth_get_tenant_permissions(tenant_code, user_id) do
    Logger.debug("Calling stored procedure", procedure: "get_tenant_permissions")

    query(
      "select * from auth.get_tenant_permissions($1, $2)",
      [tenant_code, user_id]
    )
    |> KeenAuthDemo.Database.Parsers.AuthGetTenantPermissionsParser.parse_auth_get_tenant_permissions_result()
  end

  @spec auth_get_user_random_code() :: {:error, any()} | {:ok, [binary()]}
  def auth_get_user_random_code() do
    Logger.debug("Calling stored procedure", procedure: "get_user_random_code")

    query(
      "select * from auth.get_user_random_code()",
      []
    )
    |> KeenAuthDemo.Database.Parsers.AuthGetUserRandomCodeParser.parse_auth_get_user_random_code_result()
  end

  @spec auth_update_user_data(binary(), integer(), binary(), any()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.AuthUpdateUserDataItem.t()]}
  def auth_update_user_data(created_by, user_id, provider, user_data) do
    Logger.debug("Calling stored procedure", procedure: "update_user_data")

    query(
      "select * from auth.update_user_data($1, $2, $3, $4)",
      [created_by, user_id, provider, user_data]
    )
    |> KeenAuthDemo.Database.Parsers.AuthUpdateUserDataParser.parse_auth_update_user_data_result()
  end

  @spec add_journal_msg(
          binary(),
          integer(),
          integer(),
          binary(),
          binary(),
          integer(),
          any(),
          integer()
        ) :: {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.AddJournalMsgItem.t()]}
  def add_journal_msg(
        created_by,
        tenant_id,
        user_id,
        msg,
        data_group,
        data_object_id,
        payload,
        event_id
      ) do
    Logger.debug("Calling stored procedure", procedure: "add_journal_msg")

    query(
      "select * from public.add_journal_msg($1, $2, $3, $4, $5, $6, $7, $8)",
      [created_by, tenant_id, user_id, msg, data_group, data_object_id, payload, event_id]
    )
    |> KeenAuthDemo.Database.Parsers.AddJournalMsgParser.parse_add_journal_msg_result()
  end

  @spec add_journal_msg_jsonb(
          binary(),
          integer(),
          integer(),
          binary(),
          binary(),
          integer(),
          any(),
          integer()
        ) :: {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.AddJournalMsgJsonbItem.t()]}
  def add_journal_msg_jsonb(
        created_by,
        tenant_id,
        user_id,
        msg,
        data_group,
        data_object_id,
        payload,
        event_id
      ) do
    Logger.debug("Calling stored procedure", procedure: "add_journal_msg_jsonb")

    query(
      "select * from public.add_journal_msg_jsonb($1, $2, $3, $4, $5, $6, $7, $8)",
      [created_by, tenant_id, user_id, msg, data_group, data_object_id, payload, event_id]
    )
    |> KeenAuthDemo.Database.Parsers.AddJournalMsgJsonbParser.parse_add_journal_msg_jsonb_result()
  end

  @spec add_user_group_member(integer(), binary(), integer(), integer(), integer()) ::
          {:error, any()} | {:ok, [integer()]}
  def add_user_group_member(user_id, created_by, tenant_id, ug_id, user_member_id) do
    Logger.debug("Calling stored procedure", procedure: "add_user_group_member")

    query(
      "select * from public.add_user_group_member($1, $2, $3, $4, $5)",
      [user_id, created_by, tenant_id, ug_id, user_member_id]
    )
    |> KeenAuthDemo.Database.Parsers.AddUserGroupMemberParser.parse_add_user_group_member_result()
  end

  @spec create_permission_by_code(binary(), integer(), binary(), binary(), boolean()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.CreatePermissionByCodeItem.t()]}
  def create_permission_by_code(created_by, user_id, title, parent_code, is_assignable) do
    Logger.debug("Calling stored procedure", procedure: "create_permission_by_code")

    query(
      "select * from public.create_permission_by_code($1, $2, $3, $4, $5)",
      [created_by, user_id, title, parent_code, is_assignable]
    )
    |> KeenAuthDemo.Database.Parsers.CreatePermissionByCodeParser.parse_create_permission_by_code_result()
  end

  @spec create_permission_by_path(binary(), integer(), binary(), binary(), binary(), boolean()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.CreatePermissionByPathItem.t()]}
  def create_permission_by_path(
        created_by,
        user_id,
        data_node_path,
        title,
        parent_path,
        is_assignable
      ) do
    Logger.debug("Calling stored procedure", procedure: "create_permission_by_path")

    query(
      "select * from public.create_permission_by_path($1, $2, $3, $4, $5, $6)",
      [created_by, user_id, data_node_path, title, parent_path, is_assignable]
    )
    |> KeenAuthDemo.Database.Parsers.CreatePermissionByPathParser.parse_create_permission_by_path_result()
  end

  @spec create_user_group(integer(), binary(), integer(), binary(), boolean(), boolean()) ::
          {:error, any()} | {:ok, [integer()]}
  def create_user_group(user_id, created_by, tenant_id, title, is_assignable, is_active) do
    Logger.debug("Calling stored procedure", procedure: "create_user_group")

    query(
      "select * from public.create_user_group($1, $2, $3, $4, $5, $6)",
      [user_id, created_by, tenant_id, title, is_assignable, is_active]
    )
    |> KeenAuthDemo.Database.Parsers.CreateUserGroupParser.parse_create_user_group_result()
  end

  @spec delete_user_group(integer(), binary(), integer(), integer()) ::
          {:error, any()} | {:ok, [integer()]}
  def delete_user_group(user_id, deleted_by, tenant_id, ug_id) do
    Logger.debug("Calling stored procedure", procedure: "delete_user_group")

    query(
      "select * from public.delete_user_group($1, $2, $3, $4)",
      [user_id, deleted_by, tenant_id, ug_id]
    )
    |> KeenAuthDemo.Database.Parsers.DeleteUserGroupParser.parse_delete_user_group_result()
  end

  @spec delete_user_group_member(integer(), binary(), integer(), integer(), integer()) ::
          {:error, any()} | {:ok, [any()]}
  def delete_user_group_member(user_id, created_by, tenant_id, ug_id, user_member_id) do
    Logger.debug("Calling stored procedure", procedure: "delete_user_group_member")

    query(
      "select * from public.delete_user_group_member($1, $2, $3, $4, $5)",
      [user_id, created_by, tenant_id, ug_id, user_member_id]
    )
    |> KeenAuthDemo.Database.Parsers.DeleteUserGroupMemberParser.parse_delete_user_group_member_result()
  end

  @spec ensure_groups_and_permissions(binary(), any()) ::
          {:error, any()}
          | {:ok, [KeenAuthDemo.Database.Models.EnsureGroupsAndPermissionsItem.t()]}
  def ensure_groups_and_permissions(oid, provider_groups) do
    Logger.debug("Calling stored procedure", procedure: "ensure_groups_and_permissions")

    query(
      "select * from public.ensure_groups_and_permissions($1, $2)",
      [oid, provider_groups]
    )
    |> KeenAuthDemo.Database.Parsers.EnsureGroupsAndPermissionsParser.parse_ensure_groups_and_permissions_result()
  end

  @spec get_journal_msgs(integer(), integer(), DateTime.t(), DateTime.t()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.GetJournalMsgsItem.t()]}
  def get_journal_msgs(tenant_id, user_id, from, to) do
    Logger.debug("Calling stored procedure", procedure: "get_journal_msgs")

    query(
      "select * from public.get_journal_msgs($1, $2, $3, $4)",
      [tenant_id, user_id, from, to]
    )
    |> KeenAuthDemo.Database.Parsers.GetJournalMsgsParser.parse_get_journal_msgs_result()
  end

  @spec get_journal_payload(integer(), integer(), integer()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.GetJournalPayloadItem.t()]}
  def get_journal_payload(tenant_id, user_id, journal_id) do
    Logger.debug("Calling stored procedure", procedure: "get_journal_payload")

    query(
      "select * from public.get_journal_payload($1, $2, $3)",
      [tenant_id, user_id, journal_id]
    )
    |> KeenAuthDemo.Database.Parsers.GetJournalPayloadParser.parse_get_journal_payload_result()
  end

  @spec get_tenant_id(binary()) :: {:error, any()} | {:ok, [integer()]}
  def get_tenant_id(tenant_code) do
    Logger.debug("Calling stored procedure", procedure: "get_tenant_id")

    query(
      "select * from public.get_tenant_id($1)",
      [tenant_code]
    )
    |> KeenAuthDemo.Database.Parsers.GetTenantIdParser.parse_get_tenant_id_result()
  end

  @spec get_user_by_username(integer(), binary()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.GetUserByUsernameItem.t()]}
  def get_user_by_username(tenant_id, username) do
    Logger.debug("Calling stored procedure", procedure: "get_user_by_username")

    query(
      "select * from public.get_user_by_username($1, $2)",
      [tenant_id, username]
    )
    |> KeenAuthDemo.Database.Parsers.GetUserByUsernameParser.parse_get_user_by_username_result()
  end

  @spec get_user_verification(binary(), binary()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.GetUserVerificationItem.t()]}
  def get_user_verification(tenant_code, username) do
    Logger.debug("Calling stored procedure", procedure: "get_user_verification")

    query(
      "select * from public.get_user_verification($1, $2)",
      [tenant_code, username]
    )
    |> KeenAuthDemo.Database.Parsers.GetUserVerificationParser.parse_get_user_verification_result()
  end

  @spec has_permission(integer(), integer(), binary(), boolean()) ::
          {:error, any()} | {:ok, [boolean()]}
  def has_permission(tenant_id, user_id, perm_code, throw_err) do
    Logger.debug("Calling stored procedure", procedure: "has_permission")

    query(
      "select * from public.has_permission($1, $2, $3, $4)",
      [tenant_id, user_id, perm_code, throw_err]
    )
    |> KeenAuthDemo.Database.Parsers.HasPermissionParser.parse_has_permission_result()
  end

  @spec has_permission_1(binary(), integer(), binary(), boolean()) ::
          {:error, any()} | {:ok, [boolean()]}
  def has_permission_1(tenant_code, user_id, perm_code, throw_err) do
    Logger.debug("Calling stored procedure", procedure: "has_permission")

    query(
      "select * from public.has_permission($1, $2, $3, $4)",
      [tenant_code, user_id, perm_code, throw_err]
    )
    |> KeenAuthDemo.Database.Parsers.HasPermission1Parser.parse_has_permission_1_result()
  end

  @spec load_initial_data() :: {:error, any()} | {:ok, [integer()]}
  def load_initial_data() do
    Logger.debug("Calling stored procedure", procedure: "load_initial_data")

    query(
      "select * from public.load_initial_data()",
      []
    )
    |> KeenAuthDemo.Database.Parsers.LoadInitialDataParser.parse_load_initial_data_result()
  end

  @spec register_user(binary(), binary(), binary(), binary(), binary(), binary()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.RegisterUserItem.t()]}
  def register_user(tenant_code, username, password_hash, email, display_name, user_data) do
    Logger.debug("Calling stored procedure", procedure: "register_user")

    query(
      "select * from public.register_user($1, $2, $3, $4, $5, $6)",
      [tenant_code, username, password_hash, email, display_name, user_data]
    )
    |> KeenAuthDemo.Database.Parsers.RegisterUserParser.parse_register_user_result()
  end

  @spec throw_no_access(integer(), binary()) :: {:error, any()} | {:ok, [any()]}
  def throw_no_access(tenant_id, username) do
    Logger.debug("Calling stored procedure", procedure: "throw_no_access")

    query(
      "select * from public.throw_no_access($1, $2)",
      [tenant_id, username]
    )
    |> KeenAuthDemo.Database.Parsers.ThrowNoAccessParser.parse_throw_no_access_result()
  end

  @spec throw_no_permission(integer(), integer(), binary()) :: {:error, any()} | {:ok, [any()]}
  def throw_no_permission(tenant_id, user_id, perm_code) do
    Logger.debug("Calling stored procedure", procedure: "throw_no_permission")

    query(
      "select * from public.throw_no_permission($1, $2, $3)",
      [tenant_id, user_id, perm_code]
    )
    |> KeenAuthDemo.Database.Parsers.ThrowNoPermissionParser.parse_throw_no_permission_result()
  end

  @spec update_permission_full_code(any()) ::
          {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.UpdatePermissionFullCodeItem.t()]}
  def update_permission_full_code(perm_path) do
    Logger.debug("Calling stored procedure", procedure: "update_permission_full_code")

    query(
      "select * from public.update_permission_full_code($1)",
      [perm_path]
    )
    |> KeenAuthDemo.Database.Parsers.UpdatePermissionFullCodeParser.parse_update_permission_full_code_result()
  end

  @spec update_permission_full_title(any()) ::
          {:error, any()}
          | {:ok, [KeenAuthDemo.Database.Models.UpdatePermissionFullTitleItem.t()]}
  def update_permission_full_title(perm_path) do
    Logger.debug("Calling stored procedure", procedure: "update_permission_full_title")

    query(
      "select * from public.update_permission_full_title($1)",
      [perm_path]
    )
    |> KeenAuthDemo.Database.Parsers.UpdatePermissionFullTitleParser.parse_update_permission_full_title_result()
  end

  @spec update_user_group(
          integer(),
          binary(),
          integer(),
          integer(),
          binary(),
          boolean(),
          boolean()
        ) :: {:error, any()} | {:ok, [KeenAuthDemo.Database.Models.UpdateUserGroupItem.t()]}
  def update_user_group(user_id, modified_by, tenant_id, ug_id, title, is_assignable, is_active) do
    Logger.debug("Calling stored procedure", procedure: "update_user_group")

    query(
      "select * from public.update_user_group($1, $2, $3, $4, $5, $6, $7)",
      [user_id, modified_by, tenant_id, ug_id, title, is_assignable, is_active]
    )
    |> KeenAuthDemo.Database.Parsers.UpdateUserGroupParser.parse_update_user_group_result()
  end
end