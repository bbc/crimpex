defmodule CrimpexTest do
  use ExUnit.Case

  describe "signature" do
    test "when given a nil value it returns the correct signature" do
      assert Crimpex.signature(nil) == "b14a7b8059d9c055954c92674ce60032"
    end

    test "when given a single string it returns the correct signature" do
      assert Crimpex.signature("abc") == "c4449120506d97975c67be69719a78e2"
    end

    test "when given a single integer it returns the correct signature" do
      assert Crimpex.signature(1) == "594170053719896a11eb08ee513813d5"
    end
  end
end