Cuando /^estoy en la pagina (.+)$/ do |page_name|
  When "I go to #{page_name}"
end

#FIXME these does not seem to be getting loaded, regexp should be collapsing
#TODO clean out all visit steps into dryer one
# Cuando /^visito la pagina de ([\"]+)$/ do |page_name|
#   When "I go to #{page_name}"
# end

Cuando /^hago click en "(.*)"$/ do |link|
  When "I follow \"#{link}\""
end

Cuando /^hago click en el link ([^\"]*)$/ do |link|
  Cuando %{hago click en "#{link}"}
end

Cuando /^presiono "(.+)"$/ do |button|
  When %{I press "#{button}"}
end

Cuando /^selecciono "(.+)" de "(.*)"$/ do |value, field|
  When "I select \"#{value}\" from \"#{field}\""
end

Cuando /^relleno "(.+)" con "(.+)"$/ do |field, value|
  When "I fill in \"#{field}\" with \"#{value}\""
end

Cuando /^relleno los campos:$/ do |fields_table|
  fields_table.hashes.each do |field_hash|
    When "I fill in \"#{field_hash['campo']}\" with \"#{field_hash['valor']}\""
  end
end

# esta forma verbal del debe es porque no logro poner en primera persona los
# steps del scenario de registro de chequeo de mails
Entonces /^debe ver "([^\"]*)"$/ do |text|
  Then "I should see \"#{text}\""
end

Entonces /^debo ver "(.*)"$/ do |text|
  Then "I should see \"#{text}\""
end

Entonces /^debo ver:$/ do |text_table|
  text_table.hashes.each do |text_hash|
    Entonces %{debo ver "#{text_hash['texto']}"}
  end
end

Entonces /^no debo ver "(.*)"$/ do |text|
  Then "I should not see \"#{text}\""
end

Entonces /^debo ver el link "(.+)"$/ do |link|
  Then "I should see the link #{link}"
end

Entonces /^no debo ver el link "(.+)"$/ do |link|
  Then "I should not see the link #{link}"
end

Entonces /^debo ver los links:$/ do |links_table|
  Then "I should see the links:", links_table
end

Entonces /^no debo ver los links:$/ do |links_table|
  Then "I should not see the links:", links_table
end

Entonces /^debo llegar a la (.+)$/ do |page_name|
  Then "I should be on #{page_name}"
end

Entonces /^debo ver los campos obligatorios:$/ do |table|
  table.hashes.each do |row|
    Entonces %{entonces debo ver el campo "#{row['campo']}*"}
  end
end

Entonces /^entonces debo ver el campo "(.+)"$/ do |campo|
  response.should have_tag("label", :text => campo)
end

Entonces /^debo ver el botón "([^\"]*)"$/ do |boton|
  response.should have_tag("input[type=submit][value='#{boton}']")
end

Entonces /^no debo ver los campos:$/ do |table|
  table.hashes.each do |row|
    response.should_not have_tag("label", :text => row['campo'])
  end
end

Cuando /^marco "([^\"]*)"$/ do |field|
  check(field)
end

Cuando /^no marco "([^\"]*)"$/ do |field|
  uncheck(field)
end

Entonces /^debo ver campo "([^\"]*)" con texto "([^\"]*)"$/ do |field, text|
  response.should have_tag('p', /#{text}/) do
    with_tag('strong', /#{field}/)
  end
end
