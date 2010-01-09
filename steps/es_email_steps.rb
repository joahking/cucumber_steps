Cuando /^"([^\"]*)" abre el email de activacion de cuenta$/ do |email|
  Cuando %{"#{email}" abre el email con asunto "Por favor active su nueva cuenta"}
end

Cuando /^"([^\"]*)" abre el email con asunto "([^\"]*)"$/ do |email, subject|
  When %{"#{email}" opens the email with subject "#{subject}"}
end

Cuando /^"([^\"]*)" hace click en "([^\"]*)" en el email$/ do |address, link|
  # address is passed for completeness, not used
  Cuando %{hago click en "#{link}" en el email}
end

Cuando /^hago click en "([^\"]*)" en el email$/ do |link|
  When %{I follow "#{link}" in the email}
end

Entonces /^"([^\"]*)" debe recibir (\d+) email de recuperación de contraseña$/ do |email, count|
  Entonces %{"#{email}" debe recibir 1 email con asunto "Cambio de contraseña"}
end

Cuando /^"([^\"]*)" abre el email de recuperación de contraseña$/ do |email|
  Cuando %{"#{email}" abre el email con asunto "Cambio de contraseña"}
end

Entonces /^"([^\"]*)" debe recibir el email de activación de cuenta$/ do |email|
  Entonces %{"#{email}" debe recibir 1 email con asunto "Por favor active su nueva cuenta"}
end

Entonces /^"([^\"]*)" debe recibir email de que su cuenta ha sido activada$/ do |email|
  Entonces %{"#{email}" debe recibir 1 email con asunto "Su cuenta ha sido activada"}
end

Entonces /^"([^\"]*)" debe recibir (\d+) email con asunto "([^\"]*)"$/ do |email, n, subject|
  Entonces %{"#{email}" debe recibir #{n} email}

  subjects = unread_emails_for(email).collect { |m| m.subject }
  subjects.should contain(subject)
end

Entonces /^"([^\"]*)" debe recibir (\d+) email$/ do |address, n|
  Then %{"#{address}" should receive #{n} email}
end

Entonces /^debe ver "([^\"]*)" en el mail$/ do |text|
  Then %{I should see "#{text}" in the email}
end
