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

  describe "acceptance tests" do
    test "verify String handling" do
      assert Crimpex.signature("abc") == "c4449120506d97975c67be69719a78e2"
    end

    test "verify integers handling" do
      assert Crimpex.signature(1) == "594170053719896a11eb08ee513813d5"
    end

    test "verify floats handling" do
      assert Crimpex.signature(1.2) == "f1ab6592886cd4b1b66ed55e73d9ab81"
    end
    test "verify Array handling" do
      assert Crimpex.signature([1, "a", 3]) == "cd1c43797d488d0f6c0d71537c64d30b"
    end

    test "verify Array sorting" do
      assert Crimpex.signature([3, nil, 1, "1"]) == "518e7bb17674f6acbb296845862a152d"
    end

    test "verify Array sorting with capital letters" do
      assert Crimpex.signature(["a", "A", "b", "B"]) == "f6692ab4bc94b35e61ec15c2d1891734"
    end

    test "verify nested Arrays" do
      assert Crimpex.signature(["a", 1, ["b", "2"]]) == "3aaa58da4841eaeb41d3726d2c6fd875"
    end

    test "verify nested Arrays in another order" do
      assert Crimpex.signature([["b", "2"], "a", 1]) == "3aaa58da4841eaeb41d3726d2c6fd875"
    end

    test "verify hash like data structures" do
      assert Crimpex.signature(%{"a" => 1}) == "8cb44d69badda0f34b0bab6bb3e7fdbf"
    end

    test "verify nested hash" do
      assert Crimpex.signature(%{"a" => %{"c" => nil, "2" => 2 }}) == "bff3538075e4007c7679a7ba0d0a5f30"
    end

    test "verify null values" do
      assert Crimpex.signature(nil) == "b14a7b8059d9c055954c92674ce60032"
    end

    test "verify true boolean values" do
      assert Crimpex.signature(true) == "6413cfeb7a89f7e0a8872f82b919c0d9"
    end

    test "verify false boolean values" do
      assert Crimpex.signature(false) == "fa39253035cfe44c8638b8f5d7a3402e"
    end
  end
end