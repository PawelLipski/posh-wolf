module ApplicationHelper
  
  def get_sample_file(job_cnt, machine_cnt)
    open Rails.root.join('testcases', "tai#{job_cnt}_#{machine_cnt}.txt")
  end
    
end
