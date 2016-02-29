require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "john", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "email should be between bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid addreses" do
    valid_addresses = %w[user@eee.com R_TDD@eee.hello.org user@example.com first.last@eeem.au laura+joe@monk.cm]
    valid_addresses.each do |address|
      @chef.email = address
      assert @chef.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addreses" do
    invalid_addresses = %w[user@eee,com R_TDD_at_eee_org user.name@example. eee@i_am_.com laura@monk+aar.cm]
    invalid_addresses.each do |address|
      @chef.email = address
      assert_not @chef.valid?, "#{address.inspect} should not be valid"
    end
  end

end