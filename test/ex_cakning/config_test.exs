defmodule ExCakning.CofnigTest do
  use ExUnit.Case
  alias ExCakning.Config

  describe "ExCakning.Cofnig.new" do
    setup do
      on_exit(fn ->
        Application.put_env(:ex_cakning, :base_url, nil)
        Application.put_env(:ex_cakning, :api_key, {:system, "EX_CAKNING_API_KEY"})
      end)

      :ok
    end

    test "It should has values from config(:ex_confning)" do
      Application.put_env(:ex_cakning, :base_url, "https://example.com")
      Application.put_env(:ex_cakning, :api_key, "some api key")
      assert %Config{} = config = Config.new()
      assert config.base_url === "https://example.com"
      assert config.api_key === "some api key"
    end

    test "It should has values from system environment" do
      System.put_env("TEST_ENV_BASE_URL", "https://example.com")
      System.put_env("TEST_ENV_API_KEY", "some api key")
      Application.put_env(:ex_cakning, :base_url, {:system, "TEST_ENV_BASE_URL"})
      Application.put_env(:ex_cakning, :api_key, {:system, "TEST_ENV_API_KEY"})
      assert %Config{} = config = Config.new()
      assert config.base_url === "https://example.com"
      assert config.api_key === "some api key"
    end

    test "It should has base_url by default" do
      Application.put_env(:ex_cakning, :base_url, nil)
      Application.put_env(:ex_cakning, :api_key, "some api key")
      assert %Config{} = config = Config.new()
      assert config.base_url === "https://api.cakning.com/"
    end
  end
end
