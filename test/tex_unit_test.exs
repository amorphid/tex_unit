defmodule TexUnitTest do
  use TexUnit

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

  @flag banana: true
  it "Flag equals [banana: true]" do
    assert @__flag__  == [banana: true]
  end

  @flag :banana
  describe "Flag" do
    it "equals [banana: true]" do
      assert @__flag__ == [banana: true]
    end

    @flag :boat
    it "equals [banana: true, boat: true]" do
      assert @__flag__ == [banana: true, boat: true]
    end

    @flag banana: false
    it "equals [banana: false]" do
      assert @__flag__ == [banana: false]
    end
  end

  describe "Nested" do
    @flag :banana
    describe "Flag 1" do
      it "equals [banana: true]" do
        assert @__flag__ == [banana: true]
      end
    end

    describe "Flag 2" do
      it "equals []" do
        assert @__flag__ == []
      end
    end
  end

  @flag banana: true
  describe "Outer flag" do
    @flag banana: false
    describe "is overridden by inner flag and" do
      @flag boat: true
      it "equals [banana: false, boat: true]" do
        assert @__flag__ == [banana: false, boat: true]
      end
    end
  end

  @flag banana: true, boat: true
  describe "2 outer flags" do
    @flag otter: true, seaweed: true
    it "equals [banana: true, boat: true, otter: true, seaweed: true]" do
      assert @__flag__ == [banana: true, boat: true, otter: true, seaweed: true]
    end
  end

  describe do
    it do
      assert :description_may_be_empty == :description_may_be_empty
    end
  end

  context "RSpec style \"context\" wrapped around" do
    describe "RSpec style \"describe\" wrapped around" do
      it "RSpec style \"it\" works" do
        assert :this_test_compiled == :this_test_compiled
      end
    end
  end

  describe "RSpec style \"describe\" wrapped around" do
    context "RSpec style \"context\" wrapped around" do
      it "RSpec style \"it\" works" do
        assert :this_test_compiled == :this_test_compiled
      end
    end
  end
end
