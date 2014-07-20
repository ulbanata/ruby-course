class TM::Task
  attr_reader :proj_id, :desc, :priority_num, :id, :complete, :creation

  @@counter = 0

  def initialize(proj_id, desc, priority_num)
    @proj_id = proj_id
    @desc = desc
    @priority_num = priority_num
    @id = @@counter += 1
    @complete = false
    @creation = Time.now
  end

  def mark_complete
    @complete = true
  end
end
