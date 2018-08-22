defmodule ExCakning.CofnigTest do
  use ExUnit.Case
  alias ExCakning.Config

  setup do
    on_exit(fn ->
      Application.put_env(:ex_cakning, :base_url, nil)
      Application.put_env(:ex_cakning, :api_key, {:system, "EX_CAKNING_API_KEY"})
    end)

    :ok
  end

  describe "ExCakning.Cofnig.base_url/0" do
    test "It should have a string from config(:ex_cakning)" do
      Application.put_env(:ex_cakning, :base_url, "https://example.com/")
      assert Config.base_url() === "https://example.com/"
    end

    test "It should has values from system environment" do
      System.put_env("TEST_ENV_BASE_URL", "https://example.com/")
      Application.put_env(:ex_cakning, :base_url, {:system, "TEST_ENV_BASE_URL"})
      assert Config.base_url() === "https://example.com/"
    end

    test "It should has base_url by default" do
      Application.put_env(:ex_cakning, :base_url, nil)
      assert Config.base_url() === "https://api.cakning.com/"
    end
  end

  describe "ExCakning.Cofnig.api_key/0" do
    test "It should have a string from config(:ex_cakning)" do
      Application.put_env(:ex_cakning, :api_key, "some api key")
      assert Config.api_key() === "some api key"
    end

    test "It should has values from system environment" do
      System.put_env("TEST_ENV_API_KEY", "some api key")
      Application.put_env(:ex_cakning, :api_key, {:system, "TEST_ENV_API_KEY"})
      assert Config.api_key() === "some api key"
    end
  end
end
