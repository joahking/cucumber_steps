namespace :cuke_steps do
  desc 'wget the step files into features/step_definitions'
  task :install do
    url = 'http://github.com/joahking/cucumber_steps/raw/master/steps/'
    %W(web email).each do |step|
      steps_file = "es_#{step}_steps.rb"
      wget_cmd = "wget -c #{url}/#{steps_file}"
      puts wget_cmd
      `#{wget_cmd}`
      mv_cmd = "mv #{steps_file} features/step_definitions/"
      puts mv_cmd
      `#{mv_cmd}`
    end
  end
end
