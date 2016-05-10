defmodule TexasUnitTest do
  use TexasUnit

  test "ExUnit style \"test\" works" do
    assert :this_test_compiled == :this_test_compiled
  end

  it "RSpec style \"it\" works" do
    assert :this_test_compiled == :this_test_compiled
  end

  describe "RSpec style \"describe\" wrapped around" do
    it "RSpec style \"it\" works" do
      assert :this_test_compiled == :this_test_compiled
    end
  end

  describe "RSpec style \"describe\" wrapped around" do
    describe "RSpec style \"describe\" wrapped around" do
      it "RSpec style \"it\" works" do
        assert :this_test_compiled == :this_test_compiled
      end
    end
  end
end
