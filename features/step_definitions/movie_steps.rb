# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    m = Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/,/).each do |rating|
    if uncheck then
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see (all|none) of the movies/ do |all_none|
  expected = all_none.eql?("all") ? Movie.count : -1
  page_body = page.body.gsub(/\n/, "").downcase
  page_body =~ /<table id="movies"><thead>.*?<\/thead><tbody>(.*?)<\/tbody/
  #puts "VAR 1: #{$1.split(/<tr>/).count - 1}"
  #puts "ALL OR NONE: #{all_none}"
  assert $1.split(/<tr>/).count - 1 == expected
end