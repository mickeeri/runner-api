require 'test_helper'

class DevelopersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @developer = developers(:mikael)
    @admin = developers(:admin)
  end

  # test "index of developers should be paginated" do
  #   log_in_as(@admin)
  #   get developers_path
  #   assert_template 'developers/index'
  #   assert_select 'div.pagination'
  #   Developer.paginate(page: 1).each do |developer|
  #     assert_select 'a[href=?]', developer_path(developer), text: developer.name
  #   end
  # end

  test "index as admin should include delete links and be paginated" do
    log_in_as(@admin)
    get developers_path
    assert_template 'developers/index'
    assert_select 'div.pagination'
    Developer.paginate(page: 1).each do |developer|
      assert_select 'a[href=?]', developer_path(developer), text: developer.name
      unless developer == @admin
        assert_select 'a[href=?]', developer_path(developer), class: 'delete'
      end
    end
    # Check if developer is removed if admin request to remove developer.
    assert_difference 'Developer.count', -1 do
      delete developer_path(@developer)
    end
  end

  # test "index as non-admin shuld not display delete links" do
  #   log_in_as(@developer)
  #   get developers_path
  #   assert_select 'a', text: 'Ta bort', count: 0
  # end
end
