module ApplicationHelper
  
  def get_sample_file(job_cnt, machine_cnt)
    open Rails.root.join('testcases', "tai#{job_cnt}_#{machine_cnt}.txt")
  end
    
  def get_taillard_url(job_cnt, machine_cnt)
    "http://mistic.heig-vd.ch/taillard/problemes.dir/ordonnancement.dir/flowshop.dir/tai#{job_cnt}_#{machine_cnt}.txt"
  end

  def get_url_as_file(url)
    require 'open-uri'
    open url
  end
  
  def skip_test_cases(file, how_many, machine_cnt)
    how_many.times { (3 + machine_cnt).times { file.readline } }
  end

end
