
PoshWolf::Application.routes.draw do

  root "main#index"   
  get  "problem" => "main#problem"
  get  "algorithm" => "main#algorithm"
  get  "system" => "main#system"
  get  "about" => "main#about"
  get  "contact" => "main#contact"

  get "taillard" => redirect("http://mistic.heig-vd.ch/taillard/problemes.dir/ordonnancement.dir/ordonnancement.html")

  get "webapp-src" => redirect('http://github.com/tilius/posh-wolf')
  get "webtests-src" => redirect('http://bitbucket.org/bartexki/poshwolftest')
  get "ws-src" => redirect('http://github.com/tilius/posh-wolf-ws')

  post "ajax/post-task-from-pasted" => "ajax#post_task_from_pasted"
  post "ajax/post-task-from-url" => "ajax#post_task_from_url"
  post "ajax/post-task-from-sample" => "ajax#post_task_from_sample"

  get  "ajax/get-all-progresses" => "ajax#get_all_progresses"
  get  "ajax/get-result" => "ajax#get_result"
  get  "ajax/load-animation" => "ajax#load_animation"

  get '*path' => redirect('/') unless Rails.env.development?
end
